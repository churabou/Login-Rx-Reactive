//
//  ViewController.swift
//  ReactiveLogin
//
//  Created by chutatsu on 2019/05/21.
//  Copyright © 2019 churabou. All rights reserved.
//

import UIKit
import RxSwift
//import RxCocoa

import Result
import ReactiveCocoa
import ReactiveSwift

final class ViewController: UIViewController {

    private var label: UILabel = {
        let it = UILabel()
        it.textColor = .darkGray
        it.font = .systemFont(ofSize: 17)
        it.text = ""
        it.textAlignment = .center
        return it
    }()
    
    private lazy var textField: UITextField = {
        let it = UITextField()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.layer.borderColor = UIColor.blue.cgColor
        it.layer.borderWidth = 2
        return it
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        view.addSubview(textField)
        
        textField.frame.size = .init(width: 300, height: 50)
         textField.center = view.center
        
        label.center = view.center
        label.center.y -= 100
        label.frame.size = .init(width: 300, height: 50)
        
    }
    
    let tapButton = Signal<Void, NoError>.pipe()
    
    private func reactive() {
        let passWordIsValid = textField.reactive.continuousTextValues.map { $0.count >= 5 }
        let emailIsValid = textField.reactive.continuousTextValues.map { $0.count >= 5}
        
        let allValid = Signal.combineLatest(passWordIsValid, emailIsValid).map { $0 && $1 }
        
        
        let value = MutableProperty<String>("")
        value <~ textField.reactive.continuousTextValues
    
        let button = UIButton()
        button.reactive.isEnabled <~ allValid
        label.reactive.text <~ textField.reactive.continuousTextValues
    }


    let bag = DisposeBag()
}

