CRScrollMenuController使用说明
==============================

## 1. 说明

CRScrollMenu是一个横向可滑动，菜单项底部有指示标志的菜单，CRScrollMenuController包含CRScrollMenu，并且是菜单项对应Content View Controller的容器，这些View Controller之间也是可以横向滑动的。

其特点有：

1. 可以设置CRScrollMenu的背景图片
2. 可以设置CRScrollMenu指示标志的高度跟颜色
3. 支持插入与删除菜单项
4. 菜单项支持subtitle，并且可以分别设置title跟subtitle在正常与选中状态的颜色与字体
5. CRScrollMenuController作为容器包含了内容ViewController与CRScrollMenu，统一管理，方便使用
6. CRScrollMenu可以在没有CRScrollMenuController的情况下使用

## 2. 结构

CRScrollMenu由以下模块组成：

- CRScrollMenuItem：数据源，指定菜单项的title与subtitle
- CRScrollMenuButton：菜单项，根据title与subtitle进行显示，基于UIControl，用selected属性判断菜单项是否被选中（是否选中使用不同的TextAttributes）
- CRScrollMenu：滑动菜单，根据传入的CRScrollMenuItem数组生成对应的Button，并处理菜单项的点击与划动
- CRScrollMenuController：ViewController的容器，管理Content View Controller（这些Controller的view全部包含在一个ScrollView中），并根据传入的CRScrollMenuItem初始化CRScrollMenu

## 3. 使用

### 版本要求：

- iOS SDK 7 or later
- Xcode 5 or later

### 安装

可以通过[CocoaPods](http://cocoapods.org/)进行安装，在你的`Podfile`中加入`pod 'CRScrollMenuController'`，然后`pod update`即可

### 如何使用

参见项目中CRViewController的viewDidLoad代码

使用的注意事项：

- 对于CRScrollMenu，`setButtonsByItems:`在配置完CRScrollMenu之后使用，在`setButtonsByItems:`之后设置的属性不会生效。基于这个原因，CRScrollMenuController中的`setViewControllers:withItems:`也是一样
- CRScrollMenu设置了背景图片之后，背景颜色将不会被显示出来
- CRScrollMenu插入与删除菜单项的时候会自动更新内部ScrollView的contentOffset，当删除的菜单项为选中时，删除后第一项将变成选中项

## 4. TODO

- 点击菜单项时，CRScrollMenu内部ScrollView的contentOffset的移动算法需要优化
- ~~使用KVO，ContentView在滑动时，CRScrollMenu的指示标志应该随之动态滑动~~

## 5. 作者

尚传人(Joe Shang)，邮箱为shangchuanren@gmail.com，CRScrollMenu基于MIT license，具体见LICENSE文件
