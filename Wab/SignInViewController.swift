//
//  SignInViewController.swift
//  Wab
//
//  Created by ~Brotandos~ on 02.11.2017.
//  Copyright © 2017 brotandos. All rights reserved.
//

import UIKit
import Alamofire

class SignInViewController: UIViewController {
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        guard phoneField.text != "", pwdField.text != "" else { return }
        let parameters: Parameters = [
            "phone": phoneField.text!,
            "password": pwdField.text!
        ]
        
        print(parameters)
        
        Alamofire.request("http://78.47.10.82/account/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = value as? [String: String]
                    let token = json!["token"]
                    KeychainService.savePassword(service: "wab", account: "token", data: token!)
                    print(KeychainService.loadPassword(service: "wab", account: "token")!)
                    break
                case .failure(let error):
                    print(error)
                }
            }
    }
}
