//
//  Firebase_test4App.swift
//  Firebase_test4
//
//  Created by Taka on 2024/03/30.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure() // Firebaseの初期化
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct Firebase_test4: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NewAccountView()
        }
    }
}




//2024/04/27
//import SwiftUI
//import FirebaseCore
//import FirebaseAuth
//import GoogleSignIn
//import Firebase
//import FirebaseDatabase
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//            FirebaseApp.configure() // Firebaseの初期化
//        return true
//    }
//
//    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
//        return GIDSignIn.sharedInstance.handle(url)
//    }
//}
//
//@main
//struct Firebase_test4App: App {
//
//    var body: some Scene {
//        WindowGroup {
//            NewAccountView()
//        }
//    }
//}






