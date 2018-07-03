//
//  PurchaseTableViewController.swift
//  Supermarket
//
//  Created by Kirill Koleno on 27.06.2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import UIKit
import CoreData

class ProductsListTableViewController: UITableViewController {
    
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var products = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFronFile()
        
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)

            products = results
        } catch {
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataFronFile() {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        var records = 0
        
        do {
            let count = try context.count(for: fetchRequest)
            records = count
        } catch {
            print(error.localizedDescription)
        }
        
        guard records == 0 else { return }
        
        let pathToFile = Bundle.main.path(forResource: "ProductsData", ofType: "plist")
        let productsArray = NSArray(contentsOfFile: pathToFile!)
        
        for dictionary in productsArray! {
            let entity = NSEntityDescription.entity(forEntityName: "Product", in: context)
            let product = NSManagedObject(entity: entity!, insertInto: context) as! Product
            
            let productDictionary = dictionary as! NSDictionary
            
            product.title = productDictionary["title"] as? String
            product.productDescription = productDictionary["productDescription"] as? String
            product.price = productDictionary["price"] as? String
            
            let imageName = productDictionary["image"] as? String
            let image = UIImage(named: imageName!)
            let imageData = UIImagePNGRepresentation(image!)
            product.imageData = imageData
        }
    }
    
    //
    // - - - - - - - - - - - - - - - -
    // MARK: - Table view data source
    // - - - - - - - - - - - - - - - -
    //
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height / 6.67
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductCell else {
            fatalError("The dequeued cell is not an instance of ProductCell.")
        }
        
        let product = products[indexPath.row]
        
        cell.productTitle.text = product.title
        cell.productPrice.text = product.price
        cell.productImage.image = UIImage(data: product.imageData!)

        return cell
    }

    //
    // - - - - - - - - - -
    // MARK: - Navigation
    // - - - - - - - - - -
    //

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showProductDetails" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedProduct = products[indexPath.row]
                
                let productDetailViewController = segue.destination as! ProductDetailViewController
                
                productDetailViewController.product = selectedProduct
            }
        }
    }
}
