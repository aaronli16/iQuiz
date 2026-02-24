//
//  Quiz.swift
//  iQuiz
//
//  Created by Aaron Li on 2/12/26.
//

import Foundation

struct Question: Codable {
    let text: String
    let answers: [String]
    let correctAnswerIndex: Int
    
    enum CodingKeys: String, CodingKey {
        case text
        case answers
        case correctAnswerIndex = "answer"
    }
    
    init(text: String, answers: [String], correctAnswerIndex: Int) {
        self.text = text
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: .text)
        answers = try container.decode([String].self, forKey: .answers)
        let answerString = try container.decode(String.self, forKey: .correctAnswerIndex)
        correctAnswerIndex = (Int(answerString) ?? 1) - 1  // Convert "1" → 0, "2" → 1, etc.
    }
    
    // Needed since we wrote a custom init(from:)
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
        try container.encode(answers, forKey: .answers)
        try container.encode(String(correctAnswerIndex + 1), forKey: .correctAnswerIndex)
    }
}

struct Quiz: Codable {
    let title: String
    let description: String
    let iconName: String
    let questions: [Question]
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "desc"
        case questions
        case iconName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        questions = try container.decode([Question].self, forKey: .questions)
        iconName = Quiz.iconName(for: title)
    }
    
    
    init(title: String, description: String, iconName: String, questions: [Question]) {
        self.title = title
        self.description = description
        self.iconName = iconName
        self.questions = questions
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(questions, forKey: .questions)
    }
    
    
    static func iconName(for title: String) -> String {
        switch title {
        case "Science!": return "flask.fill"
        case "Marvel Super Heroes": return "bolt.fill"
        case "Mathematics": return "sum"
        default: return "questionmark.circle.fill"
        }
    }
}
