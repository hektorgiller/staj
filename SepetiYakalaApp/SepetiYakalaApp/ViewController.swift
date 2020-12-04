//
//  ViewController.swift
//  SepetiYakalaApp
//
//  Created by Enes Yıldız on 01.09.2020.
//  Copyright © 2020 Enes Yıldız. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var sepetArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    
       
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var sepet1: UIImageView!
    
    @IBOutlet weak var sepet2: UIImageView!
    
    @IBOutlet weak var sepet3: UIImageView!
    
    @IBOutlet weak var sepet4: UIImageView!
    
    @IBOutlet weak var sepet5: UIImageView!
    
    @IBOutlet weak var sepet6: UIImageView!
    
    @IBOutlet weak var sepet7: UIImageView!
    
    @IBOutlet weak var sepet8: UIImageView!
    
    @IBOutlet weak var sepet9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        scoreLabel.text = "Score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        
    
        sepet1.isUserInteractionEnabled = true
        sepet2.isUserInteractionEnabled = true
        sepet3.isUserInteractionEnabled = true
        sepet4.isUserInteractionEnabled = true
        sepet5.isUserInteractionEnabled = true
        sepet6.isUserInteractionEnabled = true
        sepet7.isUserInteractionEnabled = true
        sepet8.isUserInteractionEnabled = true
        sepet9.isUserInteractionEnabled = true

        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))


        sepet1.addGestureRecognizer(recognizer1)
        sepet2.addGestureRecognizer(recognizer2)
        sepet3.addGestureRecognizer(recognizer3)
        sepet4.addGestureRecognizer(recognizer4)
        sepet5.addGestureRecognizer(recognizer5)
        sepet6.addGestureRecognizer(recognizer6)
        sepet7.addGestureRecognizer(recognizer7)
        sepet8.addGestureRecognizer(recognizer8)
        sepet9.addGestureRecognizer(recognizer9)
        
        sepetArray = [sepet1, sepet2, sepet3, sepet4, sepet5, sepet6, sepet7, sepet8, sepet9]
        
        
        //
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideSepet), userInfo: nil, repeats: true)
            

        
    }
    
    // Bu kısımda sepetlerin hareket etmesi için uğratıştım temel olarak rastgele 9 görselden birini açmasını istedim
      @objc func hideSepet() {
        for sepet in sepetArray {
            sepet.isHidden = true
        }
        
       let random = arc4random_uniform(UInt32(sepetArray.count - 1))
        sepetArray[Int(random)].isHidden = false
}
    @objc func increaseScore() {
        
        
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    
    // zaman sayacım 1 saniye arayla azalmakta
    
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        // süre doldu
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            
            for sepet in sepetArray {
                sepet.isHidden = true
            }
            
            //En yüksek Skor Kısmı
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            
            let alert = UIAlertController(title: "Süre Doldu", message: "Tekrar Oynamak İster Misin ?", preferredStyle: UIAlertController.Style.alert) // ekrana uyarı basma
            
            let okButton = UIAlertAction(title: "Hayır", style: UIAlertAction.Style.cancel, handler: nil) //HAYIR
            
            let replayButton = UIAlertAction(title: "Tekrar Oyna", style: UIAlertAction.Style.default) { //tekrar oynama butonu
                (UIAlertAction) in 
                
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true) //self timer şeklinde yazdım
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideSepet), userInfo: nil, repeats: true) //başlarına self koyarak çözdüm
                
            
            }
            //butonlarım oyun bittikten sonra tekrar oynamak isteyip istemediğimi sordurtuyor.
                
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        
            
        }
    }
  
    
    
}











    
    
    
    
    
    
    
    
