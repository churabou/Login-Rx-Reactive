//
//  LoginViewModel_Reactive.swift
//  ReactiveLogin
//
//  Created by chutatsu on 2019/05/21.
//  Copyright © 2019 churabou. All rights reserved.
//

import ReactiveSwift
import ReactiveCocoa
import Result

final class LoginViewModel_Reactive {
    
    struct Input {
        var emailText: MutableProperty<String>
        var passwordText: MutableProperty<String>
        var tapLogin: Signal<Void, Never>.Observer
    }

    struct Output {
        var emailTextIsValid: Signal<Bool, NoError>
        var passwordTextIsValid: Signal<Bool, NoError>
        var loginButtonIsActive: Signal<Bool, NoError>
    }
    
    let input: Input
    let output: Output
    
    private var loginService: LoginService

    init(loginService: LoginService = LoginServiceStub()) {
        self.loginService = loginService
        
        let emailText = MutableProperty<String>("")
        let passwordText = MutableProperty<String>("")
        let (tapLoginSignal, tapLoginObserver) = Signal<Void, Never>.pipe()
        
        input = Input(
            emailText: emailText,
            passwordText: passwordText,
            tapLogin: tapLoginObserver
        )
        
        let emailTextIsValid = emailText.signal.map { $0.count > 5 }
        let passTextIsValid = passwordText.signal.map { $0.count > 5 }
        let loginButtonIsActive = emailTextIsValid.and(passTextIsValid)
        
        output = Output(
            emailTextIsValid: emailTextIsValid,
            passwordTextIsValid: passTextIsValid,
            loginButtonIsActive: loginButtonIsActive
        )
        
        let (tapLogin, observer) = Signal<Void, NoError>.pipe()
        tapLogin
            .withLatest(from: Signal.combineLatest(
                emailText.signal,
                passwordText.signal
            ))
            .flatMap(.latest) {
            self.requestLogin(email: $1.0, password: $1.1)
        }
    }
    
    private func requestLogin(email: String, password: String) -> SignalProducer<LoginResult, NetworkError> {
        
        return SignalProducer<LoginResult, NetworkError> { observer, lifetime in
//            let result = self?.loginService.requestLogin(email: email, password: password)
            observer.send(value: LoginResult())
            lifetime.observeEnded {
                observer.sendCompleted()
            }
        }
    }
}

