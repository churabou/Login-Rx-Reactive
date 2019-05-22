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

protocol LoginViewModelInput {
    var emailText: MutableProperty<String> { get }
}

protocol LoginViewModelOutput {
    var emailTextIsValid: Signal<Bool, NoError> { get }
}


final class LoginViewModel_Reactive: LoginViewModelInput, LoginViewModelOutput {
    
    var input: LoginViewModelInput { return self }
    var output: LoginViewModelOutput { return self }
    
    let emailText = MutableProperty<String>("")
    let emailTextIsValid: Signal<Bool, NoError>
    
    private var loginService: LoginService

    init(loginService: LoginService = LoginServiceStub()) {
        self.loginService = loginService
        emailTextIsValid = emailText.signal.map { $0.count >= 5 }
    }
}
