//
//  ProfileController.swift
//  FinalProject
//
//  Created by Zhanna Zhanashova on 22.12.2023.
//

import UIKit

class ProfileController: UIViewController {

    //MARK: - UI Components
    private let imageOfUser: UIImageView = {
        let img = UIImageView(image: UIImage(named: "img"))
        img.layer.borderWidth = 1
        img.frame.size.width = 10
        img.frame.size.height = 10
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        
        img.widthAnchor.constraint(equalToConstant: 150).isActive = true
        img.heightAnchor.constraint(equalToConstant: 150).isActive = true
        return img
    }()
    
    private let enterUserName: UILabel = {
        let enterUserName = UILabel()
        enterUserName.text = "Username: "
        enterUserName.textColor = .black
        enterUserName.font = .systemFont(ofSize: 15, weight: .regular)
        return enterUserName
    }()
    
    private let userName: UILabel = {
        let userName = UILabel()
        userName.textColor = .black
        userName.font = .systemFont(ofSize: 15, weight: .semibold)
        return userName
    }()
    
    private let enterEmail: UILabel = {
        let enterEml = UILabel()
        enterEml.text = "Email: "
        enterEml.textColor = .black
        enterEml.font = .systemFont(ofSize: 15, weight: .regular)
        return enterEml
    }()
    
    private let userEmail: UILabel = {
        let userEmail = UILabel()
        userEmail.textColor = .black
        userEmail.font = .systemFont(ofSize: 15, weight: .semibold)
        return userEmail
    }()
    
    private let logout: UIButton = {
        let logout = UIButton()
        logout.setTitle("LogOut", for: .normal)
        logout.tintColor = .white
        return logout
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemYellow
        self.logout.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
        self.setupUI()
        tapgasture()
        
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else { return }
            if let error = error {
                AlertMessage.showFetchUserErrorAlert(on: self, with: error)
                return
            }
            
            if let user = user {
                self.userName.text = "\(user.username)"
                self.userEmail.text = "\(user.email)"
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageOfUser.layer.cornerRadius = imageOfUser.frame.size.height / 2
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        self.view.addSubview(enterUserName)
        self.view.addSubview(userName)
        self.view.addSubview(enterEmail)
        self.view.addSubview(userEmail)
        self.view.addSubview(logout)
        self.view.addSubview(imageOfUser)

        enterUserName.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false
        enterEmail.translatesAutoresizingMaskIntoConstraints = false
        userEmail.translatesAutoresizingMaskIntoConstraints = false
        logout.translatesAutoresizingMaskIntoConstraints = false
        imageOfUser.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Setting hello
            self.imageOfUser.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            self.imageOfUser.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            
            // Setting Username label
            self.enterUserName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            self.enterUserName.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),

            self.userName.leadingAnchor.constraint(equalTo: enterUserName.trailingAnchor, constant: 8),
            self.userName.centerYAnchor.constraint(equalTo: enterUserName.centerYAnchor),
            
            // Setting Email label
            self.enterEmail.topAnchor.constraint(equalTo: enterUserName.bottomAnchor, constant: 20),
            self.enterEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),

            self.userEmail.leadingAnchor.constraint(equalTo: enterEmail.trailingAnchor, constant: 40),
            self.userEmail.centerYAnchor.constraint(equalTo: enterEmail.centerYAnchor),
            
            // Setting Logout button
            self.logout.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.logout.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 160)
        ])
    }

    
    @objc private func didTapLogOut(){
        AuthService.shared.signOut{ [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertMessage.showInvalidLogOutAlert(on: self, with: error)
                return
            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate{
                sceneDelegate.checkAuthentication()
            }
        }
    }
    
    private func tapgasture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageOfUser.isUserInteractionEnabled = true
        imageOfUser.addGestureRecognizer(tap)
    }
    
    @objc func imageTapped(){
        let imgPicker = UIImagePickerController()
        imgPicker.sourceType = .photoLibrary
        imgPicker.delegate = self
        self.present(imgPicker, animated: true, completion: nil)
    }
}

extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageOfUser.image = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
}
