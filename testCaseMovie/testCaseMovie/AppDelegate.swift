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
import RESideMenu
import MessageUI


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, JPUSHRegisterDelegate, MFMailComposeViewControllerDelegate {
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        
    }
    
    @available(iOS 10.0, *)
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
        JPUSHService.setup(withOption: launchOptions, appKey: "c85190354f07f74a21b2be10", channel: "apptest1", apsForProduction: true)
        
        
        /*
         
         RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
         leftMenuViewController:leftMenuViewController
         rightMenuViewController:rightMenuViewController];
         sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
         
         // Make it a root controller
         //
         self.window.rootViewController = sideMenuViewController;
         
         */
        
        let sideMenuVC = RESideMenu(contentViewController: UINavigationController(rootViewController: MovieListViewController(nibName: "MovieListViewController", bundle: nil)), leftMenuViewController: MenuViewController(nibName: "MenuViewController", bundle: nil), rightMenuViewController: nil)
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = sideMenuVC //UINavigationController(rootViewController: MovieListViewController(nibName: "MovieListViewController", bundle: nil))
        window?.makeKeyAndVisible()
        
        return true
    }

    func changeMenu(index: Int) {
        //http://itoideal.com/about-us/
        switch index {
        case 0:
            let sideMenuVC = RESideMenu(contentViewController: UINavigationController(rootViewController: MovieListViewController(nibName: "MovieListViewController", bundle: nil)), leftMenuViewController: MenuViewController(nibName: "MenuViewController", bundle: nil), rightMenuViewController: nil)
            self.window?.rootViewController = sideMenuVC
            break
        case 1:
            let sideMenuVC = RESideMenu(contentViewController: UINavigationController(rootViewController: MovieSaveViewController(nibName: "MovieSaveViewController", bundle: nil)), leftMenuViewController: MenuViewController(nibName: "MenuViewController", bundle: nil), rightMenuViewController: nil)
            self.window?.rootViewController = sideMenuVC
            break
        case 2:
            
            let webView = WebViewController(nibName:"WebViewController", bundle:nil)
            webView.otherURL = "http://itoideal.com/about-us/"
            
            let sideMenuVC = RESideMenu(contentViewController: UINavigationController(rootViewController: webView), leftMenuViewController: MenuViewController(nibName: "MenuViewController", bundle: nil), rightMenuViewController: nil)
            self.window?.rootViewController = sideMenuVC
            break;
            
        default:
            changeMenu(index: 0)
            sendEmail()
            break;
        }
        
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["thett01337@hotmail.com"])
            mail.setMessageBody("<p>My feedback: </p>", isHTML: true)
            
            self.window?.rootViewController!.present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
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

