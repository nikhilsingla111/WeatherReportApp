//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Nikhil Aggarwal on 14/01/20.
//  Copyright © 2020 Nikhil Aggarwal. All rights reserved.
//

import Foundation

class WeatherCityViewModel {
    var model: CityDataModel?
    var index: Int?
    
    init(model: CityDataModel, index: Int) {
        self.model = model
        self.index = index
    }
    
    deinit {
        model = nil
        index = nil
    }
    
    func getCityName() -> String? {
        return model?.city?.name
    }
    
    func getCityWeather() -> String? {
        return model?.list?[index ?? 0].weather?.first?.description?.capitalized
    }
    
    func getDate() -> String? {
        return Conversion.dateFormater(timeInterval: TimeInterval(exactly: model?.list?[index ?? 0].dt ?? 0.0))
    }
    
    func getMinTemp() -> String? {
        return Conversion.convertToCelsius(fahrenheit:model?.list?[index ?? 0].temp?.min ?? 0.0)
    }
    
    func getMaxTemp() -> String? {
        return Conversion.convertToCelsius(fahrenheit:model?.list?[index ?? 0].temp?.max ?? 0.0)
    }
}
