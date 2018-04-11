//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Sarah Hernandez on 3/22/18.
//  Copyright © 2018 Sarah Hernandez. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureUI(isRecording: false)

        stopRecordingButton.contentMode = .center
        stopRecordingButton.imageView?.contentMode = .scaleAspectFit
        
        recordButton.contentMode = .center
        recordButton.imageView?.contentMode = .scaleAspectFit
        
        recordLabel.contentMode = .center
        
    }

    @IBAction func Record(_ sender: Any) {
        
        configureUI(isRecording: true)

        recordLabel.text = "Recording in Progress"
        
        let dirpath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recorderVoice.wav"
        let pathArray = [dirpath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }
    
    @IBAction func StopRecording(_ sender: Any) {
        
        configureUI(isRecording: false)

        recordLabel.text = "Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // Enable/Disable UIbuttons based on recording state
    func configureUI(isRecording: Bool){
        
        if isRecording{
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
            
        }else{
            stopRecordingButton.isEnabled = false
            recordButton.isEnabled = true
            
        }
        
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else{
            print("rcording failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController //forced upcast
            let recordedAudioURL = sender as! URL //ask about this line
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}









