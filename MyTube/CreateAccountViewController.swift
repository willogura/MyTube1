//
//  CreateAccountViewController.swift
//  MyTube
//
//  Created by William Ogura on 6/4/17.
//  Copyright © 2017 William Ogura. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var signInView: UIView!
    
    
    
    @IBOutlet weak var greenButton: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInView.layer.cornerRadius = 10.0
        greenButton.layer.cornerRadius = 10.0
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
