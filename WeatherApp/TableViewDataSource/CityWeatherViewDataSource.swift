//
//  CityWeatherViewDataSource.swift
//  WeatherApp
//
//  Created by Nikhil Aggarwal on 14/01/20.
//  Copyright © 2020 Nikhil Aggarwal. All rights reserved.
//

import UIKit

class CityWeatherViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    weak var context: WeatherViewController?
    var weatherDetailsArray: [WeatherCityViewModel] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDetailsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId) as? CityWeatherTableViewCell else {return UITableViewCell()}
        cell.setupView(viewModel: weatherDetailsArray[indexPath.row])
        return cell
    }
}
