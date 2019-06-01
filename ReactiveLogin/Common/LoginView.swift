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
    
    private (set) lazy var emailTextField: UITextField = {
        let it = UITextField()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.layer.borderColor = UIColor.blue.cgColor
        it.layer.borderWidth = 2
        it.placeholder = "email"
        return it
    }()
    
    private (set) lazy var passwordTextField: UITextField = {
        let it = UITextField()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.layer.borderColor = UIColor.blue.cgColor
        it.layer.borderWidth = 2
        it.placeholder = "pass"
        return it
    }()
    
    private (set) lazy var messageLabel: UILabel = {
        let it = UILabel()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.textAlignment = .center
        it.textColor = .red
        return it
    }()
    
    private  (set) lazy var loginButton: UIButton = {
        let it = UIButton()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.backgroundColor = .orange
        it.layer.cornerRadius = 6
        it.layer.shadowColor = UIColor.black.cgColor
        it.layer.shadowRadius = 2
        it.layer.shadowOffset = CGSize(width: 0, height: 2)
        it.layer.shadowOpacity = 0.25
        it.setTitle("Login", for: .normal)
        return it
    }()
    
    private (set) lazy var tapGesture = UITapGestureRecognizer()
    
    private func initializeView() {
        backgroundColor = .white
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(messageLabel)
        addSubview(loginButton)
        addGestureRecognizer(tapGesture)
    }
    
    private func initializeConstraints() {
        
        let textViewHeight: CGFloat = 45
        
        NSLayoutConstraint.activate([
            emailTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            emailTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: textViewHeight),
            emailTextField.topAnchor.constraint(equalTo: topAnchor, constant: 100)
            ])
        
        NSLayoutConstraint.activate([
            passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: textViewHeight),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20)
            ])
        
        
        NSLayoutConstraint.activate([
            messageLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            messageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            messageLabel.heightAnchor.constraint(equalToConstant: 30),
            messageLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20)
            ])
        
        NSLayoutConstraint.activate([
            loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 80),
            loginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -80),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            loginButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20)
            ])
    }
}
