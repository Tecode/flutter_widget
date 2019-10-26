//
//  ConfigurationHelper.swift
//  BrainScientist_Business
//
//  Created by 沈鑫 on 2019/3/19.
//  Copyright © 2019 BrainScientist. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import AVFoundation
import Kingfisher

let sdkAppid = 1400194089
let sdkAccountType = "36862"
let identifier = "krcm110"
let userSig = "eJxlj11PgzAYhe-5FaTXRltKNzHZxaZuUTcMMCTuhhTaSkPooBT8iv-diBqb*N4*T84577vjui7Yb5NTWpbHQZncvLYcuBcugODkD7atZDk1OdbsH*QvrdQ8p8JwPUFECPEgtB3JuDJSyB*j1mWDkC30rM6nlu8EH0IU*PA8sBX5NMHddXR5sxlnWX3ISpEqL0RXfkIaWg1VWse3VTEcYpEGKuzul2cP66VcZWPbNX0x6m2UvXVRHG7kKiRire7i5wbvkseC0XlVp-0*WiysSiMb-vsSxnBOZvagketeHtUkeBAR5GH4dcD5cD4BFpdeiA__"
/** 高德地图appkey*/
let mapApiKey = "5e9242e82a4c9bf3951cc6f1f33a3287"
let JPUSH_APPKEY = "1e276f53606380ff031e22ed"
let channelKey = "BrainScientist-iOS";

class ConfigurationHelper: NSObject, WXApiDelegate {
    
    var shareHandler: (( _ resp: BaseResp) -> Void)?
    
    /** 单例*/
    static let shared = ConfigurationHelper()
    
    class func initializeConfiguration() {
        self.networkChange()
        self.userInterfaceConfiguration()
//        self.keyboardManagerConfiguration()
        VersionRefreshHelper.shared.logout()
        self.progressHUDConfiguration()
        self.ShareSDKConfiguration()
        self.TIMConfiguration()
        self.AMapServicesConfiguration()
        self.BuglyConfiguration()
        if !VersionRefreshHelper.shared.isGoingAppFrist {
            VersionRefreshHelper.shared.isGoingAppFrist = true
        } else {
            if !self.isUserNotificationEnable() {
                SystemAler.shared.show("“脑学家”想给您发送通知", "您的手机需要开启通知权限之后才能正常接收通知。", ["取消","去设置"]) { (index) in
                    if index == 0 {
                        
                    } else {
                        self.goToAppSystemSetting()
                    }
                }
            }
        }
    }
    
    class func resetRoot() -> UIViewController {
        if UserInfoHelper.shared.addNickname {
            let nicknameVC = LoginChangeNickNameViewController(nibName: "LoginChangeNickNameViewController", bundle: nil)
            nicknameVC.businessUser = UserInfoHelper.shared.businessUser
            let rootNav = BaseNavigationController.init(rootViewController: nicknameVC)
            rootNav.navigationBar.isHidden = true
            return rootNav
        } else {
            if UserInfoHelper.shared.isLogin {
                let rootNav = BaseNavigationController.init(rootViewController: RootTabBarController())
                rootNav.navigationBar.isHidden = true
                return rootNav
            } else {
                let loginNav = BaseNavigationController.init(rootViewController: LoginViewController.init(nibName: "LoginViewController", bundle: nil))
                loginNav.navigationBar.isHidden = true
                return loginNav
            }
        }
    }
    
    /** 判断用户是否允许接受通知消息*/
    class func isUserNotificationEnable() -> Bool {
        var isEnable: Bool = false
        let setting = UIApplication.shared.currentUserNotificationSettings
        isEnable = (UIUserNotificationType.init(rawValue: 0) == setting!.types) ? false : true
        return isEnable
    }
    //MARK: 跳转到设置页面
    class func goToAppSystemSetting() {
        let application = UIApplication.shared
        let url = URL.init(string: UIApplication.openSettingsURLString)
        if application.canOpenURL(url!) {
            if #available(iOS 10.0, *) {
                application.open(url!, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                application.openURL(url!)
            }
        }
    }
    
    class func JPUSHConfiguration(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?, delegate: JPUSHRegisterDelegate) {
        
        let entity = JPUSHRegisterEntity()
        if #available(iOS 12.0, *) {
            entity.types = Int(JPAuthorizationOptions.alert.rawValue|JPAuthorizationOptions.badge.rawValue|JPAuthorizationOptions.sound.rawValue|JPAuthorizationOptions.providesAppNotificationSettings.rawValue)
        } else {
            // Fallback on earlier versions
        }
        JPUSHService.registrationIDCompletionHandler { (retCode, registrationID) in
            if retCode == 0 {
                USERDEFAULTS.set(registrationID, forKey: "registrationID")
                USERDEFAULTS.synchronize()
            } else {
                USERDEFAULTS.set("", forKey: "registrationID")
                USERDEFAULTS.synchronize()
            }
            
            if #available(iOS 10.0, *) {
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: (UNAuthorizationOptions(rawValue: UNAuthorizationOptions.alert.rawValue + UNAuthorizationOptions.sound.rawValue)), completionHandler: { (granted, error) in
                    
                })
            } else {
                let settings = UIUserNotificationSettings.init(types: .badge, categories: nil)
                UIApplication.shared.registerUserNotificationSettings(settings)
                application.registerForRemoteNotifications()
            }
        }
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: delegate)
        JPUSHService.setup(withOption: launchOptions, appKey: JPUSH_APPKEY, channel: channelKey, apsForProduction: false)
    }
    
    private class func BuglyConfiguration() {
        Bugly.start(withAppId: "d1e2f2b658")
    }
    
    /** 设置UITabBarItem属性*/
    private class func userInterfaceConfiguration() {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], for: .selected)
    }
    
    /** 设置IQKeyboardManager*/
    private class func keyboardManagerConfiguration() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = false
    }
    
    /** 设置SVProgressHUD*/
    private class func progressHUDConfiguration() {
    }
    
    /** shareSDK*/
    private class func ShareSDKConfiguration() {
        WXApi.registerApp("wx5e7cbffb0621d349")
    }
    
    class func wxHandleOpenURL(url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate: ConfigurationHelper.shared)
    }
    
    /** 清除缓存*/
    class func cleanCache() {
        SDImageCache.shared.clearDisk(onCompletion: nil)
        SDImageCache.shared.clearMemory()
        KingfisherManager.shared.cache.clearDiskCache()
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.cleanExpiredDiskCache()
    }
    
    /** 计算缓存大小*/
    class func cacheCountData() -> String {
        let imageCache: CGFloat = CGFloat(KingfisherManager.shared.cache.maxDiskCacheSize / (1024*1024))
        let sdImageCache: CGFloat = CGFloat(SDImageCache.shared.totalDiskSize() / (1024*1024))
        return String.init(format: "%.1lfMB", imageCache+sdImageCache)
    }
    
    
    
    private class func AMapServicesConfiguration() {
        AMapServices.shared()?.apiKey = mapApiKey
    }
    
    private class func TIMConfiguration() {
        TUIKit.sharedInstance()?.setup(withAppId: sdkAppid)
    }
    
    private class func networkChange(){
        RequestHelper.startListening { (status) in
            if (status == NetworkStatus.unknown || status == NetworkStatus.notReachable) {
                YJYHUD.show("亲，似乎已断开互联网链接!")
            }
        }
    }
    
    /** WXApiDelegate*/
    func onResp(_ resp: BaseResp) {
        if self.shareHandler != nil {
            self.shareHandler!(resp)
        }
    }
}

