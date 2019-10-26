//
//  SwiftFlutterToastPlugin.swift
//  Runner
//
//  Created by 阿明 on 2019/10/26.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

import Flutter
import UIKit

public class SwiftFlutterToastPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_toast", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterToastPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if(call.method.elementsEqual("showToast")){
            let arguments = call.arguments as? NSDictionary
            let msg = arguments!["msg"] as? String
            UIAlertView(title:"", message: msg, delegate: nil, cancelButtonTitle: "OK").show()
            
        }
        
        result("iOS " + UIDevice.current.systemVersion)
    }
}
