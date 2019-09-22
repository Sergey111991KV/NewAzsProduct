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
    var gradient :CAGradientLayer!
   let searchController = UISearchController(searchResultsController: nil)
   
    var azsNine = Shop(id: 9, product: [
            ProductSho(idShop: 9, id: 1, name: "Масло Лукойл 1л", typeProduct: .oil, data: nil, shelves: [.fife, .fifteen]),
            ProductSho(idShop: 9, id: 2, name: "Тосол", typeProduct: .tosol, data: nil, shelves: [.six]),
            ProductSho(idShop: 9, id: 3, name: "Дирол", typeProduct: .bubleGum, data: nil, shelves: [.first]),
            ProductSho(idShop: 9, id: 4, name: "Тормозная жидкость", typeProduct: .tosol, data: nil, shelves: [Shelves.fife]),
            ProductSho(idShop: 9, id: 5, name: "Орбит", typeProduct: .bubleGum, data: nil, shelves: [Shelves.sixteen]),
            ProductSho(idShop: 9, id: 6, name: "Sico 12", typeProduct: .prezervative, data: nil, shelves: [Shelves.sixteen])
        
        ], shelves: [.fife,.fifteen,.first,.four,.second,.six,.sixteen,.third] )
      var azsSixteen = Shop(id: 16, product: [
            ProductSho(idShop: 16, id: 1, name: "Масло Лукойл 1л", typeProduct: .oil, data: nil, shelves: [.fife]),
            ProductSho(idShop: 16, id: 2, name: "Тосол", typeProduct: .tosol, data: nil, shelves: [.six]),
            ProductSho(idShop: 16, id: 3, name: "Дирол", typeProduct: .bubleGum, data: nil, shelves: [.first])], shelves: [.fife,.fifteen,.first,.four,.second,.six,.sixteen,.third])
    
    
    var arrayProductForTable: [ExpendablesProduct]!
    
    var userAzs: UserShop!
    
    var currentAzs : Shop!
    
    var arrayIndexBadDate = [IndexPath]()
    var productInAzs = [ProductSho](){
        didSet{
            
            arrayProductForTable = createArrayExpendable(arrayProduct: productInAzs)
        }
    }
   
    var filteredSwitchArrayProdukt = [ProductSho]()
    var filteredSearchBarProduct = [ProductSho]()
    
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
        gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]
        let viewTable = UIView()
        viewTable.layer.addSublayer(gradient)
       
        self.tableView.backgroundView = viewTable
        self.tableView.separatorStyle = .none
        
        
        if userAzs.nameShopId == 16{
            currentAzs = azsSixteen
        } else{
            currentAzs = azsNine
        }
        productInAzs = currentAzs.product
       
       
        arrayProductForTable = createArrayExpendable(arrayProduct: productInAzs)
        
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseId)

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Товары магазина \(userAzs.nameShopId)"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Продукт"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        createSwitch()
        print(arrayIndexBadDate)
       
        
    }
    
    @objc func  newProduct() {
        performSegue(withIdentifier: "NewProduct", sender: self)
    }
    
    
    // MARK: - Table Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isFiltering {
            return nil
        }
        gradient = CAGradientLayer()
        
        gradient.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]
        
        let header = UIView()
        
        header.layer.addSublayer(gradient)
        
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.white, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.tag = section
        button.addTarget(self, action: #selector(openCloth), for: .touchUpInside)
       
        button.setTitle("▼", for: .normal)
        let label = UILabel()
        
        label.textColor = UIColor.white
        
        label.text = arrayProductForTable[section].product.first?.typeProduct.rawValue
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
        for row in arrayProductForTable[section].product.indices{
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        print(indexPaths)
        let isExpendable = arrayProductForTable[section].isExplandable
        button.setTitle(isExpendable ? "▲" : "▼", for: .normal)
        arrayProductForTable[section].isExplandable = !isExpendable
        
        if isExpendable{
            
            
            tableView.deleteRows(at: indexPaths, with: .automatic )

        } else {
           
            tableView.insertRows(at: indexPaths, with: .automatic)
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
        return arrayProductForTable.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering{
           return filteredSearchBarProduct.count
        } else{
            
            if arrayProductForTable[section].isExplandable{
                return arrayProductForTable[section].product.count
            }else{
                return 0
            }
        }
    }
    //MARK: - Cell Configure
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if isFiltering{
             let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
            let name = filteredSearchBarProduct[indexPath.row].name
            let date = filteredSearchBarProduct[indexPath.row].data?.first
            
            cell.labelProduct.text = name
            cell.backgroundColor = UIColor.clear
            if date != nil{
                
                
                let currentDate = Date()
                let diffInDays = Calendar.current.dateComponents([.day], from: currentDate, to: date!).day
                
                if diffInDays! < 3 {
                    cell.labelDateProduct.textColor = UIColor.red
                    
                    arrayIndexBadDate.append(indexPath)
                    
                }else{
                    cell.labelDateProduct.textColor = UIColor.blue
                }
                
                cell.labelDateProduct.text = dateFormatter.string(from: date!)
                
            } else{
                cell.labelDateProduct.text = "Non Date"
                cell.labelDateProduct.textColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
            }
            
            
            return cell
            
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
       
            
            let name = arrayProductForTable[indexPath.section].product[indexPath.row].name
            let date = arrayProductForTable[indexPath.section].product[indexPath.row].data?.first
            let product = arrayProductForTable[indexPath.section].product[indexPath.row]
            cell.labelProduct.text = name
            cell.backgroundColor = UIColor.clear
            if date != nil{
                
                let currentDate = Date()
                let diffInDays = Calendar.current.dateComponents([.day], from: currentDate, to: date!).day
                
                if diffInDays! < 3 {
                    cell.labelDateProduct.textColor = UIColor.red
                    cell.labelDateProduct.text = dateFormatter.string(from: date!)
                    if filteredSwitchArrayProdukt.isEmpty == false{
                        
                        for filterProd in filteredSwitchArrayProdukt{
                            if filterProd.id == product.id{
                                
                                return cell
                            }
                            
                        }
                    }
                    filteredSwitchArrayProdukt.append(product)
                     
                  
                    
                }else{
                    cell.labelDateProduct.textColor = UIColor.blue
                }
                
                cell.labelDateProduct.text = dateFormatter.string(from: date!)
                
            } else{
                cell.labelDateProduct.text = "Non Date"
            }
            
        return cell
    }
        
       
    
    }
    
    //MARK: - Methods for Array
    
    func createArrayExpendable(arrayProduct:[ProductSho]) -> [ExpendablesProduct]{
        var arrayExpendaple = [ExpendablesProduct]()
        var arrayCount = [TypeProduct]()
        var arrayShelves = [Shelves]()
        var newArrayProduct = [ProductSho]()
        if userAzs.type == UserTypeShop.operatorAzs{
        for shelves in userAzs.shelves!{
                arrayShelves.append(shelves)
            }
            for product in arrayProduct{
                for shelves in product.shelves{
                    for operatorShelves in arrayShelves{
                        if shelves == operatorShelves{
                            newArrayProduct.append(product)
                        }
                    }
                }
            }
        } else{
            arrayShelves = currentAzs.shelves
            newArrayProduct = arrayProduct
        }
        
        for product in newArrayProduct{
            arrayCount.append(product.typeProduct)
        }
        let uniqueCount = Array(Set(arrayCount))
            for uniq in uniqueCount{
                let expend = ExpendablesProduct(isExplandable: true, product: [], typeProduct: uniq)
                arrayExpendaple.append(expend)
        }
        for product in newArrayProduct{
            for  expend in arrayExpendaple{
              
                if product.typeProduct == expend.typeProduct{
                    let index = arrayExpendaple.firstIndex(where: {$0.typeProduct == expend.typeProduct})
                    
                    arrayExpendaple[index!].product.append(product)
                }
            }
        }
        print(arrayExpendaple)
        let sortedArrayExpendaple = arrayExpendaple.sorted(by: {$0.typeProduct.rawValue < $1.typeProduct.rawValue})
        return sortedArrayExpendaple
    }
    
}

//MARK: - Navigation

extension ProductTableViewController{
    

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
           let selectedIndex = tableView.indexPathForSelectedRow
          
            switch segue.identifier {
            case "ProductAzs":
                let destination = segue.destination as! DetailTableViewController
                let product: ProductSho
                if isFiltering{
                    product = filteredSearchBarProduct[selectedIndex!.row]
                    print(product)
                    print(filteredSearchBarProduct)
                }else{
                   
                    product = arrayProductForTable[selectedIndex!.section].product[selectedIndex!.row]
                }
                
                
                let arrayShelves = currentAzs.shelves
                
                destination.product = product
                destination.allShelvesAzs = arrayShelves
                destination.idAzs = userAzs.nameShopId
                
                
                
                
            case "NewProduct":
                let destination = segue.destination as! DetailTableViewController
                let arrayShelves = currentAzs.shelves
                print(arrayShelves)
                destination.allShelvesAzs = arrayShelves
                destination.idAzs = userAzs.nameShopId
            default:
                break
            }
            
            
            
        }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ProductAzs", sender: self)
    }
@IBAction func unwind(_ segue: UIStoryboardSegue) {
     
   //   guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
      let source = segue.source as! DetailTableViewController
   
            for product in productInAzs{
           
                if product.id == source.product?.id{
                    let index = productInAzs.firstIndex(where: {$0.id == product.id})
                    productInAzs[index!] = source.product!
                    print("поменялись")
                    
                    arrayIndexBadDate.removeAll()
                    tableView.reloadData()
                    return
                }
                    
                
            }
    arrayIndexBadDate.removeAll()
    productInAzs.append(source.product!)
            print("добавились")
           
          

      tableView.reloadData()
    }
    }
//MARK: - SearchResultControllers

extension ProductTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
       
    }
    
    private func filterContentForSearchText(_  searchText: String) {
        filteredSearchBarProduct = productInAzs.filter({ (product: ProductSho) -> Bool in
            return product.name.lowercased().contains(searchText.lowercased())
        })
        arrayIndexBadDate.removeAll()
        tableView.reloadData()
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pan = scrollView.panGestureRecognizer
        let velocity = pan.velocity(in: scrollView).y
        if velocity < -5 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.navigationController?.setToolbarHidden(true, animated: true)
        } else if velocity > 10 {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController?.setToolbarHidden(false, animated: true)
        }
    }
    

//MARK: - Switch
    func createSwitch(){
        let switchControl = UISwitch(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 50, height: 30)))
        switchControl.isOn = false
        switchControl.onTintColor = UIColor.gray
        switchControl.setOn(true, animated: false)
        switchControl.addTarget(self, action: #selector(switchValueDidChange(sender:)), for: .valueChanged)
       
        
        let switchController = UIBarButtonItem.init(customView: switchControl)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newProduct))
        self.navigationItem.rightBarButtonItems = [switchController,addButton]
    }

    @objc func switchValueDidChange(sender: UISwitch!)
    {
        if sender.isOn {
             
              arrayProductForTable = createArrayExpendable(arrayProduct: filteredSwitchArrayProdukt)
            tableView.reloadData()
        } else{
             
             arrayProductForTable = createArrayExpendable(arrayProduct: productInAzs)
            tableView.reloadData()
        }
    }
}
    
    

