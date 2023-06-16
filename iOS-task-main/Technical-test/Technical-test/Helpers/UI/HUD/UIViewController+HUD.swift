//
//  UIViewController+HUD.swift
//  Technical-test
//
//  Created by Користувач on 16.06.2023.
//

import UIKit

class LoadingViewController: UIViewController {
    var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
            
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        loadingActivityIndicator.center = CGPoint(
            x: view.bounds.midX,
            y: view.bounds.midY
        )
        view.addSubview(loadingActivityIndicator)
    }
}


class HUDViewController: UIViewController {
    var loadingVC: LoadingViewController?
    
    func showLoading() {
        guard loadingVC == nil else { return }
        
        let loadingVC = LoadingViewController()
        self.loadingVC = loadingVC
        loadingVC.modalPresentationStyle = .overCurrentContext
        loadingVC.modalTransitionStyle = .crossDissolve
               
        present(loadingVC, animated: true, completion: nil)
    }
    
    func hideLoading() {
        loadingVC?.dismiss(animated: true)
        loadingVC = nil
    }
}
