//
//  AppDelegate.swift
//  iOS Deeplink
//
//  Created by Kiran Padhiyar on 16/06/23.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        DynamicLinks.performDiagnostics(completion: nil)
        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
              let url = userActivity.webpageURL,
              let host = url.host else {
            return false
        }
        
        let isDynamicLinkHandled =
        DynamicLinks.dynamicLinks().handleUniversalLink(url) { dynamicLink, error in
            
            guard error == nil,
                  let dynamicLink = dynamicLink,
                  let urlString = dynamicLink.url?.absoluteString else {
                return
            }
            
            print("Dynamic link host: \(host)")
            print("Dyanmic link url: \(urlString)")
            print("Dynamic link match type: \(dynamicLink.matchType.rawValue)")
        }
        return isDynamicLinkHandled
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
            guard let urlString = dynamicLink.url?.absoluteString  else {
                return false
            }
            
            print("Dyanmic link url: \(urlString)")
            print("Dynamic link match type: \(dynamicLink.matchType.rawValue)")
            
            return true
        }
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
            guard let urlString = dynamicLink.url?.absoluteString  else {
                return false
            }
            
            print("Dyanmic link url: \(urlString)")
            print("Dynamic link match type: \(dynamicLink.matchType.rawValue)")
            
            return true
        }
        return true
    }
    
    private func moveToNextPage(url: URL?) {
        let vc = ViewController()
        self.window?.rootViewController?.present(vc, animated: true)
    }
    
}

