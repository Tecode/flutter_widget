<h1 align="center">Flutter 小案例（flutter_widget）</h1>

## 扫码下载
<p align="center">
    <img width="200" title="Flutter" src="./picture/QRCode_258.png">
</p>

## Flutter版本（要注意版本比如1.20.4的版本跑iOS会报找不到引擎）

```dart
Flutter 1.20.4 • channel stable • https://github.com/flutter/flutter.git
Framework • revision fba99f6cf9 (6 days ago) • 2020-09-14 15:32:52 -0700
Engine • revision d1bc06f032
Tools • Dart 2.9.2
```

## 视频背景登录（IOS播放请使用真机调试）

<p align="center">
    <img width="375" title="Flutter" src="./picture/login_video_demo.gif">
</p>

## 仿马蜂窝自适应高度轮播图

<p align="center">
    <img width="375" title="Flutter" src="./picture/auto_height_carousel.gif">
</p>

## 自定义滑动（类似开言英语轮播图）
<p align="center">
    <img width="375" title="Flutter" src="./picture/swipe.gif">
</p>

## 滑动导航变色
<p align="center">
    <img width="375" title="Flutter" src="./picture/stack_navbar.gif">
</p>

## 滑动隐藏导航
<p align="center">
    <img width="375" title="Flutter" src="./picture/collapse_navigation.gif">
</p>

## App状态监听
<p align="center">
    <img width="375" title="Flutter" src="./picture/app_lifecycle_listen.gif">
</p>

## 错误信息

### 打包IOS程序报错

```bash
Warning: CocoaPods installed but not initialized. Skipping pod install.
  CocoaPods is used to retrieve the iOS and macOS platform side's plugin code that responds to your plugin usage on the Dart side.
  Without CocoaPods, plugins will not work on iOS or macOS.
  For more info, see https://flutter.dev/platform-plugins
To initialize CocoaPods, run:
  pod setup
once to finalize CocoaPods' installation.
```

### M1芯片`Podfile`报架构问题

```
# M1芯片
installer.pods_project.build_configurations.each do |config|
  config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
end
```

### 运行`pod setup`

```bash
pod setup
```

