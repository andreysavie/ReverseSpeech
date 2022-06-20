//
//  TrackTableViewCell.swift
//  CrossFadeTest
//
//  Created by Андрей Рыбалкин on 20.06.2022.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    
    // MARK: PROPERTIES ============================================================================
    
    private lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var musicIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "music.note", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return image
    }()
    
    // MARK: INITIALIZATORS ============================================================================
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(trackNameLabel, musicIcon)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS ===================================================================================
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            musicIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            musicIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            musicIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            trackNameLabel.leadingAnchor.constraint(equalTo: musicIcon.trailingAnchor, constant: 12),
            trackNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            trackNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            trackNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
    
    func setConfigureOfCell(index: Int) {
        trackNameLabel.text = tracks[index]
    }
}


