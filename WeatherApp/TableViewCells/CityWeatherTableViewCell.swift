//
//  CityWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Nikhil Aggarwal on 14/01/20.
//  Copyright © 2020 Nikhil Aggarwal. All rights reserved.
//

import UIKit

class CityWeatherTableViewCell: UITableViewCell {
    @IBOutlet private weak var lblCityName: UILabel!
    @IBOutlet private weak var lblWeatherDetails: UILabel!
    @IBOutlet private weak var lblMinTemp: UILabel!
    @IBOutlet private weak var lblMaxTemp: UILabel!
    @IBOutlet private weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView(viewModel: WeatherCityViewModel) {
        lblCityName.text =  viewModel.getCityName()
        lblWeatherDetails.text =  viewModel.getCityWeather()
        lblDate.text = viewModel.getDate()
        lblMinTemp.text = viewModel.getMinTemp()
        lblMaxTemp.text = viewModel.getMaxTemp()
    }
}
