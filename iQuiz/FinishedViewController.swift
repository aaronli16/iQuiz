//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Aaron Li on 2/18/26.
//

import UIKit

class FinishedViewController: UIViewController {
    
    // Data passed from AnswerViewController
    var quiz: Quiz!
    var score: Int!
    
    @IBOutlet var performanceLabel: UILabel!
    
    
    @IBOutlet var scoreLabel: UILabel!
    
    
    @IBOutlet var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayResults()
    }
    func displayResults() {
        
        let totalQuestions = quiz.questions.count
        let percentage = Double(score) / Double(totalQuestions)
        
        
        scoreLabel.text = "You scored \(score!) of \(totalQuestions)"
        
       
        if percentage == 1.0 {
            performanceLabel.text = "Perfect! 🎉"
            performanceLabel.textColor = .systemGreen
        } else if percentage >= 0.67 {
            performanceLabel.text = "Almost! 👍"
            performanceLabel.textColor = .systemBlue
        } else {
            performanceLabel.text = "Good try! 💪"
            performanceLabel.textColor = .systemOrange
        }
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
