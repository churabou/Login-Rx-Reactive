//
//  LoginRepository.swift
//  ReactiveLogin
//
//  Created by chutatsu on 2019/05/21.
//  Copyright © 2019 churabou. All rights reserved.
//

import Foundation

protocol LoginRepository {
    func requestLogin(email: String, password: String)
}

enum LoginError: Error {
    case invalidUserIdOrPassword
    case networkError
}

struct LoginRepositoryImpl: LoginRepository {
    
    func requestLogin(email: String, password: String) {
        
    }
}

// success or error
struct LoginResult {
}

enum NetworkError: Error {}
