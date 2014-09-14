CRScrollMenu使用说明
====================

## 1. 说明

CRScrollMenu是一个横向可滑动，菜单项底部有指示标志的菜单。

其特点有：

1. 可以设置背景图片
2. 可以设置指示标志的高度跟颜色
3. 支持插入与删除菜单项
4. 菜单项支持subtitle，并且可以分别设置title跟subtitle在正常与选中状态的颜色与字体

## 2. 结构与使用

CRScrollMenu由三个模块组成：

- CRScrollMenuItem：数据源，指定菜单项的title与subtitle
- CRScrollMenuButton：菜单项，根据title与subtitle进行显示，基于UIControl，用selected属性判断菜单项是否被选中（是否选中使用不同的TextAttributes）
- CRScrollMenu：主接口，根据传入的CRScrollMenuItem数组生成对应的Button，并处理菜单项的点击与划动

使用的注意事项：

- `setButtonsByItems:`在配置完CRScrollMenu之后使用，在`setButtonsByItems:`之后设置的属性不会生效
- 设置了背景图片之后，背景颜色将不会被显示出来
- 插入与删除菜单项的时候会自动更新内部ScrollView的contentOffset，当删除的菜单项为选中时，删除后第一项将变成选中项

## 3. TODO

- 点击菜单项时，内部ScrollView的contentOffset的移动算法需要优化
- 使用KVO，与CRScrollMenu配合的ContentView在滑动时，CRScrollMenu的指示标志应该随之动态滑动
