//
//  RecordSoundViewController.swift
//  Pitch2
//
//  Created by Nikhil on 28/09/16.
//  Copyright © 2016 Nikhil. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController , AVAudioRecorderDelegate {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    var audioRecorder:AVAudioRecorder!
 
    @IBAction func startRecord(_ sender: AnyObject) {
        recordLabel.text = "Recording"
        startButton.isEnabled = false
        stopButton.isEnabled = true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        print(filePath)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag){
          //  print("I am here")
                self.performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
                print("Saving of recording failed")
        }
        print("audio recorder did finish")
    }

    @IBAction func stopRecord(_ sender:UIButton ) {
        print("stop record pressed")
        recordLabel.text = "Tap to Record"
        stopButton.isEnabled = false
        startButton.isEnabled = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       stopButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        print("View will Appear")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "stopRecording") {
            let playSoundVC = segue.destination as!
            PlaySoundViewController
            let recordedAudioURL = sender as! NSURL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
     }
 }
