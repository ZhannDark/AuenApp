//
//  AuthHeaderView.swift
//  FinalProject
//
//  Created by Zhanna Zhanashova on 20.12.2023.
//

import UIKit

class AuthHeaderView: UIView {
    // MARK: - Variables
    
    //MARK: - UI Components
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "logo")
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.text = "Title"
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "SubTitle"
        return label
    }()
    
    
    //MARK: - LifeCycle
    init(title: String, subtitle: String){
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup
    private func setupUI(){
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.imageView.widthAnchor.constraint(equalToConstant: 90),
            self.imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            self.titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 19),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
