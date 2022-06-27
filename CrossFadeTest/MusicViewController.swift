//
//  ViewController.swift
//  CrossFadeTest
//
//  Created by Андрей Рыбалкин on 19.06.2022.
//

import UIKit

class MusicViewController: UIViewController {
    
    let playerView = PlayerView()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped )
        table.toAutoLayout()
        table.separatorInset = .zero
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerView.toAutoLayout()
        
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(
            TrackTableViewCell.self,
            forCellReuseIdentifier: String(
                describing: TrackTableViewCell.self)
        )

        view.addSubviews(tableView, playerView)
        

        
        setupLayout()
    }

    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            
            playerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            playerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            playerView.heightAnchor.constraint(equalToConstant: 160),

            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: playerView.topAnchor)

        ])
    }
    
}

extension MusicViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TrackTableViewCell.self), for: indexPath) as? TrackTableViewCell else { return UITableViewCell() }
        cell.setConfigureOfCell(index: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.tracks.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "   Список треков"
    }
    
}
    
extension MusicViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playerView.playSelectedTrack(forIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

