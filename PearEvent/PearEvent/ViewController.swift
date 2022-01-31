//
//  ViewController.swift
//  PearEvent
//
//  Created by goldorak on 31/01/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var navBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mondayButton.backgroundColor = UIColor.blue
        mondayButton.layer.cornerRadius = mondayButton.frame.height/2
        mondayButton.setTitleColor(UIColor.white, for: .normal)
        
        navBarView.backgroundColor = UIColor(red: 0.92, green: 0.91, blue: 0.93, alpha: 1.00)	        // Do any additional setup after loading the view.
    }


}

