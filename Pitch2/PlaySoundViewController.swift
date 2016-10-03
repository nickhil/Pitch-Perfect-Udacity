//
//  PlaySoundViewController.swift
//  Pitch2
//
//  Created by Nikhil on 28/09/16.
//  Copyright © 2016 Nikhil. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
   
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var echoButton : UIButton!
    @IBOutlet weak var chipmunkButton : UIButton!
    @IBOutlet weak var vaderButton : UIButton!
    @IBOutlet weak var snailButton : UIButton!
    @IBOutlet weak var reverbButton : UIButton!
    @IBOutlet weak var stopButton : UIButton!
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
 
    enum ButtonType: Int { case Fast = 0, Echo, Chipmunk, Vader, Slow, Reverb}
    
    @IBAction func playSoundForButton (sender: UIButton){
        print("playback button pressed")
        switch(ButtonType(rawValue: sender.tag)!){
        case .Slow:
        playSound(rate: 0.5)
        case .Fast:
        playSound(rate: 1.5)
        case .Chipmunk:
        playSound(pitch: 1000)
        case .Vader:
        playSound(pitch: -1000)
        case .Echo:
        playSound(echo: true)
        case .Reverb:
        playSound(reverb: true)
      }
        configureUI(playState: .Playing)
    }
    
    @IBAction func stopButtonPressed (sender: AnyObject)
    {
        print("Stop Button Pressed")
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PlaySoundViewController loaded")
        setupAudio()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(playState: .NotPlaying)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
