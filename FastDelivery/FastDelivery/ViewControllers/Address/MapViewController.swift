//
//  MapViewController.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 12/08/25.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController, AddressDetailsModalDelegate {
    
//    func didConfirmAddress(_ address: AddressModel) {
//        print("Endereço confirmado: \(address)")
//        
//        // Salva para que da próxima vez da direto para a Home
//        UserDefaults.standard.set(true, forKey: "hasAddress")
//        
//        // Cria a tela principal
//        let home = TabViewController()
//        let nav = UINavigationController(rootViewController: home)
//        
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//           let sceneDelegate = windowScene.delegate as? SceneDelegate,
//           let window = sceneDelegate.window {
//            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromRight, animations: {
//                window.rootViewController = nav
//            }, completion: nil)
//        }
//        
//        if let encoded = try? JSONEncoder().encode(address) {
//            UserDefaults.standard.set(encoded, forKey: "userAddress")
//        }
//    }

    func didConfirmAddress(_ address: String) {
        print("Endereço confirmado: \(address)")
        
        // Salva para que da próxima vez da direto para a Home
        UserDefaults.standard.set(true, forKey: "hasAddress")
        
        // Cria a tela principal
        let home = TabViewController()
        let nav = UINavigationController(rootViewController: home)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromRight, animations: {
                window.rootViewController = nav
            }, completion: nil)
        }
        
        if let encoded = try? JSONEncoder().encode(address) {
            UserDefaults.standard.set(encoded, forKey: "userAddress")
        }
    }
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let imageTextField = UIImageView()
    private let addressField = UITextField()
    private let stackTextField = UIStackView()
    private var mapContainer = UIView()
    private var mapView: GMSMapView!
    private let geocoder = GMSGeocoder()
    private let confirmButon = UIButton(type: .system)
    private let locationManager = CLLocationManager()
    private var suggestedAddress: AddressModel?
    private var formattedFullAddress: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMaps()
        setupUI()
        setupLayout()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

// MARK: - UI / Layout
extension MapViewController {
    private func setupUI() {
        // Title
        titleLabel.text = "Aonde iremos te entregar?"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .systemBlue
        
        // Subtitle
        subtitleLabel.text = "Caso vocênão esteja vendo a localizaÇão correta, digite abaixo o endereço (Informe sua rua, número, Bairro) ou CEP."
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        
        // Image TextField
        imageTextField.image = UIImage(systemName: "magnifyingglass")
        imageTextField.tintColor = .secondaryLabel
        imageTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageTextField.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        // Addres TextField
        addressField.placeholder = "Ex.: Informe Rua, número, Bairro ou CEP"
        addressField.delegate = self
        
        // Stack TextField
        stackTextField.axis = .horizontal
        stackTextField.spacing = 8
        stackTextField.layer.cornerRadius = 5
        stackTextField.layer.borderColor = UIColor.systemBlue.cgColor
        stackTextField.layer.borderWidth = 1.5
        stackTextField.isLayoutMarginsRelativeArrangement = true
        stackTextField.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackTextField.addArrangedSubview(imageTextField)
        stackTextField.addArrangedSubview(addressField)
        
        // Confirm Button
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "checkmark")
        config.imagePadding = 8
        config.title = "CONFIRMAR LOCALIZAÇÃO"
        confirmButon.configuration = config
        confirmButon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        confirmButon.addTarget(self, action: #selector(confirmLocation), for: .touchUpInside)
    }
    private func setupLayout() {
        [titleLabel, subtitleLabel, stackTextField, mapContainer, confirmButon].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            stackTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            stackTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            stackTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            mapContainer.topAnchor.constraint(equalTo: stackTextField.bottomAnchor, constant: 16),
            mapContainer.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            mapContainer.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            mapContainer.bottomAnchor.constraint(equalTo: confirmButon.topAnchor, constant: -16),
            
            confirmButon.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            confirmButon.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor),
            confirmButon.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
        ])
        
    }
    private func setupMaps() {
        let camera = GMSCameraPosition.camera(withLatitude: -2.991564, longitude: -47.353544, zoom: 16.0)
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.cornerRadius = 8
        mapView.clipsToBounds = true
        
        // Map Conteiner
        mapContainer.layer.shadowColor = UIColor.black.cgColor
        mapContainer.layer.shadowOpacity = 0.5
        mapContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        mapContainer.layer.shadowRadius = 4
        mapContainer.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: mapContainer.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: mapContainer.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: mapContainer.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: mapContainer.bottomAnchor)
        ])
    }
}

// MARK: - Função para obter endereço pelo GMSGeocoder
extension MapViewController {
    private func getAddressFromCoordinates(_ coodinate: CLLocationCoordinate2D, completion: @escaping (String, AddressModel) -> Void) {
        geocoder.reverseGeocodeCoordinate(coodinate) { response, error in
            if let address = response?.firstResult(), let lines = address.lines {
                
                let street = address.thoroughfare ?? ""
                let neighborhood = address.subLocality ?? ""
                let city = address.locality ?? ""
                let state = address.administrativeArea ?? ""
                let postalCode = address.postalCode ?? ""
                let country = address.country ?? ""
                
                let model = AddressModel(
                    street: street,
                    number: "",
                    neighborhood: neighborhood,
                    city: city,
                    state: state,
                    cep: postalCode,
                    country: country,
                    type: ""
                )
                
                completion(lines.joined(separator: ", "), model)
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension MapViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchAddress()
        return true
    }
    
    func searchAddress() {
        guard let address = addressField.text, !address.isEmpty else { return }
        
        let placesClient = GMSPlacesClient.shared()
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        
        placesClient.findAutocompletePredictions(fromQuery: address, filter: filter, sessionToken: nil) { [weak self] results, error in
            if let placeID = results?.first?.placeID {
                placesClient.fetchPlace(fromPlaceID: placeID, placeFields: .coordinate, sessionToken: nil) { place, error in
                    if let coordinate = place?.coordinate {
                        self?.mapView.animate(toLocation: coordinate)
                        self?.mapView.clear()
                        
                        self?.getAddressFromCoordinates(coordinate) { fullAddress, model in
                            let marker = GMSMarker(position: coordinate)
                            marker.title = "Endereço de Entrega"
                            marker.snippet = fullAddress
                            marker.map = self?.mapView
                            self?.mapView.selectedMarker = marker
                            self?.suggestedAddress = model
                            self?.formattedFullAddress = fullAddress
                        }
                    }
                }
            }
        }
    }
}

// MARK: - CLLocationManager
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        locationManager.stopUpdatingLocation()
        
        let coordinate = location.coordinate
        mapView.animate(toLocation: coordinate)
        
        self.getAddressFromCoordinates(coordinate) { fullAddres, model in
            let marker = GMSMarker(position: coordinate)
            marker.title = "Endereço de Entrega"
            marker.snippet = fullAddres
            marker.map = self.mapView
            self.mapView.selectedMarker = marker
            self.suggestedAddress = model
            self.formattedFullAddress = fullAddres
        }
    }
}

// MARK: - Actions
extension MapViewController {
    @objc private func confirmLocation() {
        let alertView = AddressConfirmView(frame: view.bounds, prefilledAddress: suggestedAddress, fullAddressText: formattedFullAddress)
        alertView.delegate = self
        view.addSubview(alertView)
        
        alertView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            alertView.alpha = 1
        }
        
        
    }
}
