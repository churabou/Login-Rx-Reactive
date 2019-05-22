//
//  LoginController_Reactive.swift
//  ReactiveLogin
//
//  Created by chutatsu on 2019/05/21.
//  Copyright © 2019 churabou. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

final class LoginController_Reactive: UIViewController {
    
    private let baseView = LoginView()
    private var usernameTextField: UITextField { return baseView.usernameTextField }
    private var passwordTextField: UITextField { return baseView.passwordTextField }
    private var messageLabel: UILabel { return baseView.messageLabel }
    private var confirmButton: UIButton { return baseView.confirmButton }
    private var tapGesture: UITapGestureRecognizer { return baseView.tapGesture }
    
    override func loadView() {
        view = baseView
    }
    
    
    private let viewModel = LoginViewModel_Reactive()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
    }
    
    private func bindToViewModel() {

        viewModel.input.emailText <~ usernameTextField.reactive.continuousTextValues
        
        viewModel.output.emailTextIsValid.observeValues { [weak self] in
             self?.usernameTextField.layer.borderColor = ($0 ? UIColor.green : .red).cgColor
        }
    }
}
