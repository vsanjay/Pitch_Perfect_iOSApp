//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by VERDU SANJAY on 15/08/17.
//  Copyright © 2017 VERDU SANJAY. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {
    
    var audioRecorder : AVAudioRecorder!
    
    
    //Status Label to know if audio is recording or not.
    @IBOutlet weak var recordStatusLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.isEnabled = false
    }
    
    @IBAction func recordButtonTapped(_ sender: Any) {
        
        configureUI(recording: true)
        recordStatusLabel.text = "Recording..."
        
        do{
            
            // Create an audio session.
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            
            // Create an URL for the audio file.
            let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String
            let recoringName = "myAudio.m4a"
            let pathArray = [dirPath,recoringName]
            let filePath = URL(string: pathArray.joined(separator: "/"))!
            
            //Create Settings for AudioRecorder
            var settings = [String:AnyObject]()
            settings[AVFormatIDKey] = kAudioFormatMPEG4AAC as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
            // Create AudioRecorder Object
            audioRecorder = try AVAudioRecorder(url: filePath, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
            
        }catch{}
        
        audioRecorder.record()
    }
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        
        configureUI(recording: false)
        recordStatusLabel.text = "Tap to record"
        audioRecorder.stop()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag{
            performSegue(withIdentifier: "GoToPlaySoundsViewController" , sender: self)
        }else{
            print("Recording failed")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "GoToPlaySoundsViewController"){
            
            let destinationVC = segue.destination as! PlaySoundsViewController
            destinationVC.audioURL = audioRecorder.url
            
        }
        
    }
    
    func configureUI(recording : Bool){
        
        recordButton.isEnabled = !recording
        stopButton.isEnabled = recording
    }
    
}

