//
//  ViewController.swift
//  CatchKenny
//
//  Created by Veysel Gündüz on 15.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var eywinArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0


    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!

    @IBOutlet weak var eywin1: UIImageView!
    @IBOutlet weak var eywin2: UIImageView!
    @IBOutlet weak var eywin3: UIImageView!
    @IBOutlet weak var eywin4: UIImageView!
    @IBOutlet weak var eywin5: UIImageView!
    @IBOutlet weak var eywin6: UIImageView!
    @IBOutlet weak var eywin7: UIImageView!
    @IBOutlet weak var eywin8: UIImageView!
    @IBOutlet weak var eywin9: UIImageView!
    
    
    override func viewDidLoad() { 
        super.viewDidLoad()
        
        scoreLabel.text = "Score : \(score)"
        
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        eywin1.isUserInteractionEnabled = true
        eywin2.isUserInteractionEnabled = true
        eywin3.isUserInteractionEnabled = true
        eywin4.isUserInteractionEnabled = true
        eywin5.isUserInteractionEnabled = true
        eywin6.isUserInteractionEnabled = true
        eywin7.isUserInteractionEnabled = true
        eywin8.isUserInteractionEnabled = true
        eywin9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        eywin1.addGestureRecognizer(recognizer1)
        eywin2.addGestureRecognizer(recognizer2)
        eywin3.addGestureRecognizer(recognizer3)
        eywin4.addGestureRecognizer(recognizer4)
        eywin5.addGestureRecognizer(recognizer5)
        eywin6.addGestureRecognizer(recognizer6)
        eywin7.addGestureRecognizer(recognizer7)
        eywin8.addGestureRecognizer(recognizer8)
        eywin9.addGestureRecognizer(recognizer9)
        
        eywinArray = [eywin1,eywin2,eywin3,eywin4,eywin5,eywin6,eywin7,eywin8,eywin9]
        
        
        
        //Timers
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideEywin), userInfo: nil, repeats: true)
        hideEywin()
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score : \(score)"
        
    }
    @objc func hideEywin() {
        
        for eywin in eywinArray {
            eywin.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(eywinArray.count - 1)))
        eywinArray[random].isHidden = false
        
    }
    @objc func countDown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
           hideTimer.invalidate()
            
            for eywin in eywinArray {
                eywin.isHidden = true
            }
            
            //HighScore

            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //replay function
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideEywin), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
            
            
        }
        
    }


}

