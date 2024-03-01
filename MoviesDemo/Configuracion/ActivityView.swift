//
//  ActivityView.swift
//  MoviesDemo
//
//  Created by Marco Alonso Rodriguez on 31/01/24.
//

import Foundation
import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No es necesario implementar nada aquí
    }
}
