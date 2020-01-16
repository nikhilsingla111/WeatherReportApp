//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Nikhil Aggarwal on 14/01/20.
//  Copyright © 2020 Nikhil Aggarwal. All rights reserved.
//

import Foundation

public typealias SuccessBlock = (_ response: Any?, _ error: Error?) -> Void

class NetworkManager: NSObject {
    func fetchCityData(cityName: String, copmletion: @escaping(Result<CityDataModel, Error>) -> ()) {
        let city = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlString = String(format: "%@%@%@",
                               Constants.prefixURLString, city ?? "", Constants.suffixURLString)
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _error = error {
                copmletion(.failure(_error))
            }
            guard let data = data else { return }
            do {
                let cityDataModel = try JSONDecoder().decode(CityDataModel.self, from: data)
                copmletion(.success(cityDataModel))
            } catch let jsonError {
                copmletion(.failure(jsonError))
            }
        }.resume()
    }
}
