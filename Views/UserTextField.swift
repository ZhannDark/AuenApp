//
//  UserTextField.swift
//  FinalProject
//
//  Created by Zhanna Zhanashova on 21.12.2023.
//

import UIKit

class UserTextField: UITextField {

    enum UserTextFieldType {
        case username
        case email
        case password
    }

    private let authFieldType: UserTextFieldType
    
    init(fieldtype: UserTextFieldType){
        self.authFieldType = fieldtype
        super.init(frame: .zero)
        
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
       
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        switch fieldtype {
        case .username:
            self.placeholder = "Username"
        case .email:
            self.placeholder = "Enter your email address"
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
        case .password:
            self.placeholder = "Password"
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
