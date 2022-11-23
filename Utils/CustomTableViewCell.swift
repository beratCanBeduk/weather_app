//
//  CustomTableViewCell.swift
//  openweatherapp
//
//  Created by berat can beduk on 22.11.2022.
//

import UIKit

class CustomTableViewCell:UITableViewCell {
    @IBOutlet weak var dayName : UILabel!
    
    @IBOutlet weak var dayWeatherIcon : UIImageView!
    @IBOutlet weak var dayMax : UILabel!
    @IBOutlet weak var dayMin : UILabel!
}
