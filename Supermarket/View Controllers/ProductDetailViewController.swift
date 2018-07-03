//
//  ProductDetailViewController.swift
//  Supermarket
//
//  Created by Kirill Koleno on 02.07.2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var productDescription: UITextView!
    
    @IBOutlet weak var finalPrice: UILabel!
    @IBOutlet weak var itemsCount: UITextField!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let product = product else { return }
        
        productImage.image = UIImage(data: product.imageData!)
        productTitle.text = product.title
        productPrice.text = product.price
        productDescription.text = product.productDescription
        
        productTitle.isUserInteractionEnabled = false
        productPrice.isUserInteractionEnabled = false
        productDescription.isUserInteractionEnabled = false
        itemsCount.isUserInteractionEnabled = false
        
        finalPrice.text = productPrice.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeItemsCount(_ sender: UIStepper) {
        sender.minimumValue = 1
        itemsCount.text = Int(sender.value).description
        
        finalPrice.text = String(Int(productPrice.text!)! * Int(sender.value))
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        setEditMode()
    }
    
    func setEditMode() {
        if editButton.title == "Редактировать" {
            editButton.title = "Готово"
            
            productTitle.isUserInteractionEnabled = true
            productPrice.isUserInteractionEnabled = true
            productDescription.isUserInteractionEnabled = true
        } else if editButton.title == "Готово"{
            editButton.title = "Редактировать"
            
            productTitle.isUserInteractionEnabled = false
            productPrice.isUserInteractionEnabled = false
            productDescription.isUserInteractionEnabled = false
        }
    }
}
