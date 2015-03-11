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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
            //converting filepath which is string to type NSUrl
            var filePathUrl = NSURL.fileURLWithPath(filePath)
            
            //Initialing audioplayer with filepath
            audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
            
            //enabling to change rate of audio playing
            audioPlayer.enableRate = true
            
        }else{
            print("File path is empty")
        }
        // Do any additional setup after loading the view.
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
    
    @IBAction func stopSounds(sender: UIButton) {
        //stop playing sounds
        audioPlayer.stop()
    }

}
