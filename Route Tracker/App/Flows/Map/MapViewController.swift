//
//  MapViewController.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 30/06/2019.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var buttonAddMarker: UIBarButtonItem!
    
    private let geocoder = CLGeocoder()
    private let defaultMapZoom: Float = 17
    private let defaultLocation = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    
    private var tappedMarker: GMSMarker?
    private var myRoute = [GMSMarker]()
    
    private var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        configureLocationManager()
    }
    
    private func configureMap() {
        let camera = GMSCameraPosition.camera(withTarget: defaultLocation, zoom: defaultMapZoom)
        mapView.camera = camera
        mapView.configureCustomMapStyle()
        mapView.delegate = self
    }
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    @IBAction func buttonCurrentTapped(_ sender: Any) {
        getCurrentLocation()
    }
    
    @IBAction func buttonTrackTapped(_ sender: Any) {
        trackUserLocation()
    }
    
    private func getCurrentLocation() {
        guard let locationManager = locationManager else { return }
        locationManager.requestLocation()
    }
    
    private func trackUserLocation() {
        guard let locationManager = locationManager else { return }
        locationManager.startUpdatingLocation()
    }
    
}

/// Расширяет MapViewController для работы с MapView
extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        setTappedMarker(by: coordinate)
        getInfo(by: coordinate)
    }
    
    private func setTappedMarker(by coordinate: CLLocationCoordinate2D) {
        if let tappedMarker = tappedMarker {
            tappedMarker.position = coordinate
        }
        else {
            let marker = GMSMarker(position: coordinate)
            marker.map = mapView
            marker.icon = GMSMarker.markerImage(with: .red)
            marker.title = "Неизвестная точка"
            marker.snippet = "Что-то означает"
            self.tappedMarker = marker
        }
    }
    
    /// Получает информацию о месте по его локации
    private func getInfo(by location: CLLocationCoordinate2D) {
        let cllocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        geocoder.reverseGeocodeLocation(cllocation) { places, error in
            guard let tappedMarker = self.tappedMarker, let placeName = places?.first?.name, let placeDescription = places?.first?.description else { return }
            tappedMarker.title = placeName
            tappedMarker.snippet = placeDescription
        }
    }
    
}

/// Расширяет MapViewController для отслеживания
/// текущего местоположения
extension MapViewController: CLLocationManagerDelegate {
    
    /// Получает местоположение пользователя и
    /// переводит центр карты в эту точку
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let myLocation = locations.first {
            mapView.animate(toLocation: myLocation.coordinate)
            generateRouteMarker(by: myLocation)
        }
    }
    
    /// Создает точку по координате и добавляет ее в Массив
    private func generateRouteMarker(by location: CLLocation) {
        let marker = GMSMarker(position: location.coordinate)
        marker.icon = GMSMarker.markerImage(with: .orange)
        marker.map = mapView
        marker.title = "Точка \(myRoute.count + 1)"
        marker.snippet = "Ты был тут"
        myRoute.append(marker)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("При получении местоположния возникли ошибки: \(error.localizedDescription)")
    }

}
