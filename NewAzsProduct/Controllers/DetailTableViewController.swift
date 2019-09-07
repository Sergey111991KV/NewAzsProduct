//
//  DetailTableViewController.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 01.09.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
 
    
    //MARK: - Properties
    
    let cellDefaultId = "Default"

    var product: ProductAzs?
    var allShelvesAzs: [Shelves] = [Shelves.fife, Shelves.fifteen]
    var dateOfProducts: [Date]?
    var typeProduct = TypeProduct.all
    
    var name: String = ""
    var idAzs: Int!
    var idProduct: Int?
    var selectedTypeProduct : TypeProduct?{
        didSet{
                             tableView.reloadSections(IndexSet(arrayLiteral: 1), with: .fade)        }
    }
    var selectedShelvesProduct : Shelves?{
        didSet{
            
           
                             tableView.reloadSections(IndexSet(arrayLiteral: 3), with: .fade)
            print(selectedShelvesProduct)
        }
    }
    var selectedRow : IndexPath?{
        didSet{
            print(selectedRow)
        }
    }
    
    var isCheckInDate: Bool = false {
           didSet {
              
           }
       }
       var isCheckInType: Bool = false {
           didSet {
              
           }
       }
    
     var isCheckInShelves: Bool = false {
              didSet {
                 
              }
          }
       
    
    
    
    //MARK: - UIControllers Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = product == nil ? "Новый Продукт" : "\(product!.name)"
        name = product?.name ?? ""
        idProduct = product?.id ?? 0
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellDefaultId)
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.reuseId)
        tableView.register(TypeNameTableViewCell.self, forCellReuseIdentifier: TypeNameTableViewCell.reuseId)
        tableView.register(TypePickerTableViewCell.self, forCellReuseIdentifier: TypePickerTableViewCell.reuseId)
        tableView.register(DateLabelTableViewCell.self, forCellReuseIdentifier: DateLabelTableViewCell.reuseId)
        tableView.register(DatePickerTableViewCell.self, forCellReuseIdentifier: DatePickerTableViewCell.reuseId)
        tableView.register(ShelvesLabelTableViewCell.self, forCellReuseIdentifier: ShelvesLabelTableViewCell.reuseId)
        tableView.register(ShelvesPickerTableViewCell.self, forCellReuseIdentifier: ShelvesPickerTableViewCell.reuseId)
       tableView.register(IdTableViewCell.self, forCellReuseIdentifier: IdTableViewCell.reuseId)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(save))
        tableView.reloadData()
        
    }
    
  
    //MARK: - Table Header
    
       override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         switch section {
         case 0:
             return "Название продукта"
         case 1:
             return "Тип продукта"
         case 2:
             return "Сроки годности"
         case 3:
             return "Полки"
         case 4:
            return "Код товара"
         default:
             return "non"
         }
       
     }
    
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//         switch section {
//                case 0:
//                    return nil
//                case 1:
//
//                    return nil
//                case 2:
//                     let  button = UIButton(type: .system)
//                                       button.setTitle("+", for: .normal)
//                     let label = UILabel()
//                     label.text = "hkkhk"
//                     let viev = UIView()
//                     view.frame = CGRect(x: 0, y: 0, width: viev.frame.width, height: 50)
//                     view.addSubview(button)
//                     view.addSubview(label)
//
//                                       return view
//                case 3:
//                     let  button = UIButton(type: .system)
//                                       button.setTitle("+", for: .normal)
//
//                                       return button
//                case 4:
//                   return nil
//                default:
//                    return nil
//                }
//    }
//
//

    // MARK: - Table view data source
    
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let typeRow = tableView.numberOfRows(inSection: 1) - 1
        let dateRow = tableView.numberOfRows(inSection: 2) - 1
        let shelvesRow = tableView.numberOfRows(inSection: 3) - 1
        
        switch indexPath.section {
        case 1:
            if indexPath.row == typeRow  {
                return self.isCheckInType ? UITableView.automaticDimension : 0
            }
        case 2:
            if indexPath.row == dateRow  {
                return self.isCheckInDate ? UITableView.automaticDimension : 0
            }
        case 3:
            if indexPath.row == shelvesRow  {
                return self.isCheckInShelves ? UITableView.automaticDimension : 0
            }
            
        default:
            return  UITableView.automaticDimension
        }
        return  UITableView.automaticDimension
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            if product?.data != nil{
                return (product?.data!.count)! + 1
            }else{
                return 2
            }
            
        case 3:
            return (product?.shelves.count)! + 1
            
        case 4:
            return 1
            
        default:
            return 0
        }
        
        
        
    }
    // MARK: - Table view cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            
            //MARK: - NAME
            
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: NameTableViewCell.reuseId, for: indexPath) as! NameTableViewCell
            cell.nameTextField.delegate = self
            cell.nameTextField.text = product?.name
            
            return cell
            
            //MARK: - TYPE
            
        case 1:
            switch indexPath.row {
            case 0:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: TypeNameTableViewCell.reuseId, for: indexPath) as! TypeNameTableViewCell
                let titleProduct = product?.typeProduct.rawValue ?? "non"
              
                cell.labelType.text = selectedTypeProduct?.rawValue ?? titleProduct
                
                return cell
                
            case 1:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: TypePickerTableViewCell.reuseId, for: indexPath) as! TypePickerTableViewCell
                cell.typePicker.dataSource = self
                cell.typePicker.delegate = self
                if isCheckInType == false{
                    cell.isHidden = true
                }
                
                return cell
                
            default:
                let cell = defaultCellTable(indexPath: indexPath)
                return cell
            }
            
            //MARK: - DATE
            
        case 2:
            if product?.data != nil{
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: DateLabelTableViewCell.reuseId, for: indexPath) as! DateLabelTableViewCell
                return cell
                
                
            }else{
                switch indexPath.row {
                case 0:
                    let cell = defaultCellTable(indexPath: indexPath)
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableViewCell.reuseId, for: indexPath) as! DatePickerTableViewCell
                    if isCheckInDate == false{
                        cell.isHidden = true
                    }
                    return cell
                default:
                    let cell = defaultCellTable(indexPath: indexPath)
                    return cell
                }
            }
            
              //MARK: - SHELVES

        case 3:
            if product != nil{
                if indexPath.row <= (product?.shelves.count)! - 1{
                    let cell = tableView.dequeueReusableCell(withIdentifier: ShelvesLabelTableViewCell.reuseId, for: indexPath) as! ShelvesLabelTableViewCell
                     let numberShelveProduct = product!.shelves[indexPath.row].rawValue
                    if selectedRow != nil{
                        
                        switch indexPath.row {
                        case selectedRow!.row:
                             cell.labelShelves.text = String(selectedShelvesProduct?.rawValue ?? numberShelveProduct)
                        default:
                            
                            cell.labelShelves.text = String(numberShelveProduct)

                        }
                        
                    }
                    return cell
                    
                }else{
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: ShelvesPickerTableViewCell.reuseId, for: indexPath) as! ShelvesPickerTableViewCell
                    cell.shelvesPicker.dataSource = self
                    cell.shelvesPicker.delegate = self
                    if isCheckInShelves == false{
                        cell.isHidden = true
                    }
                    return cell
                }
                
            } else {
                switch indexPath.row {
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: ShelvesPickerTableViewCell.reuseId, for: indexPath) as! ShelvesPickerTableViewCell
                    if isCheckInShelves == false{
                        cell.isHidden = true
                    }
                    return cell
                default:
                    let cell = defaultCellTable(indexPath: indexPath)
                    return cell
                }
            }
            
  //MARK: - ID
            
            
        case 4:
             let cell = tableView.dequeueReusableCell(withIdentifier: IdTableViewCell.reuseId, for: indexPath) as! IdTableViewCell
             cell.idTextField.delegate = self
             cell.idTextField.text = String(product?.id ?? 0)
           
            
             return cell
        default:
            let cell = defaultCellTable(indexPath: indexPath)
            return cell
        }

    }
    
    
    func defaultCellTable(indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: cellDefaultId, for: indexPath)
        cell.textLabel?.text = "non"
        cell.textLabel?.textAlignment = NSTextAlignment.center
        return cell
        
    }
    
    
    //MARK: - Selected Row
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
        selectedRow = indexPath
        if indexPath.section == 1{
            isCheckInType.toggle()
            isCheckInDate = false
            isCheckInShelves = false
            
            
            

            tableView.reloadData()
            
            print("type")
            print(cell.tag)
            
        }
        if indexPath.section == 2{
            isCheckInDate.toggle()
            isCheckInType = false
            isCheckInShelves = false
            
            
            tableView.reloadData()
            print("date")
        }
        if indexPath.section == 3{
            isCheckInShelves.toggle()
            isCheckInDate = false
            isCheckInType = false
         
            selectedRow = indexPath
           
            tableView.reloadData()
            print("shelves")
            
        }
        
    }
    
    
    
    
}
//MARK: - UIPicker
extension DetailTableViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView {
        case is TypePickerView:
            
            
            return 1
        case is ShelvesPickerView:
            
            return 1
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case is TypePickerView:
            return typeProduct.count
        case is ShelvesPickerView:
            return allShelvesAzs.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         switch pickerView {
               case is TypePickerView:
                  selectedTypeProduct = typeProduct[row]

               case is ShelvesPickerView:
                   selectedShelvesProduct = allShelvesAzs[row]

               default:
                 break
               }
    }
}

extension DetailTableViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         switch pickerView {
               case is TypePickerView:
                  return typeProduct[row].rawValue
               case is ShelvesPickerView:
                return String(allShelvesAzs[row].rawValue)
               default:
                   return "non"
               }
        
        
        
    }
}




//MARK: - UITextField

extension DetailTableViewController: UITextFieldDelegate{
   
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case is NameTextField:
            name = textField.text ?? ""
        case is IdTextField:
            idProduct = Int(textField.text!)
        default:
            break
        }
        
      
    }
   
}

//MARK: - Save Function

extension DetailTableViewController{
@objc func save (){
    var shelvesArray = [Shelves]()
    shelvesArray.append(<#T##newElement: Shelves##Shelves#>)
    let product = ProductAzs(idAzs: idAzs, id: idProduct ?? 0, name: name, typeProduct: selectedTypeProduct ?? self.product!.typeProduct , data: nil, shelves: [Shelves.fife])

      print(#line, #function, product)
   
    }
}
