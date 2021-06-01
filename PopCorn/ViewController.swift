//
//  ViewController.swift
//  PopCorn
//
//  Created by Charlotte Der Baghdassarian on 13/04/2021.
//

import UIKit
import SafariServices
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
  
    @IBAction func openinternetlink(_ sender: Any) {
    
            if let url = URL(string: "https://www.allocine.fr/film/fichefilm_gen_cfilm=57138.html"){
            UIApplication.shared.open(url)
            
        
    }
   
    }
    
}
