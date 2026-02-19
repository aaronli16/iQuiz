//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Aaron Li on 2/18/26.
//

import UIKit

class AnswerViewController: UIViewController {
    
    // Data passed from QuestionViewController
    var quiz: Quiz!
    var currentQuestionIndex: Int!
    var userAnswer: Int!
    var isCorrect: Bool!
    var score: Int!
    
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var correctAnswerLabel: UILabel!
    
    @IBOutlet var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayAnswer()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFinished" {
            if let finishedVC = segue.destination as? FinishedViewController {
                finishedVC.quiz = quiz
                finishedVC.score = score
            }
        }
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
       
        currentQuestionIndex += 1
        
       
        if currentQuestionIndex < quiz.questions.count {
            
            if let questionVC = navigationController?.viewControllers.first(where: { $0 is QuestionViewController }) as? QuestionViewController {
                questionVC.currentQuestionIndex = currentQuestionIndex
                questionVC.score = score
            }
            
    
            navigationController?.popViewController(animated: true)
        } else {
              performSegue(withIdentifier: "showFinished", sender: nil)
        }
    }
    func displayAnswer() {
        let question = quiz.questions[currentQuestionIndex]
        
        // Show the question
        questionLabel.text = question.text
        
        // Show result (Correct or Wrong)
        if isCorrect {
            resultLabel.text = "Correct! ✓"
            resultLabel.textColor = .systemGreen
        } else {
            resultLabel.text = "Wrong ✗"
            resultLabel.textColor = .systemRed
        }
        
        // Show the correct answer
        let correctAnswer = question.answers[question.correctAnswerIndex]
        correctAnswerLabel.text = "The correct answer is:\n\(correctAnswer)"
    }
    
}
