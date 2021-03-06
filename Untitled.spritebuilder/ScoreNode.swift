//
//  ScoreNode.swift
//  Untitled
//
//  Created by Aman Sawhney on 12/26/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation
var soundSrc: ALSoundSource?
var touched = false
class ScoreNode: CCNode {
    
    enum displayState: Double{
        case Streak = 16.0, Perfect = 8.0, Good = 4.0, Fair = 2.0, Poor = 1.0
    }
    
    weak var scoreLabel: CCLabelTTF!
    weak var rotationLabel: CCLabelTTF!
    var delegate: StreakDelegate?
    var booSoundSrc: ALSoundSource?
    var awesome: ALSoundSource?
    var state : displayState = .Perfect {
        didSet{
            if touched != true && touched != false {
                touched = false
            }
            if touched {
                if (soundSrc != nil)
                {
                    soundSrc!.stop()
                }
                switch state{
                case .Streak:
                    delegate?.startStreak()
                    color = CCColor(ccColor3b: ccColor3B(r: 104, g: 0, b: 186))
                    soundSrc = OALSimpleAudio.sharedInstance().playEffect("8bits/goodSound.mp3", volume: 0.1, pitch: 1.0, pan: 0, loop: true)
                    rotationLabel.string = "Streak x16"
                    break
                case .Perfect:
                    delegate?.stopStreak()
                    color = CCColor(ccColor3b: ccColor3B(r: 49, g: 203, b: 0))
                    soundSrc = OALSimpleAudio.sharedInstance().playEffect("8bits/goodSound.mp3", volume: 0.1, pitch: 1.0, pan: 0, loop: true)
                    rotationLabel.string = "Perfect x8"
                    break
                case .Good:
                    delegate?.stopStreak()
                    color = CCColor(ccColor3b: ccColor3B(r: 1, g: 23, b: 104))
                    soundSrc = OALSimpleAudio.sharedInstance().playEffect("8bits/goodSound.mp3", volume: 0.1, pitch: 1.0, pan: 0, loop: true)
                    rotationLabel.string = "Good x4"
                    break
                case .Fair:
                    delegate?.stopStreak()
                    color = CCColor(ccColor3b: ccColor3B(r: 0, g: 166, b: 237))
                    soundSrc = OALSimpleAudio.sharedInstance().playEffect("8bits/Retro Game FX 3.mp3", volume: 0.05, pitch: 1.0, pan: 0, loop: true)
                    rotationLabel.string = "Ok x2"
                    break
                case .Poor:
                    delegate?.stopStreak()
                    color = CCColor(ccColor3b: ccColor3B(r: 246, g: 81, b: 29))
                    soundSrc = OALSimpleAudio.sharedInstance().playEffect("8bits/Retro Game FX 3.mp3", volume: 0.05, pitch: 1.0, pan: 0, loop: true)
                    rotationLabel.string = "Uh-oh! x1"
                    break
                }
            }
        }
    }
    
    
    var streakCounter = 0 {
        didSet{
            if streakCounter >= 50 && state != .Streak{
                state = .Streak
                delegate?.showCompliment()
            }
        }
    }
    
    func didLoadFromCCB(){
        cascadeColorEnabled = true
        state = .Perfect
    }
    
    func displayRotation(rotation: Float){
        if abs(rotation) < 4.5{
            streakCounter++
            if state == .Streak{
                
            } else if abs(rotation) < 1.5 {
                if state != .Perfect{
                    state = .Perfect
                }
            } else {
                if state != .Good{
                    state = .Good
                }
            }
            //handle streak, good, and perfect
        } else if abs(rotation) >= 4.5 && abs(rotation) < 8{
            if state != .Fair{
                state = .Fair
            }
            streakCounter = 0
        } else if abs(rotation) >= 9 {
            if state != .Poor{
                state = .Poor
            }
            streakCounter = 0
        }
    }
    
    func updateScore(score: Double){
        scoreLabel.string = "\(Int(score))"
        let defaults = NSUserDefaults.standardUserDefaults()
        if score > defaults.doubleForKey("highscore") {
            defaults.setDouble(score, forKey: "highscore")
        }
    }
    override func update(delta: CCTime) {
        if !touched {
            rotationLabel.string = "Get started dude!"
            if (soundSrc != nil)
            {
                soundSrc!.stop()
            }
        }
    }
    
}

protocol StreakDelegate{
    func startStreak()
    func stopStreak()
    func showCompliment()
}
