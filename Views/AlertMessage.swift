//
//  AlertMessage.swift
//  FinalProject
//
//  Created by Zhanna Zhanashova on 21.12.2023.
//

import UIKit

class AlertMessage {
    
    private static func showAlert(on vc: UIViewController, title: String, message: String?){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
    
}

// MARK: - Show Validation Alerts
extension AlertMessage {
    public static func showInvalidEmailAlert(on vc: UIViewController){
        self.showAlert(on: vc, title: "Invalid Email", message: "Please enter a valid email.")
    }
    
    public static func showInvalidPasswordAlert(on vc: UIViewController){
        self.showAlert(on: vc, title: "Invalid Password", message: "Please enter a valid password.")
    }
    
    public static func showInvalidUsernameAlert(on vc: UIViewController){
        self.showAlert(on: vc, title: "Invalid Username", message: "Please enter a valid username.")
    }
}

// MARK: - Registration Invalidation
extension AlertMessage {
    
    public static func showInvalidRegistrationAlert(on vc: UIViewController){
        self.showAlert(on: vc, title: "Unknown Registration", message: nil)
    }
    
    public static func showInvalidRegistrationAlert(on vc: UIViewController, with error: Error){
        self.showAlert(on: vc, title: "Unknown Registration", message: "\(error.localizedDescription)")
    }
}

// MARK: - Log In Invalidation
extension AlertMessage {
    
    public static func showInvalidSignInAlert(on vc: UIViewController){
        self.showAlert(on: vc, title: "Error Logging In", message: nil)
    }
    
    public static func showInvalidSignInAlert(on vc: UIViewController, with error: Error){
        self.showAlert(on: vc, title: "Error Logging In", message: "\(error.localizedDescription)")
    }
}

// MARK: - Log Out Invalidation
extension AlertMessage {
    
    public static func showInvalidLogOutAlert(on vc: UIViewController, with error: Error){
        self.showAlert(on: vc, title: "Log Out Error", message: "\(error.localizedDescription)")
    }
}

// MARK: - Forgot Password Invalidation
extension AlertMessage {
    
    public static func showPasswordAlert(on vc: UIViewController){
        self.showAlert(on: vc, title: "Password Reset Sent", message: nil)
    }
    
    public static func showInvalidPasswordAlert(on vc: UIViewController, with error: Error){
        self.showAlert(on: vc, title: "Error Sending Password Reset", message: "\(error.localizedDescription)")
    }
}

//MARK: - Fetching User Errors
extension AlertMessage {
    
    public static func showUnknownFetchUserErrorAlert(on vc: UIViewController){
        self.showAlert(on: vc, title: "Unknown Error Fetching User", message: nil)
    }
    
    public static func showFetchUserErrorAlert(on vc: UIViewController, with error: Error){
        self.showAlert(on: vc, title: "Error Fetching User", message: "\(error.localizedDescription)")
    }
}
