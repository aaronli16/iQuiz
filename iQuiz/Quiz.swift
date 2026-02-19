//
//  Quiz.swift
//  iQuiz
//
//  Created by Aaron Li on 2/12/26.
//


import Foundation

struct Quiz {
    let title: String
    let description: String
    let iconName: String
    let questions: [Question]
}

struct Question {
    let text: String
    let answers: [String]
    let correctAnswerIndex: Int
}
