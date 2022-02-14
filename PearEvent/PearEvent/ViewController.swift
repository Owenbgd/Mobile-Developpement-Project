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
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Event details
    
    
    var eventDictionary: [String: Any] = [:]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        RequestFactory().getInformationList(callback: { blabla in
            self.eventDictionary = blabla as! [String: Any]
                        
            if var records = blabla["records"]{
                records = records as! [Dictionary<String, Any>]
            /*
                if let Type = records["Type"] as? [[String: Any]]{
                    print(Type as Any)
                }
            */

                //print(records[0]["id"]["fields"])
                 }
            
            //test
            print(self.eventDictionary)
            })
        
       /*
        RequestFactory().getInformationList {
            json in
            guard json != nil else {
                print("Erreur dans la récupération du json")
                return
            }
            do {
                for (key, value) in json {
                    print(value)
                    print("aaaaaaaaaaaaa")
                }
                
            } catch let parseError {
                print("Erreur de désérialisation JSON : \(parseError.localizedDescription)")
            }
            // for event in json {
            //     print(event)
            // }
        }
        */
        
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


