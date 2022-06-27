//
//  PlayerView.swift
//  CrossFadeTest
//
//  Created by Андрей Рыбалкин on 20.06.2022.
//

import UIKit
import AVFoundation

class PlayerView: UIView {
    
    
    // MARK: PROPERTIES =============================================================================================
    
    
    private var player = AVAudioPlayer()
    private var counter = 0
    
    private var currentTrackName: String {
        get {
            let singer = Model.tracks[counter]
            let track = Model.tracks[counter]
            return "\(singer) - \(track)"
        }
    }
    
    private lazy var playPauseButton = getButton(icon: "play.fill", action: #selector(playPauseButtonAction))
    private lazy var stopButton = getButton(icon: "stop.fill", action: #selector(stopButtonAction))
    private lazy var nextTrackButton = getButton(icon: "forward.fill", action: #selector(nextTrackAction))
    private lazy var previousTrackButton = getButton(icon: "backward.fill", action: #selector(prevTrackAction))
    
    private lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var playerButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousTrackButton, playPauseButton, stopButton, nextTrackButton])
        stackView.toAutoLayout()
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    
    // MARK: INITS =================================================================================================
    
    init () {
        super.init(frame: .zero)
        addSubviews(playerButtonsStackView, trackNameLabel)
        setuplayout()
        setTrack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS =================================================================================================
    
    private func setTrack() {
        let trackName = Model.tracks[counter]
        
        guard let trackURL = Bundle.main.url(forResource: trackName, withExtension: "mp3") else { return }
        
        do {
            try player = AVAudioPlayer(contentsOf: trackURL)
            player.prepareToPlay()
            
        } catch { print(error.localizedDescription) }
        
        trackNameLabel.text = currentTrackName
    }
    
    
    public func playSelectedTrack (forIndex index: Int) {
        counter = index
        setTrack()
        player.play()
        playPauseButton.setCustomImage(name: "pause.fill", size: 32)
    }
    
    private func setuplayout() {

        NSLayoutConstraint.activate([
            
            playerButtonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            playerButtonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            playerButtonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            trackNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            trackNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            trackNameLabel.bottomAnchor.constraint(equalTo: playerButtonsStackView.topAnchor, constant: -32)
        ])
    }
    
    
    // MARK: OBJC METHODS =================================================================================================

    @objc
    private func nextTrackAction () {
        if counter == Model.tracks.count - 1 {
            counter = 0
        } else {
            counter += 1
        }
        trackNameLabel.text = "\(currentTrackName)"
        setTrack()
        player.play()
    }
    
    
    @objc
    private func prevTrackAction () {
        if counter == 0 {
            counter = Model.tracks.count - 1
        } else {
            counter -= 1
        }
        trackNameLabel.text = "\(currentTrackName)"
        setTrack()
        player.play()
    }
    
    @objc
    private func playPauseButtonAction() {
        
        if player.isPlaying {
            player.pause()
            playPauseButton.setCustomImage(name: "play.fill", size: 32)
            
        } else {
            player.play()
            playPauseButton.setCustomImage(name: "pause.fill", size: 32)
        }
    }
    
    
    @objc
    private func stopButtonAction() {
        player.stop()
        player.currentTime = 0
        playPauseButton.setCustomImage(name: "play.fill", size: 32)
    }

}

public extension UIView {
    
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ subviews: UIView...) {
          subviews.forEach { addSubview($0) }
      }
    
    func getButton (icon name: String, action: Selector ) -> UIButton {
        let button = UIButton()
        button.setCustomImage(name: name, size: 32)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
}

public extension UIButton {
    
    func setCustomImage (name: String, size: CGFloat) {
        setImage((UIImage(systemName: name, withConfiguration: UIImage.SymbolConfiguration(pointSize: size))?.withTintColor(.black, renderingMode: .alwaysOriginal))!, for: .normal)
    }
}
