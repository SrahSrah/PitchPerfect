//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Sarah Hernandez on 4/2/18.
//  Copyright © 2018 Sarah Hernandez. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    
    
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var slow: UIButton!
    @IBOutlet weak var fast: UIButton!
    @IBOutlet weak var high: UIButton!
    @IBOutlet weak var low: UIButton!
    @IBOutlet weak var echo: UIButton!
    @IBOutlet weak var reverb: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: Actions
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        print("Play Sound Button Pressed")
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        print("Stop Audio Button Pressed")
        stopAudio()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Makes buttons fit for all iphone/ipad sizes, prevents button squishing
        stop.contentMode = .center
        stop.imageView?.contentMode = .scaleAspectFit
        slow.contentMode = .center
        slow.imageView?.contentMode = .scaleAspectFit
        fast.contentMode = .center
        fast.imageView?.contentMode = .scaleAspectFit
        high.contentMode = .center
        high.imageView?.contentMode = .scaleAspectFit
        low.contentMode = .center
        low.imageView?.contentMode = .scaleAspectFit
        echo.contentMode = .center
        echo.imageView?.contentMode = .scaleAspectFit
        reverb.contentMode = .center
        reverb.imageView?.contentMode = .scaleAspectFit

        //Setup Audio
        setupAudio()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // call to func that will disable stop button when it appears
        configureUI(.notPlaying)
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
