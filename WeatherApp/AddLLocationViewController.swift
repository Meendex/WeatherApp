//
//  AddLLocationViewController.swift
//  WeatherApp
//
//  Created by Mindaugas Balakauskas on 06/10/2022.
//

import UIKit
import Combine

protocol AddLocation {
    func clearData()
}

class AddLLocationViewController: UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func addLocationButton(_ sender: Any) {
        
    }
    
}
extension AddLLocationViewController: AddLocation {
    func clearData(){
        locationTextField.text = ""
    }
}
