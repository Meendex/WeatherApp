//
//  ViewController.swift
//  WeatherApp
//
//  Created by Mindaugas Balakauskas on 02/10/2022.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

  
    let weatherViewModel = WeatherViewModel(weatherService: WeatherService())
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let controller = UIHostingController(rootView: DetailScreenSwiftUIView(viewModel: weatherViewModel))
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(controller)
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            controller.view.widthAnchor.constraint(equalToConstant: 200),
            controller.view.heightAnchor.constraint(equalToConstant: 100),
            controller.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)])
    }


}

