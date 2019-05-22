//
//  LoginView.swift
//  ReactiveLogin
//
//  Created by chutatsu on 2019/05/21.
//  Copyright © 2019 churabou. All rights reserved.
//

import UIKit

final class LoginView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initializeView()
        initializeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private (set) lazy var usernameTextField: UITextField = {
        let it = UITextField()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.layer.borderColor = UIColor.blue.cgColor
        it.layer.borderWidth = 2
        return it
    }()
    
    private (set) lazy var passwordTextField: UITextField = {
        let it = UITextField()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.layer.borderColor = UIColor.blue.cgColor
        it.layer.borderWidth = 2
        return it
    }()
    
    private (set) lazy var messageLabel: UILabel = {
        let it = UILabel()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.textAlignment = .center
        it.textColor = .red
        return it
    }()
    
    private  (set) lazy var confirmButton: UIButton = {
        let it = UIButton()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.backgroundColor = .orange
        it.layer.cornerRadius = 10
        it.setTitle("register", for: [])
        return it
    }()
    
    private (set) lazy var tapGesture = UITapGestureRecognizer()
    
    private func initializeView() {
        backgroundColor = .white
        addSubview(usernameTextField)
        addSubview(passwordTextField)
        addSubview(messageLabel)
        addSubview(confirmButton)
        addGestureRecognizer(tapGesture)
    }
    
    private func initializeConstraints() {
        
        NSLayoutConstraint.activate([
            usernameTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            usernameTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            usernameTextField.heightAnchor.constraint(equalToConstant: 30),
            usernameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 100)
            ])
        
        NSLayoutConstraint.activate([
            passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20)
            ])
        
        
        NSLayoutConstraint.activate([
            messageLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            messageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            messageLabel.heightAnchor.constraint(equalToConstant: 30),
            messageLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20)
            ])
        
        NSLayoutConstraint.activate([
            confirmButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 80),
            confirmButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -80),
            messageLabel.heightAnchor.constraint(equalToConstant: 30),
            confirmButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20)
            ])
    }
}
