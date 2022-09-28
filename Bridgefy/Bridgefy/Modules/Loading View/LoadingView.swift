//
//  LoadingView.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 27/09/22.
//

import UIKit

extension UIViewController {
    func showLoading(text: String = "Cargando...") {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.tag = 1894
        
        let loading = UILabel()
        loading.textAlignment = .center
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.text = text
        loading.font = UIFont.boldSystemFont(ofSize: 35)
        
        view.addSubview(loading)
        self.view.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.topAnchor.constraint(equalTo: self.view.topAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loading.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loading.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        self.view.addSubview(view)
    }
    
    func hideLoading(){
        if let view = self.view.subviews.first(where: { $0.tag == 1894 }) {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                view.removeFromSuperview()
            }
        }
    }
}
