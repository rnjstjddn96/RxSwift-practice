//
//  LoginViewModel.swift
//  RxSwift-Playground
//
//  Created by imf-mini-3 on 2020/09/29.
//  Copyright © 2020 swkwon. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class LoginViewModel {
    
    
    let isEmailValid: Observable<Bool> = Observable<Bool>.just(false)
    let isPasswordValid: Observable<Bool> = Observable<Bool>.just(false)
    let isFormValid: Observable<Bool> = Observable<Bool>.just(false)
    let errorMessage: Observable<Message> = Observable<Message>.just(.notValid)
    
    let disposeBag = DisposeBag()

    private func checkIfEmailValid(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    private func checcIfPasswordValid(_ password: String)-> Bool {
        return password.count >= 6
    }
    
    
    enum Message: String {
        case emailNotValid = "Email not valid"
        case passwordNotValid = "Passsword not valid"
        case valid = "LogIn"
        case notValid = "not valid"
    }
}
