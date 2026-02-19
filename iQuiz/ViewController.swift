//
//  ViewController.swift
//  iQuiz
//
//  Created by Aaron Li on 2/12/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var quizzes: [Quiz] = [
        Quiz(
            title: "EDM",
            description: "Test your electronic music knowledge!",
            iconName: "edm",
            questions: [
                Question(
                    text: "Who is known as the 'King of Trance'?",
                    answers: ["Armin van Buuren", "Tiësto", "Paul van Dyk", "Above & Beyond"],
                    correctAnswerIndex: 0
                ),
                Question(
                    text: "Which festival is the largest EDM event in the world?",
                    answers: ["Ultra Music Festival", "Tomorrowland", "Electric Daisy Carnival", "Coachella"],
                    correctAnswerIndex: 1
                ),
                Question(
                    text: "What does BPM stand for in music production?",
                    answers: ["Beats Per Measure", "Bass Power Mix", "Beats Per Minute", "Binary Pattern Mode"],
                    correctAnswerIndex: 2
                )
            ]
        ),
        Quiz(
            title: "Startups",
            description: "How well do you know startup culture?",
            iconName: "startups",
            questions: [
                Question(
                    text: "What does MVP stand for in startup terminology?",
                    answers: ["Most Valuable Player", "Minimum Viable Product", "Maximum Value Proposition", "Market Validation Process"],
                    correctAnswerIndex: 1
                ),
                Question(
                    text: "Which startup accelerator is considered the most prestigious?",
                    answers: ["Techstars", "500 Startups", "Y Combinator", "AngelPad"],
                    correctAnswerIndex: 2
                ),
                Question(
                    text: "What is a 'unicorn' in startup terminology?",
                    answers: ["A mythical startup that doesn't exist", "A startup valued at over $1 billion", "A founder who starts multiple companies", "A company with perfect product-market fit"],
                    correctAnswerIndex: 1
                )
            ]
        ),
        Quiz(
            title: "Business",
            description: "Master the fundamentals of business!",
            iconName: "business",
            questions: [
                Question(
                    text: "What does ROI stand for?",
                    answers: ["Return On Investment", "Rate Of Interest", "Revenue Over Income", "Risk Of Inflation"],
                    correctAnswerIndex: 0
                ),
                Question(
                    text: "What is a P&L statement?",
                    answers: ["Profit and Loss", "People and Labor", "Product and Logistics", "Planning and Leadership"],
                    correctAnswerIndex: 0
                ),
                Question(
                    text: "What does B2B mean?",
                    answers: ["Back to Basics", "Business to Business", "Buy to Build", "Brand to Buyer"],
                    correctAnswerIndex: 1
                )
            ]
        )
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func settingsButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
        let quiz = quizzes[indexPath.row]
        
        cell.textLabel?.text = quiz.title
        cell.detailTextLabel?.text = quiz.description
        
        // icons
        if indexPath.row == 0 {
            cell.imageView?.image = UIImage(systemName: "music.note.list")
        } else if indexPath.row == 1 {
            cell.imageView?.image = UIImage(systemName: "lightbulb.fill")
        } else {
            cell.imageView?.image = UIImage(systemName: "chart.line.uptrend.xyaxis")
        }
        
        return cell
    }


}

