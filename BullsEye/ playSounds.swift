//RohanRenganathan
//   playSounds.swift
//  BullsEye
//
//  Created by Rohan Renganathan on 10/05/2020.
//  Copyright © 2020 Rohan Renganathan. All rights reserved.
//

import Foundation
import AVFoundation


var audioPlayer:AVAudioPlayer?
var audioPlayer1:AVAudioPlayer?


func playInfoSong(sound:String, type:String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
            
        do {
           audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
           audioPlayer?.play()
 //          audioPlayer!.numberOfLoops = -1
                
        } catch {
           print (error)
        }
    }
}


func playWhoosh(sound:String, type:String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
//            audioPlayer!.numberOfLoops = -1
            
        } catch {
            print (error)
        }
    }
}


func playExplosion(sound:String, type:String) {
    
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
            audioPlayer!.numberOfLoops = -1
            
        } catch {
            print (error)
        }
    }
}


func playWiiMusic() {
    
    if let path = Bundle.main.path(forResource: "WiiMusic", ofType: "mp3") {
        
        do {
            audioPlayer1 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer1?.play()
            audioPlayer1!.numberOfLoops = -1
            
        } catch {
            print (error)
        }
    }
}


func pauseWiiMusic(sound:String, type:String) {
    
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        
        do {
            audioPlayer1 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer1?.pause()
            audioPlayer1!.numberOfLoops = -1
            
        } catch {
            print (error)
        }
    }
}


func playTimerSound(sound:String, type:String) {
    
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        
        do {
            audioPlayer1 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer1?.play()
//            audioPlayer!.numberOfLoops = -1
            
        } catch {
            print (error)
        }
    }
}







