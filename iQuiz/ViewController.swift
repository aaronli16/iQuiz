//
//  ViewController.swift
//  iQuiz
//
//  Created by Aaron Li on 2/12/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var quizzes: [Quiz] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuizData()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    @objc func handleRefresh() {
        QuizDataManager.shared.fetchQuizzes { result in
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                switch result {
                case .success(let quizzes):
                    self.quizzes = quizzes
                    self.tableView.reloadData()
                case .failure:
                    // Always notify user of network failure
                    self.showNetworkError()
                    if let localQuizzes = QuizDataManager.shared.loadLocalQuizzes() {
                        self.quizzes = localQuizzes
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    func loadQuizData() {
        QuizDataManager.shared.fetchQuizzes { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let quizzes):
                    self.quizzes = quizzes
                    self.tableView.reloadData()
                case .failure:
                    // Always notify user of network failure
                    self.showNetworkError()
                    // Still load from cache if available
                    if let localQuizzes = QuizDataManager.shared.loadLocalQuizzes() {
                        self.quizzes = localQuizzes
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    func showNetworkError() {
        let alert = UIAlertController(
            title: "Network Unavailable",
            message: "Could not fetch quiz data. Using cached data.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    @IBAction func settingsButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: nil, preferredStyle: .alert)
        
        // URL text field
        alert.addTextField { textField in
            textField.text = QuizDataManager.shared.serverURL
            textField.placeholder = "Quiz data URL"
        }
        
        // Check Now button
        alert.addAction(UIAlertAction(title: "Check Now", style: .default) { _ in
            if let url = alert.textFields?.first?.text, !url.isEmpty {
                QuizDataManager.shared.serverURL = url
            }
            self.loadQuizData()
        })
        
        // Open Apple Settings
        alert.addAction(UIAlertAction(title: "Open Settings App", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuestion" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedQuiz = quizzes[indexPath.row]
                print("Segue - passing quiz: \(selectedQuiz.title), questions: \(selectedQuiz.questions.count)")
                if let questionVC = segue.destination as? QuestionViewController {
                    questionVC.quiz = selectedQuiz
                }
            }
        }
    }


}

