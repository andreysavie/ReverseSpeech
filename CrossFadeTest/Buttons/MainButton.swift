//
//  MainButton.swift
//  CrossFadeTest
//
//  Created by Андрей Рыбалкин on 29.06.2022.
//

import UIKit

final class MainButton: UIButton {
    
    let title: String
    let backColor: UIColor
    
    var tapAction: (() -> Void)?
    
    
    init (
        title: String, backColor: UIColor) {
        self.title = title
        self.backColor = backColor
        
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .bold) // custom font!
        titleLabel?.textColor = .white
        layer.cornerRadius = 16
        clipsToBounds = true
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        backgroundColor = backColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonPressed() {
            tapAction?()
    }
}
