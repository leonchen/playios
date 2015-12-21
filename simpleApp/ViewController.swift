//
//  ViewController.swift
//  simpleApp
//
//  Created by leon chen on 12/19/15.
//  Copyright © 2015 leon chen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    var timer: NSTimer?
    var countdownTimer: NSTimer?
    var countdownCounter = 0
    var counter = 0.0
    var countdownPlayer: AVAudioPlayer?
    var startPlayer: AVAudioPlayer?

    let countdownAudioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("beep-smooth", ofType: "mp3")!)
    let startAudioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("beep-mid", ofType: "mp3")!)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = NSTimer()
        label.text = "Ready"
        btn.addTarget(self, action: Selector("buttonOnClick"), forControlEvents: UIControlEvents.TouchUpInside)
        
        countdownPlayer = try? AVAudioPlayer(contentsOfURL: countdownAudioPath)
        startPlayer = try? AVAudioPlayer(contentsOfURL: startAudioPath)
    }
    func buttonOnClick() {
        if btn.titleForState(UIControlState.Normal) == "Pause" {
            pause()
        } else {
            start()
        }
        
    }
    
    func pause() {
        countdownPlayer!.play()
        timer!.invalidate()
        counter = 0
        btn.setTitle("Start", forState: UIControlState.Normal)
    }
    
    func start() {
        btn.hidden = true
        countdownCounter = 3
        countdownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("countDown"), userInfo: nil, repeats: true)
        countDown()
    }
    
    func run() {
        counter = 0
        startPlayer!.play()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        btn.setTitle("Pause", forState: UIControlState.Normal)
    }
    
    func countDown() {
        label.text = String(countdownCounter)
        if countdownCounter <= 0 {
            btn.hidden = false
            countdownTimer!.invalidate()
            run()
        } else {
            countdownPlayer!.play()
            countdownCounter -= 1
        }
    }
    
    func updateCounter() {
        counter += 0.1
        label.text = String(format: "%.1f", counter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

