//
//  LoginViewController.swift
//  RxSwift-Playground
//
//  Created by imf-mini-3 on 2020/09/29.
//  Copyright © 2020 swkwon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    let loginViewModel = LoginViewModel()
    
    let disposeBag = DisposeBag()
//    let emailText: BehaviorSubject<String> = BehaviorSubject(value: "")
//    let isEmailValid: BehaviorSubject<Bool> = BehaviorSubject(value: false)
//    let passwordText: BehaviorSubject<String> = BehaviorSubject(value: "")
//    let isPasswordValid: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    @IBOutlet var emailTf: UITextField!
    @IBOutlet var pwtf: UITextField!
    
    typealias Message = LoginViewModel.Message
    
//    var errorMsg: Observable<Message> = Observable<Message>.just(.notValid)
    
    let emailValidView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let passwordValidView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    func setPostion() {
        emailValidView.rightAnchor.constraint(equalTo: emailTf.rightAnchor, constant: -10).isActive = true
        emailValidView.centerYAnchor.constraint(equalTo: emailTf.centerYAnchor).isActive = true
        emailValidView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        emailValidView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        passwordValidView.rightAnchor.constraint(equalTo: pwtf.rightAnchor, constant: -10).isActive = true
        passwordValidView.centerYAnchor.constraint(equalTo: pwtf.centerYAnchor).isActive = true
        passwordValidView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        passwordValidView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: pwtf.bottomAnchor, constant: 10).isActive = true
        loginButton.widthAnchor.constraint(equalTo: emailTf.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(emailValidView)
        view.addSubview(passwordValidView)
        view.addSubview(loginButton)
        setPostion()
        BindUI()
        
        // Do any additional setup after loading the view.
    }
    
    func BindUI() {
        //input
        emailTf.rx.text.orEmpty
            .subscribe(onNext: {
                self.loginViewModel.setEmailText($0)
            })
            .disposed(by: disposeBag)
        
        pwtf.rx.text.orEmpty
            .subscribe(onNext: {
                self.loginViewModel.setpasswordText($0)
            })
            .disposed(by: disposeBag)
        
        //output
        self.loginViewModel.isEmailValid
            .bind(to: emailValidView.rx.isHidden)
            .disposed(by: disposeBag)
        
        self.loginViewModel.isPasswordValid
            .bind(to: passwordValidView.rx.isHidden)
            .disposed(by: disposeBag)
        
        self.loginViewModel.isFormValid
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
