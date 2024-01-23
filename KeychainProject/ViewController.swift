//
//  ViewController.swift
//  KeychainProject
//
//  Created by TBAM on 22/01/2024.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var retrieveBtn: UIButton!
    @IBOutlet weak var resultTitle: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var resultContainer: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBtn.setTitle("Update", for: .normal)
        updateBtn.backgroundColor = .purple
        updateBtn.tintColor = .white
        updateBtn.layer.cornerRadius = 10
        
        retrieveBtn.setTitle("Retrieve", for: .normal)
        retrieveBtn.backgroundColor = .purple
        retrieveBtn.tintColor = .white
        retrieveBtn.layer.cornerRadius = 10
        
        
        resultContainer.layer.cornerRadius = 10
        textField.layer.cornerRadius = 10
        textField.isSecureTextEntry = true
        
        
        updateBtn.addTarget(self, action: #selector(updateFunction), for: .touchUpInside)
        
        retrieveBtn.isHidden = true
        
        retrieveBtn.addTarget(self, action: #selector(retrieveFunction), for: .touchUpInside)
        
        
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Add an action (button)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
    
    
    func showErrorAlert(){
        showAlert(title: "Error", message: "Please enter your information")
    }
    
    
    @objc func updateFunction(){
        //save data
        if let userData = textField.text, textField.hasText == true{
            let data = Data(userData.utf8)
            KeychainHelper.standard.save(data, service: "user-data", account: "keychainProject")
            
            retrieveBtn.isHidden = false
        }else{
            showErrorAlert()
        }
        
    }
    
    
    @objc func retrieveFunction(){
        //read data
        let data = KeychainHelper.standard.read(service: "user-data", account: "keychainProject")!
        let userData = String(data: data, encoding: .utf8)!
        print(userData)
        resultLabel.text = userData
        
    }
}

