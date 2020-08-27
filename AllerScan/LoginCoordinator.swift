//
//  LoginViewController.swift
//  TestAPP
//
//  Created by Жалын on 7/2/19.
//  Copyright © 2019 ZLJ. All rights reserved.
//

import UIKit
import LoginKit

class LoginCoordinator: UIViewController {
    
    lazy var loginCoordinator: LoginCoordinator = {
    return LoginCoordinator(rootViewController: self)
    }()
    
    ...
    
    func showLogin() {
        loginCoordinator.start()
    }
    
    ...
    
}
