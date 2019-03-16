//
//  ViewController.swift
//  Project8
//
//  Created by Mitali Kulkarni on 3/13/19.
//  Copyright © 2019 Mitali Kulkarni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    var numberOfCorrectAnswers = 0
    
    override func loadView() {
        // Big and white empty space
        view = UIView()
        view.backgroundColor = .white
        
        // Score label
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        // UIlabel for clues
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        // contentHuggingPriority is set to 1, means when Auto Layout wants to stretch any views, this will first in line
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(cluesLabel)
        
        // Answer lable
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.textAlignment = .right
        answersLabel.text = "ANSWERS"
        answersLabel.numberOfLines = 0
        // contentHuggingPriority is set to 1, means when Auto Layout wants to stretch any views, this will first in line
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answersLabel)
        
        // Current answer text field
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        // Buttons for Current Answer Field
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
    
        // View to add the buttons for clues
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        // Adding constraints to all the labels and buttons
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            // pin the top of the clues label to the bottom of the score label
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            // pin the leading edge of the clues label to the leading edge of our layout margins, adding 100 for some space
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            // make the clues label 60% of the width of our layout margins, minus 100
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
           
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            // make the answers label stick to the trailing edge of our layout margins, minus 100
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor , constant: -100),
            // make the answers label take up 40% of the available space, minus 100
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            // make the answers label match the height of the clues label
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            // make the currentAnswer textField horizontally center
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // make the currentAnswer textField take up to 50% of the available space
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            // pin the top of the currentAnswer field to the 20 points below of the clueslabel
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            
            // pin the top of submit button to the bottom of currentAnswer
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            // make the submit button horizontally center minus 100, put left by 100 points
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            // make the height of submit button to 44 points
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            // make the clear button horizontally center put right by 100 points
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            // make the clear button aligned with submit button
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            // make the height of submit button to 44 points
            clear.heightAnchor.constraint(equalToConstant: 44),
            
            // Give width and height
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            // Center horizontally
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // Pin bottom to layout margins
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            // Pin the view to bottom of the layoutMarginGuide by minus 20 points
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        
        let width = 150
        let height = 80
        
        for row in 0..<4 {
            for column in 0..<5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("WWW", for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                letterButton.layer.borderWidth = 1.0
                letterButton.layer.borderColor = UIColor.gray.cgColor
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadLevel()
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else {return}
        // firstIndex(of:) will tell us which solution matched their word, then we can use that position to find the matching clue text
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()
            // All we need to do is split the answer label text up by \n, replace the line at the solution position with the solution itself, then re-join the answers label back together.
            var splitAnswer = answersLabel.text?.components(separatedBy: "\n")
            splitAnswer?[solutionPosition] = answerText
            answersLabel.text = splitAnswer?.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            numberOfCorrectAnswers += 1
            
            if numberOfCorrectAnswers % solutions.count == 0 { // instead of checking the score, we check numberOfCorrectAnswers
                let ac = UIAlertController(title: "Well Done!", message: "Are you ready for next level ?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(ac, animated: true, completion: nil)
            }
        } else {
            // If the answer is not present in our solutions give alert
            let ac = UIAlertController(title: "OOPS!", message: "Wrong Answer", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
            score -= 1
        }
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""
        
        for button in activatedButtons {
            button.isHidden = false
        }
        activatedButtons.removeAll()
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFileUrl = Bundle.main.url(forResource: "level\(level)", withExtension: ".txt") {
            if let levelContent = try? String(contentsOf: levelFileUrl) {
                var lines = levelContent.components(separatedBy: "\n")
                lines.shuffle()
                
                for (index,line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")  // LE|PRO|SY: A Biblical skin disease
                    let answer = parts[0] // LE|PRO|SY
                    let clue = parts[1]   // A Biblical skin disease
                    
                    clueString += "\(index+1). \(clue)\n" // 1. A Biblical skin disease
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")  // LEPROSY
                    solutionString += "\(solutionWord.count) letters\n"      // 7 letters
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")   // LE PRO SY
                    letterBits += bits
                }
            }
        }
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterButtons.shuffle()
        if letterButtons.count == letterBits.count {
            for i in 0..<letterButtons.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }
    
    func levelUp (action: UIAlertAction) {
        level += 1
        // Remove all items from the solutions array.
        // Call loadLevel() so that a new level file is loaded and shown.
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        
        // Make sure all our letter buttons are visible.
        for button in letterButtons {
            button.isHidden = false
        }
    }
}

