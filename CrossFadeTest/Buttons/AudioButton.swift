//
//  AudioButton.swift
//  CrossFadeTest
//
//  Created by Андрей Рыбалкин on 29.06.2022.
//

import UIKit


final class AudioButton: UIButton {
    
    enum IconName: String {
        case record = "record.circle"
        case play = "play"
        case pause  = "pause"
        case stop = "stop.circle"
        case reverse = "arrow.counterclockwise"
    }
    
    private var iconName: IconName
    
    var tapAction: (() -> Void)?
    
    init (_ iconName: IconName) {
        
        self.iconName = iconName
        
        super.init(frame: .zero)
        
        layer.cornerRadius = 16
        clipsToBounds = true
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        backgroundColor = .blue // исправить
        setCustomImage(name: iconName.rawValue, size: 24, color: .white)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonPressed() {
            tapAction?()
    }
}

public extension UIButton {
    
    func setCustomImage (name: String, size: CGFloat, color: UIColor) {
        setImage((UIImage(systemName: name, withConfiguration: UIImage.SymbolConfiguration(pointSize: size))?.withTintColor(color, renderingMode: .alwaysOriginal))!, for: .normal)
    }
}
