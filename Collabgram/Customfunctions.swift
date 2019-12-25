//
//  Customfunctions.swift
//  Collabgram
//
//  Created by Dinaol Melak on 12/25/19.
//  Copyright © 2019 Dinaol Melak. All rights reserved.
//


import Foundation
import UIKit

class Customfunctions: UIViewController{
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action =  UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert , animated: true, completion: nil)
    }
    
    
    
    
}

