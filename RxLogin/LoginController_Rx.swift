//
//  LoginController.swift
//  ReactiveLogin
//
//  Created by chutatsu on 2019/05/21.
//  Copyright © 2019 churabou. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


final class LoginController_Rx: UIViewController {
    
    private let baseView = LoginView()
    private var usernameTextField: UITextField { return baseView.usernameTextField }
    private var passwordTextField: UITextField { return baseView.passwordTextField }
    private var messageLabel: UILabel { return baseView.messageLabel }
    private var confirmButton: UIButton { return baseView.confirmButton }
    private var tapGesture: UITapGestureRecognizer { return baseView.tapGesture }
    
    override func loadView() {
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWithViewModel()
    }
    
    private var viewModel = LoginViewModel_Rx()
    
    private let bag = DisposeBag()

    private func setUpWithViewModel() {
        
        tapGesture.rx.event
            .asObservable().subscribe(onNext: { [unowned self] _ in
                self.view.endEditing(true)
            }).disposed(by: bag)
        
        passwordTextField.rx.text
            .orEmpty.asDriver()
            .drive(viewModel.input.passwordText)
            .disposed(by: bag)
        
        usernameTextField.rx.text
            .orEmpty.asObservable()
            .bind(to: viewModel.input.usernameText)
            .disposed(by: bag)
        
        confirmButton.rx.tap.asObservable()
            .bind(to: viewModel.input.tapRegisterButton)
            .disposed(by: bag)
        
        viewModel.output.registerButtonIsActive.subscribe(onNext: { [unowned self] in
            self.confirmButton.backgroundColor = $0 ? .orange : .gray
            self.confirmButton.isEnabled = $0
        })
            .disposed(by: bag)
        
        viewModel.output.usernameTextIsValid.subscribe(onNext: { [unowned self] in
            self.usernameTextField.layer.borderColor = ($0 ? UIColor.green : .red).cgColor
        })
            .disposed(by: bag)
        
        viewModel.output.passTextIsValid.subscribe(onNext: { [unowned self] in
            self.passwordTextField.layer.borderColor = ($0 ? UIColor.green : .red).cgColor
        })
            .disposed(by: bag)
        
    }
}