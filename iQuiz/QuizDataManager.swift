//
//  QuizDataManager.swift
//  iQuiz
//
//  Created by Aaron Li on 2/23/26.
//

import Foundation

class QuizDataManager {
    
    static let shared = QuizDataManager()
    
    private let defaultURL = "http://tednewardsandbox.site44.com/questions.json"
    private let localFileName = "questions.json"
    
    
    private var localFileURL: URL {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return docs.appendingPathComponent(localFileName)
    }
    
    
    var serverURL: String {
        get { UserDefaults.standard.string(forKey: "quiz_url") ?? defaultURL }
        set { UserDefaults.standard.set(newValue, forKey: "quiz_url") }
    }
    
    // MARK: - Fetch from network
    func fetchQuizzes(completion: @escaping (Result<[Quiz], Error>) -> Void) {
        guard let url = URL(string: serverURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
            do {
                let quizzes = try JSONDecoder().decode([Quiz].self, from: data)
                self.saveLocally(data: data)  // Cache it
                completion(.success(quizzes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    private func saveLocally(data: Data) {
        try? data.write(to: localFileURL)
    }
    
    // MARK: - Load from local storage
    func loadLocalQuizzes() -> [Quiz]? {
        guard let data = try? Data(contentsOf: localFileURL) else { return nil }
        return try? JSONDecoder().decode([Quiz].self, from: data)
    }
}
