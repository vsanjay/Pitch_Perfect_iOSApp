//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by VERDU SANJAY on 15/08/17.
//  Copyright © 2017 VERDU SANJAY. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController{
    
    var audioURL : URL!
    var audioPlayer : AVAudioPlayer!
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
        print(audioURL)
        audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            print(1)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        catch{
            print(error)
        }
        
        
    }

}
