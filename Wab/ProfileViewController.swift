//
//  ProfileViewController.swift
//  Wab
//
//  Created by Media Lab2 on 15.11.17.
//  Copyright © 2017 brotandos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ProfileViewController: UIViewController {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var ava: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var subsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let header: HTTPHeaders = [
            "Authorization": "Token \(KeychainService.loadPassword(service: "wab", account: "token")!)",
        ]
        
        let headerJson: HTTPHeaders = [
            "Authorization": "Token \(KeychainService.loadPassword(service: "wab", account: "token")!)",
            "Accept": "application/json"
        ]
        
        Alamofire.request("http://78.47.10.82/profile", headers: headerJson)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = value as! NSDictionary
                    self.nameLabel.text = json.object(forKey: "full_name") as! String
                    self.cityLabel.text = (json.object(forKey: "city") as! NSDictionary).object(forKey: "name") as! String
                    self.postsLabel.text = String(json.object(forKey: "get_ads_count") as! Int)
                    self.followersLabel.text = String(json.object(forKey: "get_subscribers_count") as! Int)
                    self.subsLabel.text = String(json.object(forKey: "get_subscriptions_count") as! Int)
                    
                    // set avatar
                    Alamofire.request(json.object(forKey: "avatar") as! String, headers: header)
                        .responseImage { response in
                            switch response.result {
                            case .success(let value):
                                self.avatar.image = value
                                break
                            case .failure(let error):
                                print(error)
                            }
                            
                    }
                    
                    print(json)
                    break
                case .failure(let error):
                    print(error)
                }
        }
        
        Alamofire.request("http://78.47.10.82/profile/ads", headers: headerJson)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    break
                case .failure(let error):
                    print(error)
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
