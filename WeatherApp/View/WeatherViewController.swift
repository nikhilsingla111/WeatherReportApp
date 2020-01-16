//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Nikhil Aggarwal on 14/01/20.
//  Copyright © 2020 Nikhil Aggarwal. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var activityController: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    private var weatherDetailsArray: [WeatherCityViewModel] = []
    lazy var dataSource: CityWeatherViewDataSource = CityWeatherViewDataSource()
    private var searchText = ""
    private var cities: [String] = []
    private var locationManager:CLLocationManager!
    lazy var router: WeatherRouter = WeatherRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
        searchBar.delegate = self
        activityController.isHidden = true
        router.context = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserCurrentLocation()
    }
    
    private func fetchUserCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.startUpdatingLocation()
        }
    }

    private func setupTableview() {
        registerNib()
        dataSource.context = self
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }
    
    private func registerNib() {
        let nib = UINib.init(nibName: "CityWeatherTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.cellId)
    }
    
    private func getMultipleCitiesWeatherModel(cities: [String]) {
        activityController.isHidden = false
        activityController.startAnimating()
        cities.forEach { (city) in
            self.getCityWeather(city: city)
        }
    }
    
    func getCityWeather(city: String) {
        NetworkManager().fetchCityData(cityName: city) { (response) in
                switch response {
                case .success(let cityData):
                    self.createViewModel(dataModel: cityData)
                case .failure(let error):
                    print("Failed to fetch data", error)
            }
        }
    }
    
    func removeData() {
        weatherDetailsArray.removeAll()
    }
    
    private func createViewModel(dataModel: CityDataModel) {
        if let list = dataModel.list {
            for i in 0 ..< list.count {
                weatherDetailsArray.append(WeatherCityViewModel(model: dataModel, index: i))
            }
        }
        DispatchQueue.main.async {
            self.activityController.isHidden = true
            self.activityController.stopAnimating()
            self.dataSource.weatherDetailsArray = self.weatherDetailsArray
            self.tableView.reloadData()
        }
    }
    
    @IBAction private func showAvailableCities(_ sender: Any) {
        router.showActionSheet()
    }
}

// Search bar delegate methods
extension WeatherViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        weatherDetailsArray.removeAll()
        let cities = self.searchText.components(separatedBy: ",")
        self.getMultipleCitiesWeatherModel(cities: cities)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// Location Delegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        fetchCityName(from: userLocation) { city, country, error in
            guard let city = city, error == nil else { return }
            self.weatherDetailsArray.removeAll()
            self.getCityWeather(city: city)
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    func fetchCityName(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
}


