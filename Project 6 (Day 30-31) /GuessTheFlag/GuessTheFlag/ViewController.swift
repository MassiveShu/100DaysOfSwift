//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Max Shu on 12.10.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!

    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var currentQuestions = 0

        // Challenge 2
    let maxQuestions = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "spain", "uk", "us"]

        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        askQuestion()


    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        // Challenge 2
        if score == maxQuestions {
            showResult()
            return
        }

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

        // Challenge 1
        title = "\(countries[correctAnswer].uppercased()) ? Score: \(score)"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is \(score)"
        } else {
            title = "Wrong"
            score -= 1

        // Challenge 3
            message = """
        You picked: \(countries[sender.tag].uppercased())
        Your score is \(score)
        """
        }

        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))

        present(ac, animated: true)
    }

        // Challenge 2
    func showResult() {
        let ac = UIAlertController(title: "End of the game", message: "Questions asked: \(maxQuestions)\nFinal score: \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Restart game", style: .default, handler: askQuestion))

        score = 0
        correctAnswer = 0
        currentQuestions = 0

        present(ac, animated: true)
    }


}

