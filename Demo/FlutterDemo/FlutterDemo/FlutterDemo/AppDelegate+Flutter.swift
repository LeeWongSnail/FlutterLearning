//
//  AppDelegate+Flutter.swift
//  FlutterDemo
//
//  Created by LeeWong on 2022/11/26.
//

import Foundation
import FlutterPluginRegistrant;
//
//extension AppDelegate: FlutterAppLifeCycleProvider {
//    
//    func add(_ delegate: FlutterApplicationLifeCycleDelegate) {
//        FlutterManager.shared.lifeCycleDelegate.add(delegate)
//    }
//}
//
///// 这些方法当一整个App都是flutter的时候才需要使用
//extension AppDelegate {
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        
//    }
//}
//
//extension AppDelegate {
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        FlutterManager.shared.lifeCycleDelegate.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
//    }
//    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        FlutterManager.shared.lifeCycleDelegate.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
//    }
//    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        return FlutterManager.shared.lifeCycleDelegate.application(app, open: url, options: options)
//    }
//    
//    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
//        return FlutterManager.shared.lifeCycleDelegate.application(application, handleOpen: url)
//    }
//    
//    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
//        FlutterManager.shared.lifeCycleDelegate.application(application, performActionFor: shortcutItem, completionHandler: completionHandler)
//    }
//    
//    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
//        FlutterManager.shared.lifeCycleDelegate.application(application, handleEventsForBackgroundURLSession: identifier, completionHandler: completionHandler)
//    }
//    
//    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        FlutterManager.shared.lifeCycleDelegate.application(application, performFetchWithCompletionHandler: completionHandler)
//    }
//}
