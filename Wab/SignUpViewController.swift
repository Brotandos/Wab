//
//  SignUpViewController.swift
//  Wab
//
//  Created by ~Brotandos~ on 25.10.17.
//  Copyright © 2017 Brotandos. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var phoneField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var confirmField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func selectSignUpPressed(_ sender: Any) {
        guard nameField.text != "", phoneField.text != "", passwordField.text != "", confirmField.text != "" else { return }
        if passwordField.text == confirmField.text {
            let params = ["phone": phoneField.text, "password": passwordField.text]
            let session = URLSession.shared
            let url = URL(string: "http://78.47.10.82/account/register")!
            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            do {
                req.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
            
            req.addValue("application/json", forHTTPHeaderField: "Content-Type")
            req.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: req as URLRequest, completionHandler: { data, response, error in
                guard error == nil else { return }
                
                guard let data = data else { return }
                
                do {
                    //create json object from data
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        print(json)
                        // handle json...
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        } else {
            print("Password doesn't match")
        }
    }
    
    @IBAction func selectSignInPressed(_ sender: Any) {
    }
}
