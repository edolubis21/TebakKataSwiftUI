//
//  RecordLocal.swift
//  TebakEnglish
//
//  Created by edo lubis on 11/03/24.
//

import Foundation

class RecordLocalRepository {
    
    func saveRecord(data: [Int:Int]) {
        if let records = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(records, forKey: "records")
        }
    }
    
    func getRecord() -> [Int:Int]? {
        if let retrievedData = UserDefaults.standard.data(forKey: "records") {
            if let data = try? JSONDecoder().decode([Int: Int].self, from: retrievedData) {
               return data
            }
        }
        return nil
    }
    
}
