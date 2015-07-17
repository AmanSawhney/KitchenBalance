//
//  StartScene.swift
//  Untitled
//
//  Created by Gagandeep Sawhney on 7/16/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class StartScene: CCScene {
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func play() {
        animationManager.runAnimationsForSequenceNamed("Play Timeline")
        delay(1.5) {
            var difficultLevel : CCScene =  CCBReader.loadAsScene("DifficultLevel")
            CCDirector.sharedDirector().replaceScene(difficultLevel)
        }
    }
    func stats() {
        animationManager.runAnimationsForSequenceNamed("Stats Timeline")
    }
    func leaderBoard() {
        
    }
    func facebook() {
        
    }
    func twitter() {
        
    }
    func info() {
        
    }
}