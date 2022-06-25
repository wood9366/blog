
# Title1 标题1

## Title2 标题2

### Title3 标题3

#### Title4 标题4

##### Title5 标题5

###### Title6 标题6

Title1 标题1
============

Title2 标题2
------------

# Paragraphs

Markdown is a lightweight markup language that you can use to add formatting elements to plaintext text documents. Created by John Gruber in 2004, Markdown is now one of the world’s most popular markup languages.

Using Markdown is different than using a WYSIWYG editor. In an application like Microsoft Word, you click buttons to format words and phrases, and the changes are visible immediately. Markdown isn’t like that. When you create a Markdown-formatted file, you add Markdown syntax to the text to indicate which words and phrases should look different.

# 段落

Markdown 是一种轻量级的标记语言，可用于在纯文本文档中添加格式化元素。Markdown 由 John Gruber 于 2004 年创建，如今已成为世界上最受欢迎的标记语言之一。

使用 Markdown 与使用 WYSIWYG 编辑器不同。在 Microsoft Word 之类的应用程序中，单击按钮以设置单词和短语的格式，并且，更改立即可见。而 Markdown 与此不同，当你创建 Markdown 格式的文件时，可以在文本中添加 Markdown 语法，以指示哪些单词和短语看起来应该有所不同。

# 换行

This is first line.  
This is Second Line.

第一行文本。  
第二行文本。

# 格式

This is **bold text**. Another __bold text__.

这是**粗体**。另一种__粗体__。

This is *italicized text*. Another _italicized text_.

这是*斜体*。另一种_斜体_。

This is ***粗斜体***. Another ___粗斜体___.

这是***粗斜体***。另一种___粗斜体___。

This is ~~deleted text~~.

这是~~删除线~~。

This is ==Highlight==.

这是==高亮==。

This is subscript H~2~O, A~B~C, A~b~, 中文~下标~.

This is superscript X^2^, A^B^, A^b^, 中文^上标^.

# 块

## 单个段落

> Dorothy followed her through many of the beautiful rooms in her castle.

> 天将降大任于是人也，必先苦其心志，劳其筋骨，饿其体肤，空乏其身，行拂乱其所为。

## 多个段落

> Dorothy followed her through many of the beautiful rooms in her castle.
>
> The Witch bade her clean the pots and kettles and sweep the floor and keep the fire fed with wood.

> 天将降大任于是人也，必先苦其心志，劳其筋骨，饿其体肤，空乏其身，行拂乱其所为。
>
> 不以物喜，不已己悲。

## 嵌套

> Dorothy followed her through many of the beautiful rooms in her castle.
>
>> The Witch bade her clean the pots and kettles and sweep the floor and keep the fire fed with wood.
>
> Dorothy followed her through many of the beautiful rooms in her castle.

> 天将降大任于是人也，必先苦其心志，劳其筋骨，饿其体肤，空乏其身，行拂乱其所为。
>
> 不以物喜，不已己悲。
>
> 天将降大任于是人也，必先苦其心志，劳其筋骨，饿其体肤，空乏其身，行拂乱其所为。

# 列表

## 有序列表

1. 条目
2. 条目
   1. 条目
   2. 条目
3. 条目
4. 条目
5. 条目

1. item
   1. item
   2. item
2. item
3. item
4. item
5. item

## 无序列表

- 条目
  - 条目
  - 条目
  - 条目
- 条目
- 条目

- item
  - item
  - item
  - item
- item
- item

## 混合列表

1. 条目
  - 条目
  - 条目
2. 条目
2. 条目

- 条目
- 条目
  1. 条目
  2. 条目
  3. 条目
- 条目

1. item
  - item
  - item
2. item
2. item

- item
- item
  1. item
  2. item
  3. item
- item

## 段落嵌入列表

- This is the first list item.
- Here's the second list item.

    I need to add another paragraph below the second list item.

- And here's the third list item.

## 块嵌入列表

- This is the first list item.
- Here's the second list item.

    > A blockquote would look great below the second list item.

- And here's the third list item.

## 任务列表

- [ ] Task1 任务1
- [x] Task2 任务2
- [ ] Task3 任务3

# 代码

## 短语

At the command prompt, type `nano`.

``Use `code` in your Markdown file.``

## 块

    public class MainLightControl : IEnvControl
    {
        public Light mainLight;
        public Color[] color = new Color[(int)Env.Num];

        public void RecordEnv(Env env)
        {
            if (mainLight == null) return;

            color[(int)env] = mainLight.color;
        }

        public void SetEnv(Env env)
        {
            if (mainLight == null) return;

            mainLight.color = color[(int)env];
        }
    }

## 格式块

```c#
public class MainLightControl : IEnvControl
{
    public Light mainLight;
    public Color[] color = new Color[(int)Env.Num];

    public void RecordEnv(Env env)
    {
        if (mainLight == null) return;

        color[(int)env] = mainLight.color;
    }

    public void SetEnv(Env env)
    {
        if (mainLight == null) return;

        mainLight.color = color[(int)env];
    }
}
```

# 分割线

分割线前

---

分割线后

# 链接

That's [Baidu](www.baidu.com "Baidu Title").

这是[百度](www.baidu.com "百度标题")。

# 图片

![替代文本](https://www.aych.eu/wp-content/uploads/revslider/parallax_header/mountain.png "描述")

# 表格

| Syntax    | Description |   Test Text |
|:----------|:-----------:|------------:|
| Header    | Title       | Here's this |
| Paragraph | Text        |    And more |

# 术语

First Term
: This is the definition of the first term.

Second Term
: This is one definition of the second term.
: This is another definition of the second term.
