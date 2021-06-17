//
//  ViewController.swift
//  04-CLLocationButton
//
//  Created by 杨帆 on 2021/6/10.
//

import CoreLocation
import CoreLocationUI
import UIKit

class ViewController: UIViewController {
    lazy var locationManager = CLLocationManager()

    lazy var locationButton: CLLocationButton = {
        let locationButton = CLLocationButton(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        locationButton.center = view.center
        locationButton.icon = .arrowFilled
        locationButton.label = .currentLocation
        locationButton.cornerRadius = 20.0
        locationButton.addTarget(self, action: #selector(userPressedLocationButton), for: .touchUpInside)

        return locationButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        view.addSubview(locationButton)
    }

    @objc func userPressedLocationButton() {
        locationManager.requestLocation()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        print("\(location.coordinate.latitude) -- \(print(location.coordinate.latitude))")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
