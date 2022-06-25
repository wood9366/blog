---
layout: post
title: Unity动画状态过渡参数调整
tag: unity animation
category: unity
---

**Has Exit Time**和其他的条件可以并存，条件来控制状态切换，ExitTime可以保证动画在ExitTime前不被打断

如果不开启ExitTime，那么图示位置的变化不影响动画混合的结果，在不同位置时可以预览不同动画时刻过渡到新动画的效果

**Transition Duration**设置动画混合的总时长

**Transition Offset**可以设置动画切换到目标动画时，混合到目标动画的位置
