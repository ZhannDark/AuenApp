//
//  ForgotPasswordController.swift
//  FinalProject
//
//  Created by Zhanna Zhanashova on 20.12.2023.
//

import UIKit

class ForgotPasswordController: UIViewController {
    
    // MARK: - UI Components
    
    private let headerView = AuthHeaderView(title: "Forgot Password?", subtitle: "Reset your password")
    private let emailField = UserTextField(fieldtype: .email)
    private let resetPasswordBtn = UserButton(title: "Register", hasBackground: true, fontSize: .big)
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.resetPasswordBtn.addTarget(self, action: #selector(didTapForgotPswBtn), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(resetPasswordBtn)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 230),
            
            self.emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 11),
            self.emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.resetPasswordBtn.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            self.resetPasswordBtn.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.resetPasswordBtn.heightAnchor.constraint(equalToConstant: 55),
            self.resetPasswordBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
    }
        
    // MARK: - Selectors
    @objc private func didTapForgotPswBtn() {
        let email = self.emailField.text ?? ""
        
        if !Validator.isValidEmail(for: email) {
            AlertMessage.showInvalidEmailAlert(on: self)
            return
        }
        
        AuthService.shared.forgotPassword(with: email){ [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertMessage.showInvalidPasswordAlert(on: self, with: error)
                return
            }
            
            AlertMessage.showPasswordAlert(on: self)
        }
    }
}
