//
//  RecordingView.swift
//  CrossFadeTest
//
//  Created by Андрей Рыбалкин on 27.06.2022.
//

import UIKit
import AVFoundation
import SnapKit

class RecordingView: UIView, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    private var model: RecordingModel?

    // MARK: PROPERTIES =============================================================================================
    
    private lazy var recordButton = AudioButton(.record)
    private lazy var playPauseButton = AudioButton(.play)
    private lazy var reverseButton = AudioButton(.reverse)

    private lazy var recorderButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [recordButton, playPauseButton, reverseButton])
        stackView.toAutoLayout()
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .red // color!
        return stackView
    }()
    
    // MARK: INITS =================================================================================================
    
    init (model: RecordingModel) { // убрать модель отсюда в контроллер!!!
        super.init(frame: .zero)
        setuplayout()
//        setRecordingSession()
        self.model = model

        recordButton.tapAction = { [weak self] in
            self?.model?.recordAudioAction()
        }
        
        playPauseButton.tapAction = { [weak self] in
            self?.model?.playRecordedAudioAction()
        }
       
        reverseButton.tapAction = { [weak self] in
            self?.model?.reverseButtonAction()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: METHODS =================================================================================================
        
    private func setuplayout() {
        
        addSubviews(recorderButtonsStackView)
        
        recordButton.isEnabled = false
        recordButton.alpha = 0.5
        
        [recordButton, playPauseButton, reverseButton].forEach { button in
            button.snp.makeConstraints { make in
                make.height.equalTo(46)
            }
        }
        
        recorderButtonsStackView.snp.makeConstraints({ make in
            make.leading.bottom.trailing.equalToSuperview().inset(16)
        })
        
    }

}
