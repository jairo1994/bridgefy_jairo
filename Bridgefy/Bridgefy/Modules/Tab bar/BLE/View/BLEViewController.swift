//
//  BLEViewController.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 26/09/22.
//

import UIKit

class BLEViewController: UIViewController {
    private var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    private let btnGroup = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc func scanBLE(){
        
    }
    
    func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        btnGroup.removeFromSuperview()
        
        btnGroup.translatesAutoresizingMaskIntoConstraints = false
        btnGroup.tintColor = Colors.Enfasis.color
        btnGroup.setTitle("Scan", for: .normal)
        btnGroup.addTarget(self, action: #selector(scanBLE), for: .touchUpInside)
        
        
        view.addSubview(btnGroup)
        
        
        NSLayoutConstraint.activate([
            btnGroup.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            btnGroup.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension BLEViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
