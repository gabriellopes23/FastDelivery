//
//  AppDelegate.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 08/07/25.
//

import UIKit
import GoogleMaps
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let apiKey = "AIzaSyCYpKvAgG3B866WHfLPMDIBESY8UX592eM"
        
        GMSServices.provideAPIKey(apiKey)
        GMSPlacesClient.provideAPIKey(apiKey)
        
        return true
    }

}

