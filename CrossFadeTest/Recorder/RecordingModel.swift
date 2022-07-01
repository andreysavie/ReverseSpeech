//
//  RecordingModel.swift
//  CrossFadeTest
//
//  Created by Андрей Рыбалкин on 29.06.2022.
//

import Foundation
import AVFoundation


class RecordingModel: NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    private var recordingSession: AVAudioSession!
    private var audioRecorder: AVAudioRecorder!
    
    private var player = AVAudioPlayer()
    private var playTimer: Timer?
    private var isRecordAvalible = false
    
    
    override init () {
        super.init()
        
        setRecordingSession()
//
//        recordButton.tapAction = { [weak self] in
//            self?.recordAudioAction()
//        }
//
//        playPauseButton.tapAction = { [weak self] in
//            self?.playRecordedAudioAction()
//        }
//
//        reverseButton.tapAction = { [weak self] in
//            self?.reverseButtonAction()
//        }
//
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRecordingSession() {
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        //MARK: NOTIFY TO VIEW
//                        self.recordButton.alpha = 1
//                        self.recordButton.isEnabled = true
                        self.isRecordAvalible = true
                    } else {
                        print ("failed to record!")
                    }
                }
            }
        } catch {
            print ("failed to record!")
        }
    }
    
    func startRecording() {
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: getFileUrl(), settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            //MARK: NOTIFY TO VIEW
//            recordButton = AudioButton(.stop)
            
        } catch {
            stopRecording(success: false)
        }
    }
    
    func stopRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        //MARK: NOTIFY TO VIEW
//        recordButton = AudioButton(.record)
        
        if success {
            print("Audio is succefully recorded!")
        } else {
            print("Error of recording!")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getFileUrl() -> URL {
        let filename = "recording.m4a"
        let filePath = getDocumentsDirectory().appendingPathComponent(filename)
        return filePath
    }
    
    //MARK: PLAYER =======================
    
    private func setTrack() {
        
        do {
            try player = AVAudioPlayer(contentsOf: getFileUrl())
            player.delegate = self
            player.prepareToPlay()
            
        } catch { print(error.localizedDescription) }
    }
    
    
    private func runPlayerTimer() {
        playTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkPlayer), userInfo: nil, repeats: true)
    }
    
    @objc
    private func checkPlayer() {
        if !player.isPlaying {
            //MARK: NOTIFY TO VIEW
//            playPauseButton = AudioButton(.play)
            playTimer?.invalidate()
            playTimer = nil
        }
    }
    
    // MARK: RECORDER METHODS ===============================================================================================
    
    func recordAudioAction() {
        if audioRecorder == nil {
            startRecording()
        } else {
            stopRecording(success: true)
        }
    }
    
    func playRecordedAudioAction() {
        
        if player.isPlaying {
            player.pause()
            //MARK: NOTIFY TO VIEW
//            playPauseButton = AudioButton(.play)
            
        } else {
            
            guard FileManager.default.fileExists(atPath: getFileUrl().path) else { return }
            setTrack()
            player.play()
            runPlayerTimer()
            //MARK: NOTIFY TO VIEW
//            playPauseButton = AudioButton(.pause)
        }
    }
    
    func reverseButtonAction() {
        
    }
}
