//
//  Challange.swift
//  TebakEnglish
//
//  Created by edo lubis on 04/03/24.
//

import Foundation

struct Challanges: Codable, Identifiable, Equatable {
    let id: String
    var rights: [ChallangeModel]
    var lefts: [ChallangeModel]
}

struct ChallangeModel: Codable, Identifiable, Equatable {
    let id: String
    let text: String
    let idMatch: String
    var isCorrect: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.text = try container.decode(String.self, forKey: .text)
        self.idMatch = try container.decode(String.self, forKey: .idMatch)
        self.isCorrect = try container.decodeIfPresent(Bool.self, forKey: .isCorrect) ?? false
    }
}
