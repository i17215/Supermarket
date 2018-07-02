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
    
    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getProductsFromFile() {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        var productsCount = 0
        
        do {
            let count = try context.count(for: fetchRequest)
            productsCount = count
        } catch {
            print(error.localizedDescription)
        }
        
        guard productsCount == 0 else { return }
        
        let pathToFile = Bundle.main.path(forResource: "ProductsData", ofType: "plist")
        let productsArray = NSArray(contentsOfFile: pathToFile!)!
        
        for dictionary in productsArray {
            let entity = NSEntityDescription.entity(forEntityName: "Product", in: context)
            let product = NSManagedObject(entity: entity!, insertInto: context) as! Product
            
            let productsDictionary = dictionary as! NSDictionary
            
            product.productTitle = productsDictionary["productTitle"] as? String
            product.productDescription = productsDictionary["productDescription"] as? String
            product.productPrice = (productsDictionary["productPrice"] as? Double)!
            
            let imageName = productsDictionary["image"] as? String
            let image = UIImage(named: imageName!)
            let imageData = UIImagePNGRepresentation(image!)
            product.image = imageData
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
        // #warning Incomplete implementation, return the number of rows
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
        
        cell.productTitle.text = product.productTitle
        cell.productPrice.text = String(product.productPrice)
        cell.productImage.image = UIImage(data: product.image!)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
