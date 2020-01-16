//
//  WeatherRouter.swift
//  WeatherApp
//
//  Created by Nikhil Aggarwal on 15/01/20.
//  Copyright © 2020 Nikhil Aggarwal. All rights reserved.
//

import Foundation
import UIKit

class WeatherRouter: WeatherRoutables {
    weak var context: WeatherViewController?
    
    func showActionSheet() {
        let actionSheetController: UIAlertController = UIAlertController(title: "Please select Preferred City", message: "", preferredStyle: .actionSheet)

        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)

        let city1Button = UIAlertAction(title: "Pune", style: .default) { [weak self] action in
            self?.context?.removeData()
            self?.context?.getCityWeather(city: "Pune")
        }
        actionSheetController.addAction(city1Button)
        let city2Button = UIAlertAction(title: "Mumbai", style: .default) { [weak self] action in
            self?.context?.removeData()
            self?.context?.getCityWeather(city: "Mumbai")
        }
        actionSheetController.addAction(city2Button)
        let city3Button = UIAlertAction(title: "Kolkata", style: .default) { [weak self] action in
            self?.context?.removeData()
            self?.context?.getCityWeather(city: "Kolkata")
        }
        actionSheetController.addAction(city3Button)
        let city4Button = UIAlertAction(title: "Delhi", style: .default) { [weak self] action in
            self?.context?.removeData()
            self?.context?.getCityWeather(city: "Delhi")
        }
        actionSheetController.addAction(city4Button)

        context?.present(actionSheetController, animated: true, completion: nil)
    }
}
