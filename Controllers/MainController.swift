//
//  MainController.swift
//  FinalProject
//
//  Created by Zhanna Zhanashova on 22.12.2023.
//

import UIKit

class MainController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    var musics = [Music]()
    private let welcome: UILabel = {
        let welcome = UILabel()
        welcome.text = "Welcome"
        welcome.font = .systemFont(ofSize: 35, weight: .heavy)
        welcome.textColor = .systemIndigo
        return welcome
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMusics()
        view.backgroundColor = .systemYellow
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemYellow
        view.addSubview(welcome)
        view.addSubview(collectionView)
        
        welcome.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        welcome.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        welcome.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: welcome.bottomAnchor, constant: 15).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    
    func configureMusics() {
        musics.append(Music(name: "Halo", artistName: "Beyonce", imageName: "music1", trackName: "Beyonce - Hello1"))
        musics.append(Music(name: "Fools", artistName: "Troye Sivan", imageName: "music8", trackName: "Troye Sivan - Fools8"))
        musics.append(Music(name: "Искал-Нашел", artistName: "Jah Khalib", imageName: "music2", trackName: "Jah Khalib - Искал-Нашел2"))
        musics.append(Music(name: "911", artistName: "Jah Khalib", imageName: "music3", trackName: "Jah Khalib - 911_3"))
        musics.append(Music(name: "My All", artistName: "Larissa Lambert", imageName: "music4", trackName: "Larissa Lambert - My All4"))
        musics.append(Music(name: "Жанамын", artistName: "Miras Zhugunusov", imageName: "music6", trackName: "Мирас Жугунусов - Жанамын6"))
        musics.append(Music(name: "Дем", artistName: "Raim", imageName: "music5", trackName: "Raim - Дем5"))
        musics.append(Music(name: "Snooze", artistName: "SZA & Justin Bieber", imageName: "music7", trackName: "SZA - Snooze7"))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        let music = musics[indexPath.row]
        cell.muzImgView.image = UIImage(named: music.imageName)
        cell.muzname.text = music.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2-20, height: 200)
    }
}

class CustomCell: UICollectionViewCell {
    let muzImgView = UIImageView()
    let muzname = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupLabel()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        addSubview(muzImgView)
        muzImgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            muzImgView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            muzImgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            muzImgView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            muzImgView.heightAnchor.constraint(equalTo: muzImgView.widthAnchor),
        ])
        muzImgView.contentMode = .scaleAspectFill
        muzImgView.layer.cornerRadius = 10
        muzImgView.clipsToBounds = true
    }
    
    private func setupLabel() {
        addSubview(muzname)
        muzname.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            muzname.topAnchor.constraint(equalTo: muzImgView.bottomAnchor, constant: 5),
            muzname.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            muzname.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            muzname.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
        muzname.textAlignment = .center
        muzname.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        muzname.numberOfLines = 1
    }
    
    private func setupCell() {
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowColor = UIColor.black.cgColor
        backgroundColor = .white
    }
}
