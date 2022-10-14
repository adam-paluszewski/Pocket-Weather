//
//  UIViewControllerExt.swift
//  Pocket Weather
//
//  Created by Adam Paluszewski on 10/10/2022.
//

import UIKit


fileprivate var loadingViews: [UIView : UIView] = [:]

extension UIViewController {
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            childVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            childVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            childVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            childVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])

        childVC.didMove(toParent: self)
    }
    
    
    func showLoadingView(in view: UIView) {
        let containerView = UIView()
        view.addSubview(containerView)
        loadingViews[view] = containerView
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        containerView.alpha = 0
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        

        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView(in view: UIView) {
        guard !loadingViews.isEmpty else { return }
        DispatchQueue.main.async {
            let containerView = loadingViews[view]
            containerView?.removeFromSuperview()
            loadingViews.removeValue(forKey: view)
        }
    }
    
    
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String, buttonColor: UIColor, buttonSystemImage: UIImage) {
        DispatchQueue.main.async {
            let alertVC = PWAlertVC(title: title, message: message, buttonTitle: buttonTitle, buttonColor: buttonColor, buttonSystemImage: buttonSystemImage)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
