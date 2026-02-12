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
            Quiz(title: "EDM", description: "Test your electronic music knowledge!", iconName: "edm"),
            Quiz(title: "Startups", description: "How well do you know startup culture?", iconName: "startups"),
            Quiz(title: "Business", description: "Master the fundamentals of business!", iconName: "business")
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

