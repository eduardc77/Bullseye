//
//  MainViewController.swift
//  Bullseye
//
//  Created by Eduard Caziuc on 19/07/2019.
//  Copyright © 2019 Eduard Caziuc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let startValue = 50
    var targetValue = 0
    var currentValue = 0
    var currentScore = 0
    var currentRound = 0
    var missRate = 0
    var points = 0
    
    @IBOutlet weak var targetValueLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var hitMeButton: UIButton!
    
    @IBOutlet weak var startOverButton: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextRoundPressed()
        updateLabels()
        
        slider.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Normal"), for: .normal)
        slider.setThumbImage(#imageLiteral(resourceName: "SliderThumb-Highlighted"), for: .highlighted)
        let sliderRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let sliderLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackResizeableRightImage = sliderRightImage.resizableImage(withCapInsets: insets)
        let trackResizeableLeftImage = sliderLeftImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackResizeableRightImage, for: .normal)
        slider.setMinimumTrackImage(trackResizeableLeftImage, for: .normal)
    }
    
    @IBAction func showHitMeAlert() {
        
        missRate = abs(currentValue - targetValue)
        
        var title: String = ""
        
        switch missRate {
        case 0: title = "Perfect!"; points = 10
        case 1...10: title = "You almost had it!"; points = 8
        case 11...15: title = "You can do better!"; points = 5
        case 16...25: title = "Not even close..."; points = 2
        default: title = "You're not even trying, aren't you?"; points = 0
        }
        
        currentScore += points
        
        let alert = UIAlertController(title: title, message: "You've hit \(currentValue)" + "\nThe target was \(targetValue)" + "\nYou scored \(points) points", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Next Round", style: .default, handler: { action in self.nextRoundPressed()})
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        slider.setValue(Float(startValue), animated: true)
    }
    
    @IBAction func startOverTapped() {
        
        slider.value = 50
        currentScore = 0
        currentRound = 0
        nextRoundPressed()
    }
    
    @IBAction func infoButtonTapped(_ sender: UIButton) {}
    
    func nextRoundPressed() {
        currentRound += 1
        currentValue = startValue
        targetValue = Int.random(in: 1...100)
        
        updateLabels()
    }
    
    func updateLabels() {
        roundLabel.text = "Round: \(currentRound)"
        scoreLabel.text = "Score: \(currentScore)"
        targetValueLabel.text = String(targetValue)
    }
    @IBAction func moveSlider(slider: UISlider) {
        currentValue = Int(slider.value.rounded())
    }
}
