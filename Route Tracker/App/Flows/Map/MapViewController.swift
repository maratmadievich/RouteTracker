//
//  MapViewController.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 30/06/2019.
//

import UIKit
import PinLayout
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var buttonAddMarker: UIBarButtonItem!
    
    @IBOutlet weak var buttonStartTrack: UIButton!
    @IBOutlet weak var buttonEndTrack: UIButton!
    
    
    private let geocoder = CLGeocoder()
    private let defaultMapZoom: Float = 17
    private let defaultLocation = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    
    private var tappedMarker: GMSMarker?
    
    private var locationManager: CLLocationManager?
    
    /// Для хранения объекта маршрута и объекта, представляющего его путь
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        configureButtons()
        configureLocationManager()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayout()
    }
    
    private func configureMap() {
        let camera = GMSCameraPosition.camera(withTarget: defaultLocation, zoom: defaultMapZoom)
        mapView.camera = camera
        mapView.configureCustomMapStyle()
        mapView.delegate = self
    }
    
    private func configureButtons() {
        buttonStartTrack.layer.cornerRadius = 4
        buttonStartTrack.layer.masksToBounds = true
        
        buttonEndTrack.layer.cornerRadius = 4
        buttonEndTrack.layer.masksToBounds = true
    }
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestAlwaysAuthorization()
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.delegate = self

    }
    
    
}

/// Содержит действия при нажатии на кнопки
extension MapViewController {
    
    @IBAction func buttonCurrentTapped(_ sender: Any) {
        getCurrentLocation()
    }
    
    @IBAction func buttonStartTrackTapped(_ sender: Any) {
        configureRoute()
        trackUserLocation(needTrackStart: true)
    }
    
    @IBAction func buttonEndTrackTapped(_ sender: Any) {
        trackUserLocation(needTrackStart: false)
    }
    
    
    private func getCurrentLocation() {
        guard let locationManager = locationManager else { return }
        locationManager.requestLocation()
    }
    
    private func configureRoute() {
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.map = mapView
        route?.strokeColor = .white
        route?.strokeWidth = 3
    }
    
    private func trackUserLocation(needTrackStart: Bool) {
        guard let locationManager = locationManager else { return }
        needTrackStart
            ? locationManager.startUpdatingLocation()
            : locationManager.stopUpdatingLocation()
    }
    
}

/// Расширяет MapViewController для работы с MapView
extension MapViewController: GMSMapViewDelegate {
    
    private func trackButtons(needHide: Bool) {
        buttonStartTrack.isHidden = needHide
        buttonEndTrack.isHidden = needHide
    }
    
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
            generateRouteMarker(by: myLocation)
            mapView.animate(toLocation: myLocation.coordinate)
        }
    }
    
    /// Добавляет точку в маршрут движения пользователя
    private func generateRouteMarker(by location: CLLocation) {
        guard let route = route,
            let routePath = routePath else {return }
        routePath.add(location.coordinate)
        route.path = routePath
        let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 17)
        mapView.animate(to: position)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("При получении местоположния возникли ошибки: \(error.localizedDescription)")
    }

}

extension MapViewController {
    
    private func configureLayout() {
        mapView.pin.all()
        buttonStartTrack.pin
            .left(5%).bottom(20)
            .height(46).width(44%)
        buttonEndTrack.pin
            .right(5%).bottom(20)
            .height(46).width(44%)
        view.layoutIfNeeded()
    }
}
