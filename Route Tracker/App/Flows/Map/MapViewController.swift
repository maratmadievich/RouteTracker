//
//  MapViewController.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 30/06/2019.
//

import UIKit
import RxCocoa
import RxSwift
import PinLayout
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var buttonStartTrack: UIButton!
    @IBOutlet weak var buttonEndTrack: UIButton!
    @IBOutlet weak var buttonLastRoute: UIButton!
    
    private var mapZoom: Float = 17
    private let defaultLocation = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    
    private let geocoder = CLGeocoder()
    private var tappedMarker: GMSMarker?
	private let locationManager = LocationManager.instance
	private let disposeBag = DisposeBag()

    
    /// Для хранения объекта маршрута и объекта, представляющего его путь
    private var route: GMSPolyline?
    private var routePath: GMSMutablePath?
    
    private var isTrackingWork = false
    
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
        let camera = GMSCameraPosition.camera(withTarget: defaultLocation, zoom: mapZoom)
        mapView.camera = camera
        mapView.configureCustomMapStyle()
        mapView.delegate = self
    }
    
    private func configureButtons() {
        buttonEndTrack.layer.cornerRadius = 4
        buttonEndTrack.layer.masksToBounds = true
        
        buttonStartTrack.layer.cornerRadius = 4
        buttonStartTrack.layer.masksToBounds = true
        
        buttonLastRoute.layer.cornerRadius = 4
        buttonLastRoute.layer.masksToBounds = true
    }
	
	private func configureLocationManager() {
		locationManager
			.location
			.asObservable()
			.bind { [weak self] location in
				guard let location = location else { return }
				self?.addPointToRoute(by: location)
				self?.mapView.animate(toLocation: location.coordinate)
		}.disposed(by: disposeBag)
	}
	
	/// Добавляет точку в маршрут движения пользователя
	private func addPointToRoute(by location: CLLocation) {
		guard let route = route,
			let routePath = routePath else {return }
		routePath.add(location.coordinate)
		route.path = routePath
		let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: mapZoom)
		mapView.animate(to: position)
	}
    
}

/// Содержит действия при нажатии на кнопки
extension MapViewController {
    
    @IBAction func buttonCurrentTapped(_ sender: Any) {
        getCurrentLocation()
    }
    
    @IBAction func buttonStartTrackTapped(_ sender: Any) {
        traking(isStart: true)
    }
    
    @IBAction func buttonEndTrackTapped(_ sender: Any) {
        traking(isStart: false)
    }
    
    @IBAction func buttonLastRouteTapped(_ sender: Any) {
        checkNeedStopTrack()
    }
    
    
    private func traking(isStart: Bool) {
        isTrackingWork = isStart
        trackUserLocation(needTrackStart: isStart)
        isStart
            ? configureRoute()
            : LocalRouteFactory().savePath(from: routePath)
    }
    
    
    private func getCurrentLocation() {
        locationManager.requestLocation()
    }
    
    private func configureRoute(with path: GMSMutablePath? = nil) {
        route?.map = nil
        route = GMSPolyline()
        routePath = path == nil
            ? GMSMutablePath()
            : path
        route?.map = mapView
        route?.path = routePath
        route?.strokeColor = .white
        route?.strokeWidth = 3
    }
    
    private func trackUserLocation(needTrackStart: Bool) {
        needTrackStart
            ? locationManager.startUpdatingLocation()
            : locationManager.stopUpdatingLocation()
    }
    
    private func checkNeedStopTrack() {
        isTrackingWork
            ? showNeedStopTrackAlert()
            : getLastRoute()
    }
    
    private func getLastRoute() {
        configureRoute(with: LocalRouteFactory().getPath())
        guard let path = routePath else { return }
        let update = GMSCameraUpdate.fit(GMSCoordinateBounds(path: path))
        mapView.animate(with: update)
    }
    
}

/// Содержит алерты
extension MapViewController {
    
    private func showNeedStopTrackAlert() {
        let alert = UIAlertController(title: "Остановка трекера", message: "В настоящее время Ваш трекер включен. Хотите отключить его перед отображением предущего маршрута?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отключить", style: .default, handler: { [weak self] action in
            self?.isTrackingWork = false
            self?.trackUserLocation(needTrackStart: false)
            self?.getLastRoute()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

/// Расширяет MapViewController для работы с MapView
extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        mapZoom = position.zoom
    }
    
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

extension MapViewController {
    
    private func configureLayout() {
        mapView.pin.all()
        
        buttonLastRoute.pin
            .left(5%).right(5%)
            .top(20).height(46)
        buttonStartTrack.pin
            .left(5%).bottom(20)
            .height(46).width(44%)
        buttonEndTrack.pin
            .right(5%).bottom(20)
            .height(46).width(44%)
        view.layoutIfNeeded()
    }
}
