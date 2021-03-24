//
//  ViewController.swift
//  JT
//
//  Created by apple on 2021/3/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }
 
    @IBAction func joinAction(_ sender: Any) {
        
        navigationController?.pushViewController(BossVC.init(), animated: true)
        
    }
}

