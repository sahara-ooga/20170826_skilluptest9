//
//  UTRealm.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import RealmSwift
import STV_Extensions

final class UTRealm {
    
    private static let utDirectory = NSSearchPathForDirectoriesInDomains(
        .documentDirectory,
        .userDomainMask,
        true)[0].appendingPathComponent("UnitTest")
    
    /// UT用のRealmConfigurationを生成
    ///
    /// - Returns: UT用のRealmConfiguration
    static func makeRealmConfig() -> Realm.Configuration {
        return Realm.Configuration(fileURL: URL(fileURLWithPath: getUTRealmPath()))
    }
    
    /// Documentsディレクトリ直下にUnitTestディレクトリが存在したら、削除する
    static func removeUTDirectory() {
        
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: utDirectory) { return }
        
        do {
            try fileManager.removeItem(atPath: utDirectory)
        } catch (let error) {
            fatalError("UnitTestディレクトリ削除失敗\n\(error.localizedDescription)")
        }
    }
    
    // MARK: - private methods
    
    /// Documentsディレクトリ直下にUnitTestディレクトリが存在しなければ、生成する
    private static func createUTDirectory() {
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: utDirectory) { return }
        
        do {
            try fileManager.createDirectory(atPath: utDirectory,
                                            withIntermediateDirectories: false,
                                            attributes: nil)
        } catch (let error) {
            fatalError("UnitTestディレクトリ作成失敗\n\(error.localizedDescription)")
        }
    }
    
    /// UT用のrealmのPATHを取得する
    private static func getUTRealmPath() -> String {
        
        createUTDirectory()
        let dateString = Date().toStr(dateFormat: "yyyyMMdd_HH:mm:ss")
        let utTestRealmPath = utDirectory.appendingPathComponent(dateString + ".realm")
        print("UT用のRealmのPATH:\(utTestRealmPath)")
        return utTestRealmPath
    }
}
