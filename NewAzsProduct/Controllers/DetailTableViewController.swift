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
    var typeProductAll = TypeProduct.all
    var shelvesProductAll = Shelves.all
    var name: String = ""
    var idAzs: Int!
    var idProduct: Int?
    var newData: Date?
    var newDataArray = [Date]()
    var selectedTypeProduct : TypeProduct?{
        didSet{
                             tableView.reloadSections(IndexSet(arrayLiteral: 1), with: .automatic)        }
    }
    var newShelves: Shelves?{
        didSet{
             let rowsShalve = tableView.numberOfRows(inSection: 3)
                   if newShelvesArray.isEmpty == true{
                       newShelvesArray.append(newShelves!)
                   } else{
                       if selectedRow!.row == (rowsShalve - 2){
                             newShelvesArray.append(newShelves!)
                       }else{
                         newShelvesArray[selectedRow!.row] = newShelves!
                    }
                   }
                   tableView.reloadData()
               }
        
    }
    
    var newShelvesArray = [Shelves]()
    
    var selectedRow : IndexPath?
    
    var isCheckInDate: Bool = false
    var isCheckInType: Bool = false
    
     var isCheckInShelves: Bool = false
    
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
        if product != nil {
            let dataArrayProduct = product?.data ?? []
            let productShelvesArray = product!.shelves
                for data in dataArrayProduct{
                    newDataArray.append(data)
                    print(newDataArray)
                }
                for shelves in productShelvesArray{
                newShelvesArray.append(shelves)
            }
            }
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
            if newDataArray.isEmpty == false{
                return newDataArray.count + 2
            }else{
                return 2
            }
            
        case 3:
            if newShelvesArray.isEmpty == false{
                return newShelvesArray.count + 2
            }else{
                return 2
            }
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
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.locale = Locale.current
            let numberOfRows = tableView.numberOfRows(inSection: 2) - 1
            if newDataArray.isEmpty == false{
                if indexPath.row <= newDataArray.count - 1{
                    let cell = tableView.dequeueReusableCell(withIdentifier: DateLabelTableViewCell.reuseId, for: indexPath) as! DateLabelTableViewCell
                    
                    print(newDataArray)
                    cell.labelDate.text = dateFormatter.string(from: newDataArray[indexPath.row])
                    return cell
                }else{
                    switch indexPath.row {
                    case numberOfRows :
                        let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableViewCell.reuseId, for: indexPath) as! DatePickerTableViewCell
                        cell.datePickerProdukt.addTarget(self, action: #selector(datePickerValue(datePicker:)), for: .valueChanged)
                        if isCheckInDate == false{
                            cell.isHidden = true
                        }
                        return cell
                        
                    default:
                        let cell = defaultCellTable(indexPath: indexPath)
                        return cell
                    }
                }
            }else{
                switch indexPath.row {
                case 0:
                    let cell = defaultCellTable(indexPath: indexPath)
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableViewCell.reuseId, for: indexPath) as! DatePickerTableViewCell
                    cell.datePickerProdukt.addTarget(self, action: #selector(datePickerValue(datePicker:)), for: .valueChanged)
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
            let numberOfRows = tableView.numberOfRows(inSection: 3) - 1
            if product != nil{
                if indexPath.row <= newShelvesArray.count - 1{
                    let cell = tableView.dequeueReusableCell(withIdentifier: ShelvesLabelTableViewCell.reuseId, for: indexPath) as! ShelvesLabelTableViewCell
                    cell.labelShelves.text = String(newShelvesArray[indexPath.row].rawValue)
                    return cell
                } else{
                    switch indexPath.row {
                    case numberOfRows :
                        let cell = tableView.dequeueReusableCell(withIdentifier: ShelvesPickerTableViewCell.reuseId, for: indexPath) as! ShelvesPickerTableViewCell
                        cell.shelvesPicker.dataSource = self
                        cell.shelvesPicker.delegate = self
                        if isCheckInShelves == false{
                            cell.isHidden = true
                        }
                        return cell
                    default:
                        let cell = defaultCellTable(indexPath: indexPath)
                        return cell
                    }
                }
            }else{
                switch indexPath.row {
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: ShelvesPickerTableViewCell.reuseId, for: indexPath) as! ShelvesPickerTableViewCell
                    cell.shelvesPicker.dataSource = self
                    cell.shelvesPicker.delegate = self
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
//MARK: - DEFAULT
        default:
            let cell = defaultCellTable(indexPath: indexPath)
            return cell
    }
    }
    
    func defaultCellTable(indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: cellDefaultId, for: indexPath)
        cell.textLabel?.text = "+"
        cell.textLabel?.textAlignment = NSTextAlignment.center
        return cell
    }
    
    @objc func datePickerValue(datePicker: UIDatePicker){
        newData = datePicker.date
         let rowsDate = tableView.numberOfRows(inSection: 2)
        if newDataArray.isEmpty == true{
            newDataArray.append(newData!)
        } else{
            if selectedRow!.row < rowsDate - 2{
                newDataArray[selectedRow!.row] = newData!
            }else{
                newDataArray.append(newData!)
            }
        }
        tableView.reloadData()
    }
    //MARK: - Selected Row
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {return}
       
       
        cell.backgroundColor = UIColor.red
        if indexPath.section == 1{
            isCheckInType.toggle()
            isCheckInDate = false
            isCheckInShelves = false
          tableView.reloadData()
            
            print("type")
            
        }
        if indexPath.section == 2{
            
            if indexPath.row != selectedRow?.row{
            isCheckInDate = true
            isCheckInType = false
            isCheckInShelves = false
            }else{
                isCheckInDate.toggle()
                isCheckInType = false
                isCheckInShelves = false
            }
            
            tableView.reloadData()
            print("date")
        }
        if indexPath.section == 3{
            if indexPath.row != selectedRow?.row{
                
                isCheckInShelves = true
                isCheckInDate = false
                isCheckInType = false
                
            }else{
                isCheckInShelves.toggle()
                isCheckInDate = false
                isCheckInType = false
            }
            tableView.reloadData()
            print("shelves")
            
        }
        selectedRow = indexPath
    }
    
//MARK: - Editing Cell
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let rowsDate = tableView.numberOfRows(inSection: 2) - 2
        let rowsShelve = tableView.numberOfRows(inSection: 3) - 2
        switch indexPath.section {
        case 2:
            if indexPath.row < rowsDate{ return true } else{ return false}
         
        case 3:
             if indexPath.row < rowsShelve{ return true } else{ return false}
        default:
            return false
        }
       
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
             if editingStyle == .delete {
                  print("Deleted")
                  self.newDataArray.remove(at: indexPath.row)
                  self.tableView.beginUpdates()
                  self.tableView.deleteRows(at: [indexPath], with: .automatic)
                  self.tableView.endUpdates()
                   
                   }
            
            
        case 3:
             if editingStyle == .delete {
                  print("Deleted")
                  self.newShelvesArray.remove(at: indexPath.row)
                  self.tableView.beginUpdates()
                  self.tableView.deleteRows(at: [indexPath], with: .automatic)
                  self.tableView.endUpdates()
                   
                   }
            
        default:
            return
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
            return typeProductAll.count
        case is ShelvesPickerView:
            return allShelvesAzs.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         switch pickerView {
               case is TypePickerView:
                  selectedTypeProduct = typeProductAll[row]

               case is ShelvesPickerView:
                   newShelves = shelvesProductAll[row]
    
         default:
                 break
               }
    }
}

extension DetailTableViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         switch pickerView {
               case is TypePickerView:
                  return typeProductAll[row].rawValue
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
            idProduct = Int(textField.text ?? "0")
        default:
            break
        }
        
      
    }
   
}

//MARK: - Save Function

extension DetailTableViewController{
@objc func save (){
   
   
    let newProduct = ProductAzs(idAzs: idAzs, id: idProduct ?? 0, name: name, typeProduct: selectedTypeProduct ?? self.product!.typeProduct , data: newDataArray, shelves: product!.shelves)

      print(#line, #function, newProduct)
   
    }
}
