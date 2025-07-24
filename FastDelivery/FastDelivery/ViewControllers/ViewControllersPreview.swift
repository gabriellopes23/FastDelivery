//
//  ViewControllersPreview.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 08/07/25.
//

import UIKit
import SwiftUI

struct ViewControllersPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return TabViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Nothing
    }
}

#Preview(body: {
    ViewControllersPreview()
})

//struct ViewControllersPreview: UIViewRepresentable {
//    
//    func makeUIView(context: Context) -> some UIView {
//        return ProfilePreview()
//    }
//    
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//        // Nothing
//    }
//}
//
//#Preview(body: {
//    ViewControllersPreview()
//})
