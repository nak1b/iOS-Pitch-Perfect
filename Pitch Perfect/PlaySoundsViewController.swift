//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Nakib on 3/11/15.
//  Copyright (c) 2015 Nakib. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var recieveRecordedAudio: RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialing audioplayer with filepath and enabling rate to change speed
        audioPlayer = AVAudioPlayer(contentsOfURL: recieveRecordedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recieveRecordedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        //playing sound slowly
        playAudio(0.5)
    }

    @IBAction func playFastSound(sender: UIButton) {
        //play sound fast
        playAudio(2)
    }
    
    //play sound at speed provided
    func playAudio(r:Float){
        //stop any playing sound
        audioPlayer.stop()
        
        //changing rate or speed of audio playing
        audioPlayer.rate = r
        
        //starting audio from beginning
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
        
    }
    @IBAction func playDarthVanderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    @IBAction func stopSounds(sender: UIButton) {
        //stop playing sounds
        audioPlayer.stop()
    }

}
