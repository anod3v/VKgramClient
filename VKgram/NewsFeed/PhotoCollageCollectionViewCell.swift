//
//  PhotoCollageCollectionViewCell.swift
//  LoginForm
//
//  Created by Andrey on 30/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class PhotoCollageCollectionViewCell: UICollectionViewCell {
    
    var postImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .systemOrange
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.regularOfSize25
        label.numberOfLines = 1
        label.textColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var darkView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var url = URL(string: String())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupPostImageConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {

        self.addSubview(postImage)
        self.addSubview(darkView)
        self.addSubview(label)

    }
    
    func setupPostImageConstraints() {
        NSLayoutConstraint.activate([

            postImage.topAnchor.constraint(equalTo: topAnchor),
            postImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            postImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            
        ])
        
        darkView.pin(to: self)
    }
    
    func configure(for model: String) {
        
        PhotoService.shared.photo(url: model) { image in
            DispatchQueue.main.async {
            self.postImage.image = image
            }
        }
        darkView.isHidden = true
        label.isHidden = true
    }
    
    func configureEmptyCell(for model: String, labelText: String) {

        label.text = labelText
        PhotoService.shared.photo(url: model) { image in
            DispatchQueue.main.async {
            self.postImage.image = image
            }
        }

        darkView.isHidden = false
        label.isHidden = false
    }
}
