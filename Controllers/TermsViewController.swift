//
//  TermsViewController.swift
//  FinalProject
//
//  Created by Zhanna Zhanashova on 21.12.2023.
//

import UIKit
import WebKit

class TermsViewController: UIViewController {
    
    private let termsWeb = WKWebView()
    private let urlString: String
    
    init(with urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        guard let url = URL(string: self.urlString) else{
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        self.termsWeb.load(URLRequest(url: url))
        
    }
    
    private func setupUI(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDoneBtn))
        self.navigationController?.navigationBar.backgroundColor = .white
        self.view.addSubview(termsWeb)
        self.termsWeb.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.termsWeb.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.termsWeb.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.termsWeb.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.termsWeb.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
    }
    
    @objc private func didTapDoneBtn(){
        self.dismiss(animated: true, completion: nil)
    }
}
