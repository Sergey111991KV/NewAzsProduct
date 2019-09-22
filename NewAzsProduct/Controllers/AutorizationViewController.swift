//
//  AutorizationViewController.swift
//  NewAzsProduct
//
//  Created by Сергей Косилов on 31.08.2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit

class AutorizationViewController: UIViewController {
    
    let productsShopRequest = ResourseRequest<ProductShop>(resoursePath: "productShops")
    var currentUser: UserShop!
    var productInRequest: [ProductShop] = []
    let users = [
        UserShop(id: 0, nameAzs: 16, type: .tovaroved, shelves: nil, login: "Anna", password: "123456"),
        UserShop(id: 1, nameAzs: 16, type: .operatorAzs, shelves: [Shelves.four, Shelves.fife, Shelves.fifteen, Shelves.sixteen], login: "Sergey", password: "123"),
        UserShop(id: 2, nameAzs: 9, type: .tovaroved, shelves: nil, login: "Ira", password: "123456"),
        UserShop(id: 3, nameAzs: 9, type: .operatorAzs, shelves: [Shelves.first, Shelves.second, Shelves.fifteen, Shelves.sixteen], login: "Katy", password: "123"),
        UserShop(id: 4, nameAzs: 9, type: .director, shelves: nil, login: "Abramenko", password: "1234567")
    ]
    
    //MARK: - Properties
    
    private var activeField: UITextField?
    
    var scroll = UIScrollView()
    var firstView = UIImageView()
    var secondView = UIImageView()
    var logoView = UIImageView()
    var loginTextFild = UITextField()
    var passwordTextField = UITextField()
    var logButton = UIButton()
    var forgotButton = UIButton()
       
    var frameView = CGSize()
    
    //MARK: - ViewControllers Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productsShopRequest.getAll { [weak self] productShopResult in
            switch productShopResult {
               
            case .failure:
                print("ErrorPresenter")
            case .success(let products):
            DispatchQueue.main.async { [weak self] in
                self?.productInRequest = products
                
                }
        }
        }
        frameView = self.view.frame.size
        verticalOrGorizontalView(size: frameView)
        print(productInRequest)
       
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        verticalOrGorizontalView(size: size)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardNotificationObservers()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotificationObservers()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    //MARK: - Inithialization
    
    func verticalOrGorizontalView(size: CGSize){
       
        scroll = UIScrollView(frame: self.view.bounds)
        scroll.frame.size = size
        
        let backgroundImage = UIImage(named: "Background")
        firstView = UIImageView(frame: scroll.frame)
        firstView.image = backgroundImage
        firstView.contentMode = .scaleAspectFill
        
        let isVertical = size.width < size.height
        if isVertical{
             let point = CGPoint(x: self.scroll.frame.width / 6, y: self.scroll.frame.height / 4)
            secondView = UIImageView(frame: CGRect(origin: point, size: CGSize(width: size.width / 1.5, height: size.height / 2.5)))
            let textFieldImage = UIImage(named: "Union 1")
                  secondView.image = textFieldImage
           
        }else{
            
            let point = CGPoint(x: self.scroll.frame.width / 4, y: self.scroll.frame.height / 8)
            secondView = UIImageView(frame: CGRect(origin: point, size: CGSize(width: size.width / 2, height: size.height / 1.5)))
           let textFieldImage = UIImage(named: "Union 1")
           secondView.image = textFieldImage
        }
        let pointLogo = CGPoint(x:secondView.frame.origin.x + secondView.frame.width / 4 , y:secondView.frame.origin.y + secondView.frame.height / 8)
        let logoImage = UIImage(named: "LogoFinish")
        logoView = UIImageView(frame: CGRect(origin: pointLogo, size: CGSize(width: secondView.frame.width / 2, height: secondView.frame.height / 4)))
        logoView.image = logoImage
        logoView.contentMode = .scaleAspectFit
        
        let poinLoginTF = CGPoint(x:secondView.frame.origin.x + secondView.frame.width / 8, y:secondView.frame.origin.y + secondView.frame.height / 2)
        loginTextFild = UITextField(frame: CGRect(origin: poinLoginTF, size: CGSize(width: secondView.frame.width / 1.4, height: secondView.frame.height / 8)))
        loginTextFild.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        loginTextFild.placeholder = "Login"
        loginTextFild.borderStyle = .roundedRect
        
        let poinPasswordTF = CGPoint(x:secondView.frame.origin.x + secondView.frame.width / 8, y:secondView.frame.origin.y + secondView.frame.height / 1.5)
        passwordTextField = UITextField(frame: CGRect(origin: poinPasswordTF, size: CGSize(width: secondView.frame.width / 1.4, height: secondView.frame.height / 8)))
        passwordTextField.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isUserInteractionEnabled = true
        
        let poinLogButton = CGPoint(x:secondView.frame.origin.x + secondView.frame.width / 8, y:secondView.frame.origin.y + secondView.frame.height / 1.2)
        logButton = UIButton(type: .system)
        logButton.frame = CGRect(origin: poinLogButton, size: CGSize(width: secondView.frame.width / 1.4, height: secondView.frame.height / 8))
        logButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        logButton.setTitle("LOGIN", for: .normal)
        logButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        logButton.layer.cornerRadius = 5
        logButton.addTarget(self, action: #selector(tapNextView), for: .touchUpInside)
        
      
        let poinForgotButton = CGPoint(x:  secondView.frame.origin.x + secondView.frame.width / 8, y: secondView.frame.origin.y + secondView.frame.height + 15)
        forgotButton = UIButton(type: .system)
        forgotButton.frame =  CGRect(origin: poinForgotButton, size: CGSize(width: secondView.frame.width / 1.4, height: secondView.frame.height / 8))
        
        forgotButton.backgroundColor = .clear
        forgotButton.setTitle("Forgot", for: .normal)
        forgotButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        forgotButton.addTarget(self, action: #selector(forgotName(sender:)), for: .touchUpInside)
        
        
        passwordTextField.delegate = self
        loginTextFild.delegate = self
        
        scroll.contentSize = firstView.bounds.size
       
        scroll.addSubview(firstView)
        scroll.addSubview(secondView)
        scroll.addSubview(forgotButton)
        scroll.addSubview(logButton)
        scroll.addSubview(passwordTextField)
        scroll.addSubview(logoView)
        scroll.addSubview(loginTextFild)

        scroll.delegate = self
        self.view.addSubview(scroll)
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(handleTapOnScrollView))
        scroll.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func handleTapOnScrollView() {
          self.view.endEditing(true)
      }
    
    @objc func tapNextView(sender: UIButton){
        for user in users{
           currentUser = user
            if loginTextFild.text == user.login && passwordTextField.text == user.password {
                
                if currentUser.type == UserTypeShop.director{
                    performSegue(withIdentifier: "Director", sender: nil)
                }else{
                    
                    print(currentUser.login)
                 performSegue(withIdentifier: "productSegue", sender: nil)
                }
                  return
            }
        }
                let alertController = UIAlertController(title: "Ошибка", message: "Не правильно введены данные", preferredStyle: .alert)
                let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            
        
     
       
           
    }
     
    @objc func forgotName(sender: UIButton){
           
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         switch segue.identifier {
               case "productSegue":
                let vc = segue.destination as? ProductTableViewController
                vc?.userAzs = currentUser
                   
         case "nonLoginOrPassword":
            break
         case "Director":
            var arrayUser = [UserShop]()
            for user in users{
                if user.nameShopId == currentUser.nameShopId{
                    arrayUser.append(user)
                }
            }
            
            let vc = segue.destination as? DirectorTableViewController
            vc?.userAzs = currentUser
            vc?.arrayUser = arrayUser
            
         default:
            break
        
        }
    }
    }
    
//MARK: - Scroll

extension AutorizationViewController: UIScrollViewDelegate{
    
}
//MARK: - TextField

extension AutorizationViewController: UITextFieldDelegate{
    
     func textFieldDidBeginEditing(_ textField: UITextField) {
           activeField = textField
       }

       func textFieldDidEndEditing(_ textField: UITextField) {
           activeField = nil
       }

       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
    }
    
}

//MARK: - Keyboard

extension AutorizationViewController {
    private func addKeyboardNotificationObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }

    private func removeKeyboardNotificationObservers() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)

        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
    }

    @objc func keyboardWillBeHidden(notification: NSNotification) {
        scroll.contentInset = .zero
        scroll.scrollIndicatorInsets = .zero
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo as? [String: Any],
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let activeField = activeField
            else { return }

        let keyboardHeight =  keyboardFrame.size.height

        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight, right: 0.0)
        scroll.contentInset = contentInsets
        scroll.scrollIndicatorInsets = contentInsets

        var viewRect: CGRect = self.view.frame
        viewRect.size.height -= keyboardHeight

        if !viewRect.contains(activeField.frame.origin) {
            self.scroll.scrollRectToVisible(activeField.frame, animated: true)
        }
    }
}
