//
//  DetailViewContriller.swift
//  Rick and Morty
//
//  Created by Евгений Глоба on 1/17/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    var character: CharacterResult?

    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(cgColor: CGColor(red: 77/255, green: 35/255, blue: 110/255, alpha: 1.0))
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(cgColor: CGColor(red: 77/255, green: 35/255, blue: 110/255, alpha: 1.0))
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        updateUI()
    }
    
    private func setupUI() {
        view.addSubview(characterImageView)
        view.addSubview(nameLabel)
        view.addSubview(statusLabel)
        view.backgroundColor = UIColor(cgColor: CGColor(red: 190/255, green: 149/255, blue: 162/255, alpha: 1.0)) //lightGray

        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 200),
            characterImageView.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func updateUI() {
        guard let character = character else { return }
        
        nameLabel.text = character.name
        statusLabel.text = "Status: \(character.status)"

        if let imageURL = URL(string: character.image) {
            URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        self?.characterImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
}
