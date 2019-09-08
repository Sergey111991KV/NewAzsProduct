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
    
   let searchController = UISearchController(searchResultsController: nil)
    let cellId = "product"
    let arrayAllProduct: [Azs] = [
        Azs(id: 9, product: [
            ProductAzs(idAzs: 9, id: 1, name: "Масло Лукойл 1л", typeProduct: .oil, data: nil, shelves: [.fife, .fifteen]),
            ProductAzs(idAzs: 9, id: 2, name: "Тосол", typeProduct: .tosol, data: nil, shelves: [.six]),
            ProductAzs(idAzs: 9, id: 3, name: "Дирол", typeProduct: .bubleGum, data: nil, shelves: [.first])
        
        ], shelves: [.fife,.fifteen,.first,.four,.second,.six,.sixteen,.third] ),
        Azs(id: 16, product: [
            ProductAzs(idAzs: 16, id: 1, name: "Масло Лукойл 1л", typeProduct: .oil, data: nil, shelves: [.fife]),
            ProductAzs(idAzs: 16, id: 2, name: "Тосол", typeProduct: .tosol, data: nil, shelves: [.six]),
            ProductAzs(idAzs: 16, id: 3, name: "Дирол", typeProduct: .bubleGum, data: nil, shelves: [.first])], shelves: [.fife,.fifteen,.first,.four,.second,.six,.sixteen,.third])
    ]
    var arrayForSearh = [ProductAzs]()
    var currentArrayProduct: [ExpendablesProduct]!
    var userAzs: UserAzs!
    
    private var filteredProduct = [ProductAzs]()
    private var searchBarIsEmpty: Bool{
        guard let text = searchController.searchBar.text else{ return false }
        return text.isEmpty
    }
    private var isFiltering: Bool{
        return searchController.isActive && !searchBarIsEmpty
    }
    
    
    //MARK: - Controllers Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayForSearh = createArrayForSearch(azsArray: arrayAllProduct, user: userAzs)
        currentArrayProduct = arrayProductAzs(arrayAll: arrayAllProduct, userAzs: userAzs)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Товары на азс \(userAzs.nameAzs)"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Продукт"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        print(arrayForSearh)
    }

    // MARK: - Table Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isFiltering {
            return nil
        }
        let header = UIView()
        print(tableView.sectionFooterHeight)
        header.backgroundColor = UIColor.blue
        
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.white, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.tag = section
        button.addTarget(self, action: #selector(openCloth), for: .touchUpInside)
       
        button.setTitle("Открыть", for: .normal)
        let label = UILabel()
        
        label.textColor = UIColor.white
        
        label.text = currentArrayProduct[section].product.first?.typeProduct.rawValue
        label.translatesAutoresizingMaskIntoConstraints = false
        
        header.addSubview(button)
        header.addSubview(label)
        
        
        label.heightAnchor.constraint(equalTo: header.heightAnchor , multiplier: 1/2).isActive = true
        label.widthAnchor.constraint(equalTo: header.widthAnchor , multiplier: 1/2).isActive = true
        label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant:  8).isActive = true
        label.topAnchor.constraint(equalTo: header.topAnchor, constant: 12).isActive = true
        
        
        button.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -8).isActive = true
        button.widthAnchor.constraint(equalTo: header.widthAnchor , multiplier: 1/6).isActive = true
        button.topAnchor.constraint(equalTo: header.topAnchor, constant: 12).isActive = true
        button.heightAnchor.constraint(equalTo: header.heightAnchor , multiplier: 1/2).isActive = true
        
        return header
    }
    
    
    @objc func openCloth(button: UIButton ){
        
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in currentArrayProduct[section].product.indices{
            print(section, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        let isExpendable = currentArrayProduct[section].isExplandable
        currentArrayProduct[section].isExplandable = !isExpendable
        button.setTitle(isExpendable ? "Открыть" : "Закрыть", for: .normal)
        if isExpendable{
            tableView.deleteRows(at: indexPaths, with: .fade )

        } else {
            
            tableView.insertRows(at: indexPaths, with: .fade)
    }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isFiltering{
            return 0
        }
        return 50
    }
    
    //MARK: - TableView Methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering{
            return 1
        }
        return currentArrayProduct.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering{
           return filteredProduct.count
        } else{
            
            if !currentArrayProduct[section].isExplandable{
                return 0
            }else{
                return currentArrayProduct[section].product.count
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFiltering{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            let name = arrayForSearh[indexPath.row].name
            cell.textLabel?.text = name
            
            return cell
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let name = currentArrayProduct[indexPath.section].product[indexPath.row].name
        cell.textLabel?.text = name
        
        return cell
    }
    
    
    
    //MARK: - Methods for Array
    
    func arrayProductAzs(arrayAll: [Azs], userAzs: UserAzs) -> [ExpendablesProduct]{
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
    
    func createArrayProduct(array:[ProductAzs]) -> [ExpendablesProduct]{
        var arrayFinish = [ExpendablesProduct]()
        var arrayCount = [TypeProduct]()
        
        for product in array{
            arrayCount.append(product.typeProduct)
        }
        let uniqueCount = Array(Set(arrayCount))
        for product in array{
            for uniq in uniqueCount{
                if product.typeProduct == uniq{
                  var newArray = createArrayTypeProduct()
                    newArray.product.append(product)
                    arrayFinish.append(newArray)
                    
                }
            }
        }
        
        return arrayFinish
    }
    
    func createArrayTypeProduct() -> ExpendablesProduct{
        let array = ExpendablesProduct(isExplandable: true, product: [])
        
        return array
    }
    
  //MARK: - Array Shelves
    
    func createArrayShelves(array: [Azs], product: ProductAzs) -> [Shelves]{
        var shelvesArray = [Shelves]()
        for azs in array{
            if azs.id == product.idAzs{
                shelvesArray = azs.shelves
                    }
                }
        return shelvesArray
    }
    
    func createArrayForSearch(azsArray: [Azs], user: UserAzs) -> [ProductAzs]{
        var arrayFor = [ProductAzs]()
        for azs in azsArray{
            if azs.id == user.nameAzs{
                for product in azs.product{
                    arrayFor.append(product)
                }
            }
        }
        
        return arrayFor
    }
    
}

//MARK: - Navigation

extension ProductTableViewController{
    
       // MARK: - Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard segue.identifier == "ProductAzs" else { return }
            guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
            
            let destination = segue.destination as! DetailTableViewController
            let product: ProductAzs
            if isFiltering{
                product = filteredProduct[selectedIndex.row]
            }else{
                product = currentArrayProduct[selectedIndex.section].product[selectedIndex.row]
            }
            
            
            let arrayShelves = createArrayShelves(array: arrayAllProduct, product: product)
            
            destination.product = product
            destination.allShelvesAzs = arrayShelves
            destination.idAzs = userAzs.nameAzs
            
            
        }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ProductAzs", sender: self)
    }
//        @IBAction func unwind(_ segue: UIStoryboardSegue) {
//            guard segue.identifier == "SaveSegue" else { return }
//            guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
//            let source = segue.source as! DetailTableViewController
//
//            for azs in arrayAllProduct{
//                if azs.id == source.product.idAzs{
//                    for product in azs.product{
//                        if product.id == source.product.id{
//
//                            product = source.product
//                        }
//                    }
//                }
//            }
//            currentArrayProduct[selectedIndex.section].product[selectedIndex.row] = source.product
//            tableView.reloadRows(at: [selectedIndex], with: .automatic)
//        }
    }
//MARK: - SearchResultControllers

extension ProductTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_  searchText: String) {
        filteredProduct = arrayForSearh.filter({ (product: ProductAzs) -> Bool in
            return product.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
}
    
    

