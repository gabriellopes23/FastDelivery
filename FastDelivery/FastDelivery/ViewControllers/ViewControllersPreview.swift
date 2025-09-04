//
//  ViewControllersPreview.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 08/07/25.
//

import UIKit
import SwiftUI

//struct ViewControllersPreview: UIViewControllerRepresentable {
//    
//    func makeUIViewController(context: Context) -> some UIViewController {
//        return Profile()
//    }
//    
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        // Nothing
//    }
//}
//
//#Preview(body: {
//    ViewControllersPreview()
//})

struct ViewControllersPreview: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        return AddressView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Nothing
    }
}

#Preview(body: {
    ViewControllersPreview()
})
