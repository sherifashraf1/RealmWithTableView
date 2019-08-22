//
//  AlertRefactor.swift
//  RefactorWithAlertsAndGenericsWithPresent
//
//  Created by Sherif on 8/5/19.
//  Copyright © 2019 Sherif. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    private static func showAlert(on vc : UIViewController , with title : String , message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let canelAction = UIAlertAction(title: "Canel", style: .default, handler: nil)
        alert.addAction(canelAction)
        
        alert.addTextField {
            $0.placeholder = "name"
            $0.textAlignment = .center
        }
        
        alert.addTextField {
            $0.placeholder = "age"
            $0.textAlignment = .center
            $0.keyboardType = .numberPad
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default, handler: { (action : UIAlertAction) in
            guard let name = alert.textFields?[0].text?.trimmingCharacters(in: .whitespaces),!name.isEmpty, let age = alert.textFields?[1].text?.trimmingCharacters(in: .whitespaces) , !age.isEmpty else {return}
            let user = User()
            user.name = name
            user.age = Int(age) ?? 0
            CrudOperation.creatNewUser(user: user)
            
        })
        alert.addAction(addAction)
        
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    static func addUserAlert(on vc : UIViewController){
        showAlert(on: vc, with: "Add User", message: "Enter name and age")
    }

}
