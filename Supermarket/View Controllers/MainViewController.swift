//
//  ViewController.swift
//  Supermarket
//
//  Created by Kirill Koleno on 27.06.2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var salesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        purchaseButton.mainScreenButtonStyle()
        salesButton.mainScreenButtonStyle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPurchaseVC" {
            let productsListTableViewController = segue.destination as! ProductsListTableViewController
        }
        
        if segue.identifier == "showSalesProducts" {
            
        }
    }
}

//
// - - - - - - - - - -
// MARK: - Extensions
// - - - - - - - - - -
//

extension UIButton {
    
    /// Func that add some style to button
    func mainScreenButtonStyle() {
        let button = self
        
        button.backgroundColor = UIColor(red: 238/255, green: 247/255, blue: 249/255, alpha: 1.0)
        button.layer.cornerRadius = 9
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowRadius = 2
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 1.0
    }
}

