//
//  Query.swift
//  QuizeTest
//
//  Created by Ranjit Mahto on 17/02/24.
//

import Foundation

// MARK: - RootModel
struct Query : Codable, Hashable {
    
    var id: String
    var question: String
    var modifiedDate: String
    var ans1: String
    var ans2: String
    var ans3: String
    var ans4: String
    var ans5: String
    var addedDate: String
    var status: String
    var correct: String
    var userSelAnswer: String = "none"
    
    enum CodingKeys: String, CodingKey {
        case id
        case question
        case modifiedDate = "modified_date"
        case ans1
        case ans2
        case ans3
        case ans4
        case ans5
        case addedDate = "added_date"
        case status
        case correct
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        question = try container.decode(String.self, forKey: .question)
        modifiedDate = try container.decode(String.self, forKey: .modifiedDate)
        ans1 = try container.decode(String.self, forKey: .ans1)
        ans2 = try container.decode(String.self, forKey: .ans2)
        ans3 = try container.decode(String.self, forKey: .ans3)
        ans4 = try container.decode(String.self, forKey: .ans4)
        ans5 = try container.decode(String.self, forKey: .ans5)
        addedDate = try container.decode(String.self, forKey: .addedDate)
        status = try container.decode(String.self, forKey: .status)
        correct = try container.decode(String.self, forKey: .correct)
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary[CodingKeys.modifiedDate.rawValue] = modifiedDate
        dictionary[CodingKeys.ans4.rawValue] = ans4
        dictionary[CodingKeys.question.rawValue] = question
        dictionary[CodingKeys.ans1.rawValue] = ans1
        dictionary[CodingKeys.correct.rawValue] = correct
        dictionary[CodingKeys.ans5.rawValue] = ans5
        dictionary[CodingKeys.id.rawValue] = id
        dictionary[CodingKeys.ans3.rawValue] = ans3
        dictionary[CodingKeys.addedDate.rawValue] = addedDate
        dictionary[CodingKeys.ans2.rawValue] = ans2
        dictionary[CodingKeys.status.rawValue] = status
        return dictionary
    }
}

struct AnswerOption {
    var ansCode: String
    var ansValue: String
    
    init(ansCode: String, ansValue: String) {
        self.ansCode = ansCode
        self.ansValue = ansValue
    }
}
