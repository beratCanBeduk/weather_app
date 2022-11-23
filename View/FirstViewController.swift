//
//  FirstViewController.swift
//  openweatherapp
//
//  Created by berat can beduk on 23.11.2022.
//

import UIKit

class FirstViewController: UIViewController  {
  
    var weatherManager = WeatherManager.sharedInstance
   
   // Components are defined on initial scene
    @IBOutlet weak var textLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
  
    @IBAction func myButton(_ sender: Any) {
    }
    
}


