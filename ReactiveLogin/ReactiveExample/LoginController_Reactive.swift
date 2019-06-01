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
    private var usernameTextField: UITextField { return baseView.emailTextField }
    private var passwordTextField: UITextField { return baseView.passwordTextField }
    private var messageLabel: UILabel { return baseView.messageLabel }
    private var loginButton: UIButton { return baseView.loginButton }
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
        viewModel.input.passwordText <~ passwordTextField.reactive.continuousTextValues.producer
        viewModel.input.tapLogin <~ loginButton.reactive.controlEvents(.touchUpInside).map { _ in }
        
        usernameTextField.reactive.isValid <~ viewModel.output.emailTextIsValid.producer
        passwordTextField.reactive.isValid <~ viewModel.output.passwordTextIsValid.producer
        loginButton.reactive.isEnabled <~ viewModel.output.loginButtonIsActive
    }
}


private extension Reactive where Base: UITextField {
    
    var isValid: BindingTarget<Bool> {
        return makeBindingTarget { $0.layer.borderColor = ($1 ? UIColor.green : .gray).cgColor }
    }
}


extension Signal.Observer {
    @discardableResult
    static func <~
        <Source: BindingSource>
        (observer: Signal<Value, Error>.Observer, source: Source) -> Disposable?
        where Source.Value == Value
    {
        return source.producer.start { [weak observer] in
            switch $0 {
            case .value(let val):
                observer?.send(value: val)
            default: break
            }
        }
    }
}

