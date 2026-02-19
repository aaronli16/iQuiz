//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Aaron Li on 2/18/26.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var answerButton1: UIButton!
    
    @IBOutlet var answerButton2: UIButton!
    
    @IBOutlet var answerButton3: UIButton!
    
    @IBOutlet var answerButton4: UIButton!
    
    @IBOutlet var submitButton: UIButton!
    var quiz: Quiz!
    var currentQuestionIndex = 0
    var selectedAnswerIndex: Int?
    var score = 0

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayCurrentQuestion()
    }
    func displayCurrentQuestion() {
        let question = quiz.questions[currentQuestionIndex]
        
        questionLabel.text = question.text
        
        answerButton1.setTitle(question.answers[0], for: .normal)
        answerButton2.setTitle(question.answers[1], for: .normal)
        answerButton3.setTitle(question.answers[2], for: .normal)
        answerButton4.setTitle(question.answers[3], for: .normal)
        
        // Add these lines to set colors:
        answerButton1.setTitleColor(.white, for: .normal)
        answerButton2.setTitleColor(.white, for: .normal)
        answerButton3.setTitleColor(.white, for: .normal)
        answerButton4.setTitleColor(.white, for: .normal)
        
        selectedAnswerIndex = nil
        resetButtonStyles()
    }

    func resetButtonStyles() {
        
        answerButton1.backgroundColor = .systemBlue
        answerButton2.backgroundColor = .systemBlue
        answerButton3.backgroundColor = .systemBlue
        answerButton4.backgroundColor = .systemBlue
    }
    
    @IBAction func answerButtonTapped(_ sender: Any) {
        print("🔵 Answer button was tapped!")
        guard let button = sender as? UIButton else { return }
            resetButtonStyles()
           
        if button == answerButton1 {
            selectedAnswerIndex = 0
            answerButton1.backgroundColor = .systemGreen
        } else if button == answerButton2 {
            selectedAnswerIndex = 1
            answerButton2.backgroundColor = .systemGreen
        } else if button == answerButton3 {
            selectedAnswerIndex = 2
            answerButton3.backgroundColor = .systemGreen
        } else if button == answerButton4 {
            selectedAnswerIndex = 3
            answerButton4.backgroundColor = .systemGreen
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        print("🟢 Submit button was tapped!")
        
        
        guard let selectedIndex = selectedAnswerIndex else {
            let alert = UIAlertController(title: "No Answer Selected", message: "Please select an answer before submitting.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        
        let question = quiz.questions[currentQuestionIndex]
        let isCorrect = (selectedIndex == question.correctAnswerIndex)
        
        if isCorrect {
            score += 1
        }
        
        print("Answer was \(isCorrect ? "correct" : "incorrect")")
        print("Current score: \(score)")
        
        
        performSegue(withIdentifier: "showAnswer", sender: nil)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAnswer" {
            if let answerVC = segue.destination as? AnswerViewController {
                
                answerVC.quiz = quiz
                answerVC.currentQuestionIndex = currentQuestionIndex
                answerVC.userAnswer = selectedAnswerIndex
                
                let question = quiz.questions[currentQuestionIndex]
                answerVC.isCorrect = (selectedAnswerIndex == question.correctAnswerIndex)
                answerVC.score = score
            }
        }
    }
}
