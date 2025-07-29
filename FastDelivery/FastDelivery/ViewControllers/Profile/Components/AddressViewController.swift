//
//  AddressViewController.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 23/07/25.
//

import UIKit
import MapKit
import CoreLocation

class AddressViewController: UIViewController, AddressDetailsModalDelegate {
    
    func didConfirmAddress(_ address: AddressModel) {
        print("Endereço confirmado: \(address)")

        // Salva para que da próxima vez vá direto para a Home
        UserDefaults.standard.set(true, forKey: "hasAddress")

        // Cria a tela principal
        let home = TabViewController()
        let nav = UINavigationController(rootViewController: home)

        // Acessa a UIWindow da cena atual e altera a root
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            
            // Faz uma transição bonita (fade)
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
    private let addressField = UITextField()
    private let searchButton = UIButton(type: .system)
    private let mapView = MKMapView()
    private let locationButton = UIButton(type: .system)
    private let confirmButton = UIButton(type: .system)

    private let geocoder = CLGeocoder()
    private let locationManager = CLLocationManager()
    
    private var suggestedAddress: AddressModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Endereço"

        setupUI()
        setupLayout()
        setupLocation()
        limitMapToBrazil()
    }

    private func setupUI() {
        // Título
        titleLabel.text = "Onde iremos te entregar?"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0

        // Subtítulo
        subtitleLabel.text = "Caso você não esteja vendo a localização correta, digite abaixo o endereço (Rua, Número, Bairro ou CEP)."
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0

        // Campo de endereço
        addressField.placeholder = "Ex.: Rua, Número, Bairro ou CEP"
        addressField.borderStyle = .roundedRect
        addressField.autocorrectionType = .no
        addressField.returnKeyType = .done
        addressField.clearButtonMode = .whileEditing
        addressField.addTarget(self, action: #selector(searchAddress), for: .editingDidEndOnExit)

        // Botão de lupa (buscar)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchAddress), for: .touchUpInside)

        // Mapa
        mapView.layer.cornerRadius = 12
        mapView.clipsToBounds = true

        // Botão localização
        locationButton.setTitle("📍 Usar minha localização", for: .normal)
        locationButton.setTitleColor(.systemBlue, for: .normal)
        locationButton.addTarget(self, action: #selector(requestCurrentLocation), for: .touchUpInside)

        // Confirmar
        confirmButton.setTitle("✔ CONFIRMAR LOCALIZAÇÃO", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.backgroundColor = .systemBlue
        confirmButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        confirmButton.layer.cornerRadius = 10
        confirmButton.addTarget(self, action: #selector(confirmLocationTapped), for: .touchUpInside)
    }

    private func setupLayout() {
        [titleLabel, subtitleLabel, addressField, searchButton, mapView, locationButton, confirmButton].forEach {
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

            addressField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            addressField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addressField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -8),
            addressField.heightAnchor.constraint(equalToConstant: 40),

            searchButton.centerYAnchor.constraint(equalTo: addressField.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchButton.widthAnchor.constraint(equalToConstant: 30),
            searchButton.heightAnchor.constraint(equalToConstant: 30),

            locationButton.topAnchor.constraint(equalTo: addressField.bottomAnchor, constant: 8),
            locationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            mapView.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 12),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mapView.heightAnchor.constraint(equalToConstant: 300),

            confirmButton.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func limitMapToBrazil() {
        let brazilCenter = CLLocationCoordinate2D(latitude: -14.2350, longitude: -51.9253) // Centro aproximado do Brasil
        let region = MKCoordinateRegion(center: brazilCenter, latitudinalMeters: 4000000, longitudinalMeters: 4000000) // 4000km

        let cameraBoundary = MKMapView.CameraBoundary(coordinateRegion: region)
        mapView.setCameraBoundary(cameraBoundary, animated: false)
        
        // Limita também o nível de zoom
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 5000000) // até 5.000km de distância do centro
        mapView.setCameraZoomRange(zoomRange, animated: false)
    }

    @objc private func requestCurrentLocation() {
        locationManager.requestLocation()
    }

    @objc private func searchAddress() {
        guard var text = addressField.text, !text.isEmpty else { return }

        // Se o texto já não tem "Brasil", adiciona
        if !text.lowercased().contains("brasil") {
            text += ", Brasil"
        }

        geocoder.geocodeAddressString(text) { [weak self] placemarks, error in
            guard let self = self, let placemark = placemarks?.first, let coordinate = placemark.location?.coordinate else {
                print("Endereço não encontrado ou inválido")
                return
            }
            self.suggestedAddress = AddressModel(
                street: placemark.thoroughfare ?? "",
                number: placemark.subThoroughfare ?? "",
                neighborhood: placemark.subLocality ?? "",
                city: placemark.locality ?? "",
                cep: placemark.postalCode ?? "",
                type: "manual"
            )
            
            self.updateMap(coordinate: coordinate, title: "Endereço de entrega")
        }
    }
    
    @objc private func confirmLocationTapped() {
        let modal = AddressDetailsModalViewController()
        modal.delegate = self
        modal.prefilledAddress = suggestedAddress
        modal.modalPresentationStyle = .pageSheet
        if let sheet = modal.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(modal, animated: true)
    }

    



    private func updateMap(coordinate: CLLocationCoordinate2D, title: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title

        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)

        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(region, animated: true)
    }
}

extension AddressViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.first?.coordinate {
            updateMap(coordinate: coordinate, title: "Minha localização")
            reverseGeocode(coordinate: coordinate)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erro ao obter localização: \(error)")
    }

    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first else { return }

            var addressParts = [String]()
            if let name = placemark.name { addressParts.append(name) }
            if let locality = placemark.locality { addressParts.append(locality) }
            if let state = placemark.administrativeArea { addressParts.append(state) }
            if let country = placemark.country { addressParts.append(country) }

            self?.addressField.text = addressParts.joined(separator: ", ")
            
            self?.suggestedAddress = AddressModel(
                street: placemark.thoroughfare ?? "",
                number: placemark.subThoroughfare ?? "",
                neighborhood: placemark.subLocality ?? "",
                city: placemark.locality ?? "",
                cep: placemark.postalCode ?? "",
                type: "gps")
        }
    }
}
