//
//  AudioPlayer.swift
//  RestartAppDemo
//
//  Created by Suraj Parshad on 07/02/26.
//

import Foundation
import AVFoundation

var audioPlayer : AVAudioPlayer?

func playSound(sound: String, type :String){

    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do {
            audioPlayer = try AVAudioPlayer.init(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch{
            print("Could not play the sound!.")
        }
        
    }
    
}
