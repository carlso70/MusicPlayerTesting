//
//  ViewController.swift
//  Music Player
//
//  Created by Jimmy Carlson on 11/5/15.
//  Copyright © 2015 Jimmy Carlson. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var timer = NSTimer() //use this to make the song scrubber keep up with the time
    
    var player: AVAudioPlayer = AVAudioPlayer()

    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var songTimeSlider: UISlider!
    
    @IBAction func adjustVolume(sender: AnyObject) {
        player.volume = volumeSlider.value
    }
    
    @IBAction func scrubThroughSong(sender: AnyObject) {
        
        player.currentTime = NSTimeInterval(songTimeSlider.value)
    }
    
    @IBAction func play(sender: AnyObject) {
        player.play()
        
    }
    
    @IBAction func stop(sender: AnyObject) {
        player.pause()
        
        do {
            
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("01 Live to Rise", ofType: "m4a")!))
            
        }catch {
            
            print("It didn't work")
        }
        
    }
    
    func updateScrubSlider() {
        
        songTimeSlider.value = Float(player.currentTime)
        
    }
    
    @IBAction func pause(sender: AnyObject) {
        player.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Queue up the file
        
        do {
            
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("01 Live to Rise", ofType: "m4a")!))
            
            songTimeSlider.maximumValue = Float(player.duration)
            songTimeSlider.minimumValue = 0.0
            
            
        }catch {
            
            print("It didn't work")
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateScrubSlider"), userInfo: nil, repeats: true) //bascially this updates every second to make the song time slider the same value of the current time of the song, dont actually do all the time stuff
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

