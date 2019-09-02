//
//  ProductTableViewController.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 31.08.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

class ProductTableViewController: UITableViewController {
    
    //MARK: - Propertyes
    
  
    let cellId = "product"
    let arrayAllProduct: [Azs] = [
        Azs(id: 9, product: [
            ProductAzs(id: 1, name: "Масло Лукойл 1л", typeProduct: .oil, data: nil, shelves: [.fife]),
            ProductAzs(id: 2, name: "Тосол", typeProduct: .tosol, data: nil, shelves: [.six]),
            ProductAzs(id: 3, name: "Дирол", typeProduct: .bubleGum, data: nil, shelves: [.first])
        
        ]),
        Azs(id: 16, product: [
            ProductAzs(id: 1, name: "Масло Лукойл 1л", typeProduct: .oil, data: nil, shelves: [.fife]),
            ProductAzs(id: 2, name: "Тосол", typeProduct: .tosol, data: nil, shelves: [.six]),
            ProductAzs(id: 3, name: "Дирол", typeProduct: .bubleGum, data: nil, shelves: [.first])
        ])
    

    
    ]
    
    var currentArrayProduct: [[ProductAzs]]!
    var userAzs: UserAzs!
    
    
    
    //MARK: - Controllers Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userAzs.nameAzs)
        currentArrayProduct = arrayProductAzs(arrayAll: arrayAllProduct, userAzs: userAzs)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Товары на азс \(userAzs.nameAzs)"
        
      
    }

    // MARK: - Table Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeader.footerId) as! TableHeader
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    //MARK: - TableView Methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return currentArrayProduct.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentArrayProduct[section].count
    }
    
    
           override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            
            let name = currentArrayProduct[indexPath.section][indexPath.row].name
            
            
            cell.textLabel?.text = name
        

        return cell
    }
    
    
    
    //MARK: - Methods for Array
    
    func arrayProductAzs(arrayAll: [Azs], userAzs: UserAzs) -> [[ProductAzs]]{
        var currenArrayProduct = [ProductAzs]()
        for azs in arrayAll{
            if azs.id == userAzs.nameAzs{
                if userAzs.type ==  UsetTypeAzs.tovaroved{
                    currenArrayProduct = azs.product
                } else{
                if userAzs.type ==  UsetTypeAzs.operatorAzs{
                    for product in azs.product{
                        for shelves in product.shelves{
                            for shelvesUser in userAzs.shelves!{
                                if shelves == shelvesUser{
                                    currenArrayProduct.append(product)
                                }
                            }
                        }
                    }
                      
                        
                    }
                    
                }
                }
                }
            
           
        let arrayFinish = createArrayProduct(array: currenArrayProduct)
         return arrayFinish
        }
        
    func createArrayProduct(array:[ProductAzs]) -> [[ProductAzs]]{
        var arrayFinish = [[ProductAzs]]()
        var arrayCount = [TypeProduct]()
        
        for product in array{
            arrayCount.append(product.typeProduct)
        }
        let uniqueCount = Array(Set(arrayCount))
        for product in array{
            for uniq in uniqueCount{
                if product.typeProduct == uniq{
                  var newArray = createArrayTypeProduct()
                    newArray.append(product)
                    arrayFinish.append(newArray)
                    
                }
            }
        }
        print(arrayFinish)
        return arrayFinish
    }
    
    func createArrayTypeProduct() -> [ProductAzs]{
        let array = [ProductAzs] ()
        return array
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
