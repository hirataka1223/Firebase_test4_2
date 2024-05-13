//
//  DatabaseManager.swift
//  Firebase_test4
//
//  Created by Taka on 2024/04/12.
//

import Foundation
import FirebaseDatabase
import Firebase

class DatabaseManager {
    static func saveUserData(selectedSNS: String, selectedGenre: String, accountName: String, fanCount: String, url: String) {
        // FirebaseAppの初期化を確認する
        guard let _ = FirebaseApp.app() else {
            fatalError("FirebaseApp is not initialized. You must call FirebaseApp.configure() in AppDelegate's application(_:didFinishLaunchingWithOptions:) or the @main struct's initializer in SwiftUI.")
        }
        
        // Firebase Realtime Databaseにデータを保存する処理を実装
        let ref = Database.database().reference().child("userData").childByAutoId()
        
        let userData = [
            "selectedSNS": selectedSNS,
            "selectedGenre": selectedGenre,
            "accountName": accountName,
            "fanCount": fanCount,
            "url": url
        ]
        
        ref.setValue(userData) { error, _ in
            if let error = error {
                print("データの保存に失敗しました: \(error.localizedDescription)")
            } else {
                print("データが正常に保存されました")
            }
        }
    }
}

