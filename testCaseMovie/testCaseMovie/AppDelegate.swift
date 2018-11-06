//
//  AppDelegate.swift
//  testCaseMovie
//
//  Created by admin on 10/30/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import MBProgressHUD
import AVOSCloud
import AdSupport
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, JPUSHRegisterDelegate {
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        
    }
    

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AVOSCloud.setApplicationId("vmYOlP03MVPE2BTX1PkT0ohv-gzGzoHsz", clientKey: "UMJm3zriwzl0lL49HQCyOkiQ")
        application.applicationIconBadgeNumber = 0
        
        if((UIDevice.current.systemVersion as NSString).floatValue >= 8.0) {
            // 可以自定义 categories
            JPUSHService.register(forRemoteNotificationTypes: UIUserNotificationType.badge.rawValue | UIUserNotificationType.badge.rawValue | UIUserNotificationType.alert.rawValue , categories: nil)
        } else {
            JPUSHService.register(forRemoteNotificationTypes: UIUserNotificationType.badge.rawValue | UIUserNotificationType.badge.rawValue | UIUserNotificationType.alert.rawValue , categories: nil)
        }
        JPUSHService.setup(withOption: launchOptions, appKey: "c85190354f07f74a21b2be10", channel: "apptest1", apsForProduction: false)
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: MovieListViewController(nibName: "MovieListViewController", bundle: nil))
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    static func appDelegate () -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func showLoading(){
        let loadingNotification = MBProgressHUD.showAdded(to: (window?.rootViewController?.view)!, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
    }
    
    func hideLoading(){
        MBProgressHUD.hide(for: (window?.rootViewController?.view)!, animated: true)
    }
    
    func showAlertWithMsg(mes: String){
        let alert = UIAlertController(title: "Warning", message: mes, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
        }))
        window!.rootViewController!.present(alert, animated: true, completion: nil)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DidRegisterRemoteNotification"), object: deviceToken)
        JPUSHService.registerDeviceToken(deviceToken)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("error ===================\n==================")
        print(error)
    }
}

