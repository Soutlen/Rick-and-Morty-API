//
//  CustomTable.swift
//  Rick and Morty
//
//  Created by Евгений Глоба on 1/17/25.
//

import UIKit

// MARK: - CustomTableViewCell
class CustomTableViewCell: UITableViewCell{
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabelOne: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = UIColor.white
        return label
    }()
    
    let titleLabelTwo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(cgColor: CGColor(red: 77/255, green: 35/255, blue: 110/255, alpha: 1.0))
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    let titleLabelThree: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(cgColor: CGColor(red: 77/255, green: 35/255, blue: 110/255, alpha: 1.0))
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    let subTitleLabelOne: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 0
        label.textColor = UIColor.white
        return label
    }()
    
    let subTitleLabelTwo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 0
        label.textColor = UIColor.white
        return label
    }()
    
    let subTitleLabelThree: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 0
        label.textColor = UIColor.white
        return label
    }()
    
        override func layoutSubviews() {
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.masksToBounds = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = UIColor(cgColor: CGColor(red: 190/255, green: 149/255, blue: 162/255, alpha: 1.0))
        contentView.addSubview(characterImageView)
        contentView.addSubview(titleLabelOne)
        contentView.addSubview(titleLabelTwo)
        contentView.addSubview(titleLabelThree)
        contentView.addSubview(subTitleLabelOne)
        contentView.addSubview(subTitleLabelTwo)
        contentView.addSubview(subTitleLabelThree)
        
        //MARK: -NSLayoutConstraint
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            characterImageView.widthAnchor.constraint(equalToConstant: 100),
            characterImageView.heightAnchor.constraint(equalToConstant: 100),
            characterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            titleLabelOne.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            titleLabelOne.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabelOne.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            subTitleLabelOne.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            subTitleLabelOne.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            subTitleLabelOne.topAnchor.constraint(equalTo: titleLabelOne.bottomAnchor, constant: 5),
            subTitleLabelOne.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),

            titleLabelTwo.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            titleLabelTwo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabelTwo.topAnchor.constraint(equalTo: subTitleLabelOne.bottomAnchor, constant: 5),
            titleLabelTwo.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),

            subTitleLabelTwo.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            subTitleLabelTwo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            subTitleLabelTwo.topAnchor.constraint(equalTo: titleLabelTwo.bottomAnchor, constant: 5),
            subTitleLabelTwo.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),

            titleLabelThree.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            titleLabelThree.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabelThree.topAnchor.constraint(equalTo: subTitleLabelTwo.bottomAnchor, constant: 5),
            titleLabelThree.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),

            subTitleLabelThree.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            subTitleLabelThree.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            subTitleLabelThree.topAnchor.constraint(equalTo: titleLabelThree.bottomAnchor, constant: 5),
            subTitleLabelThree.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with character: CharacterResult, andEpisode episode: EpisodeResult) {
        
        characterImageView.loadImage(from: character.image)
        titleLabelOne.text = character.name
        subTitleLabelOne.text = "\(character.status) - \(character.species)"
        titleLabelTwo.text = "Last know location:"
        subTitleLabelTwo.text =  character.location.name
        titleLabelThree.text = "First seen in:"
        subTitleLabelThree.text = episode.name
    }
}

//MARK: -Extension UIImageView
extension UIImageView {
    private static var imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(from urlString: String) {

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data, let image = UIImage(data: data) {
 
                UIImageView.imageCache.setObject(image, forKey: urlString as NSString)
 
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }.resume()
    }
}

