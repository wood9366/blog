---
layout: post
title: Unity光照图混合研究笔记
tag: unity package
category: unity
---

# 需求
用来实现日夜灯光效果的动态过渡

# 思路
用Unity的GI系统烘培出Lightmap并单独保存，然后用某种方式混合不同的光照图，在渲染物件是应用新的光照图

# 实现

## 使用替换光照图的方式实现
在内存中生成一组Texture2D光照图，混合生成这组光照图中的内容，然后修改整个光照图组

优点：
1. 使用Unity默认的光照模型和GI系统，不需要修改Shader和管理GI的物件

### Unity中光照图的替换
设置LightmapSettings.lightmaps就可以替换不同的关照图组

### 光照图的混合

#### GPU方式混合
尝试使用Graphics.Blit来混合光照图

混合流程：
1. 生成使用BlendLightmap的Shader的材质，并设置两张混合的光照图和混合参数
2. 准备RenderTexture，支持HDR
3. 调用Graphics.Blit混合指定的光照图到RenderTexture
4. 由于lightmaps的设置只能使用Texture2D，需要获取混合的RenderTexture并存入Texture2D

使用的Shader如下：

```glsl
Shader "Custom/BlendLightmap"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            uniform sampler2D _SubTex;
            uniform float _Factor;

            half4 frag (v2f i) : SV_Target
            {
                half4 a = tex2D(_MainTex, i.uv);
                half4 b = tex2D(_SubTex, i.uv);

                half4 c;

                c.rgb = lerp(a, b, saturate(_Factor));
                c.a = 1;

                return c;
            }
            ENDCG
        }
    }
}
```

问题：
1. RenderTexture是否支持HDR
2. Unity使用光照图时根据设置会使用不同品质的光照图编码，所以在RT保存为Texture2D时需要使用对应的编码方式，而这种编码方式是不清楚的。官方的Shader中只能看到解码的方式

测试1：

设置为高品质HDR

使用Shader
```
half4 frag (v2f i) : SV_Target
{
    half4 a = tex2D(_MainTex, i.uv);
    half4 b = tex2D(_SubTex, i.uv);

    half4 c;

    c.rgb = lerp(a, b, saturate(_Factor));
    c.a = 1;

    return c;
}
```

光照图格式为TextureFormat.RGBAHalf

设置RT为DefaultHDR，渲染时出错，`Remapping between format 74 -> 73 is not supported`
设置RT为Default，可渲染，但亮度表现跟之前不同，会丢失亮度值
设置RT为ARGBHalf，可渲染，表现正常

光照图格式为RGB9e5Float，RT为ARGBHalf，也能正常工作

测试2：

设置为中品质

使用Shader和光照图格式同高品质

设置RT为ARGBHalf，可渲染，亮度表现不同

可能的解决方式：
1. 把光照图格式更换成对应中品质的格式
2. 从RT转存入光照图时进行关照图编码RGBM

测试在GPU中解码和CPU(转存)中解码的效果相同

使用Shader
```
half4 frag (v2f i) : SV_Target
{
    half4 a = tex2D(_MainTex, i.uv);
    half4 b = tex2D(_SubTex, i.uv);

    half4 c;

    c.rgb = lerp(a, b, saturate(_Factor));

    half m = max(max(c.r, c.g), c.b);

    c.rgb /= m;
    c.a = m;

    return c;
}
```

由于在GPU中解码可以设置RT为ARGB32, 设置光照图格式为RGBA32

光照表现依然不同，可能是编码的方式不对

细节1:

混合光照图的Shader使用时传入的unity\_Lightmap\_HDR不是正确的解码参数，貌似是固定的(1,1,0,0)

修改Shader调用指定decodeInstruction版本的DecodeLightmap函数，修复混合光照图的问题

细节2:

使用混合的光照图渲染物件时，传入的unity\_Lightmap\_HDR也不是正确的参数，不论品质的选择如何，固定为(1,1,0,0)

这也是为什么之前高品质下正确，因为高品质下不使用这个参数

不论任何品质的光照图都用固定光照图格式的RGB9e5Float（高品质的光照图格式，无编码），再使用时不需要解码

需要进一步确认的是在使用混合光照图渲染时HDR品质相关的宏是否正确？

#### ~~CPU方式混合~~
如果RT不支持HDR，可使用Texture2D的GetPixel和SetPixel来混合贴图

问题：
1. 同样需要知道光照图的编码方式

设置为高品质HDR，光照图直接使用16位Float不会有特殊编码

使用GetPixel，用Color.Lerp混合，并用SetPixel设置能生成正确的HDR贴图并实现混合关照图的效果

## 自定义光照模型可指定多张光照图并实时混合
优点：
1. 不需要知道光照图的编码方式，直接用DecodeLightmap解码就行

缺点：
1. 不能使用Unity默认的光照系统

### 多物件同时切换用不同的Shader渲染
