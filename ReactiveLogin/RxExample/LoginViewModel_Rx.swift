//
//  LoginViewModel_Rx.swift
//  ReactiveLogin
//
//  Created by chutatsu on 2019/05/21.
//  Copyright © 2019 churabou. All rights reserved.
//

import RxSwift

final class LoginViewModel_Rx {
    
    struct Config {
        let minimalUsernameLength = 5
        let minimalPasswordLength = 5
    }
    
    struct Input {
        var usernameText: AnyObserver<String>
        var passwordText: AnyObserver<String>
        var tapLoginButton: AnyObserver<Void>
    }
    
    struct Output {
        var registerButtonIsActive: Observable<Bool>
        var usernameTextIsValid: Observable<Bool>
        var passTextIsValid: Observable<Bool>
    }
    
    let input: Input
    let output: Output
    
    init(config: Config = Config()) {
        
        let emailText = BehaviorSubject<String>(value: "")
        let passText = BehaviorSubject<String>(value: "")
        let tapRegisterButton = PublishSubject<Void>()
        
        input = Input(
            usernameText: emailText.asObserver(),
            passwordText: passText.asObserver(),
            tapLoginButton: tapRegisterButton.asObserver()
        )
        
        let emailTextIsValid = emailText.map { $0.count > config.minimalUsernameLength }.share(replay: 1)
        
        let passTextIsValid = passText.map { $0.count > config.minimalPasswordLength }.share(replay: 1)
        
        let registerButtonIsActive = Observable
            .combineLatest(emailTextIsValid, passTextIsValid) { $0 && $1 }
        
        let requestLogin = tapRegisterButton
            .asObservable()
            .withLatestFrom(Observable.combineLatest(emailText, passText)) { $1 }

        output = Output(
            registerButtonIsActive: registerButtonIsActive,
            usernameTextIsValid: emailTextIsValid,
            passTextIsValid: passTextIsValid
        )
    }
}
