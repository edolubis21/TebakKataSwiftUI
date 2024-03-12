//
//  MyRecordsViewModel.swift
//  TebakEnglish
//
//  Created by edo lubis on 11/03/24.
//

import Foundation

class MyRecordsViewModel: ObservableObject {
    
    @Published var records: [Int:Int] = [:]
    
    let repository = RecordLocalRepository()
    
    func getRecords() {
        if let data = repository.getRecord() {
            records = data
        }
    }
    
    func setRecords(data: [Int:Int]) {
        var dictionary: [Int:Int] = [:]
        if let data = repository.getRecord() {
            dictionary = data
        }
        DispatchQueue.global().async {
            for (key, value) in data {
                if let oldValue = dictionary[key] {
                    if value < oldValue {
                        dictionary[key] = value
                    }
                } else {
                    dictionary[key] = value
                }
            }
            self.repository.saveRecord(data: dictionary)
        }
        
    }
    
}
