//
//  UIViewController+Alert.swift
//  Technical-test
//
//  Created by Користувач on 15.06.2023.
//

import UIKit

extension UIViewController {
    func display(error: Error, okAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in okAction?() }
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}
