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
            .responseString { response in
                switch response.result {
                case .success:
                    print(response)
                    break
                case .failure(let error):
                    print(error)
                }
            }
    }
}
