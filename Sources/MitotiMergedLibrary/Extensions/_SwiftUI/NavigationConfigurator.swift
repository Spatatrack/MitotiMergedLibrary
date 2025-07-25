//
//  NavigationConfigurator.swift
//  WARS
//
//  Created by Simone Pistecchia on 03/05/2020.
//  Copyright © 2020 Simone Pistecchia. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}
