//
//  ViewController.swift
//  PearEvent
//
//  Created by Oli on 05/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var selectTypeBtn: UIButton!
    @IBOutlet var typeItems: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Arrondir les bordures des boutons
        selectTypeBtn.layer.cornerRadius = selectTypeBtn.frame.height / 2.0
        //Arrondir les bordures mais pour chaque sous-boutons
        typeItems.forEach{(typeBtn)in
            typeBtn.layer.cornerRadius = typeBtn.frame.height / 2.0
            
        //cacher les sous-bouttons
            typeBtn.isHidden = true
        }
    }
    
    
    @IBAction func typeSelectPressed(_ sender: UIButton) {
            //Afficher les boutons
            typeItems.forEach{(typeBtn) in
                UIView.animate(withDuration: 0.4, animations: {
                    typeBtn.isHidden = !typeBtn.isHidden
                    self.view.layoutIfNeeded()
                })
        }
    }
    
    
    @IBAction func typePressed(_ sender: UIButton) {
    }
}


