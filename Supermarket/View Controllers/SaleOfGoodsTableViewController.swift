//
//  SaleOfGoodsTableViewController.swift
//  Supermarket
//
//  Created by Kirill Koleno on 02.07.2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import UIKit
import CoreData

class SaleOfGoodsTableViewController: UITableViewController {
    
    lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var productsForSale = [ProductForSale]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest: NSFetchRequest<ProductForSale> = ProductForSale.fetchRequest()
        
        do {
            productsForSale = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addProduct(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Добавить товар", message: "Введите название товара", preferredStyle: .alert)
        let ok = UIAlertAction(title: "ОК", style: .default) { action in
            let textField = alertController.textFields?[0]
            
            self.saveProduct(name: (textField?.text)!)
            
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addTextField { textField in }
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func saveProduct(name: String) {
        let entity = NSEntityDescription.entity(forEntityName: "ProductForSale", in: context)
        let productObject = NSManagedObject(entity: entity!, insertInto: context) as! ProductForSale
        productObject.name = name
        
        do {
            try context.save()
            productsForSale.append(productObject)
        } catch {
            print(error.localizedDescription)
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
        return productsForSale.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "saleOfGoods", for: indexPath)

        let product = productsForSale[indexPath.row]
        
        cell.textLabel?.text = product.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let productToDelete = productsForSale[indexPath.row]
        
        if editingStyle == .delete {
            context.delete(productToDelete)
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), description: \(error.userInfo)")
        }
        
        let fetchRequest: NSFetchRequest<ProductForSale> = ProductForSale.fetchRequest()
        
        do {
            productsForSale = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Error While Fetching Data From DB: \(error.userInfo)")
        }
        
        tableView.reloadData()
    }

    //
    // - - - - - - - - - -
    // MARK: - Navigation
    // - - - - - - - - - -
    //

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showSaledProductDetails" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                let selectedProduct = productsForSale[indexPath.row]
//                
//                let productDetailViewController = segue.destination as! ProductDetailViewController
//            }
//        }
//    }
}
