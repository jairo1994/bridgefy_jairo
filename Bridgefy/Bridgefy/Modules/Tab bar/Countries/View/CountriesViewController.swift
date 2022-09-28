//
//  CountriesViewController.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 26/09/22.
//

import UIKit

class CountriesViewController: UIViewController {
    private var viewModel = CountriesViewModel()
    private let cellIdent = "countryCell"
    private var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchCountries()
    }
    
    func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: cellIdent)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func fetchCountries(){
        self.showLoading()
        viewModel.lookForCountries()
        viewModel.didFetchLocation = { [weak self] _ in
            guard let self = self else {
                return
            }
            self.tableView.reloadData()
            self.hideLoading()
        }
    }

    func searchView() -> UIView{
        let btnGroup = UIButton(type: .system)
        btnGroup.translatesAutoresizingMaskIntoConstraints = false
        btnGroup.tintColor = Colors.Enfasis.color
        btnGroup.setTitle("Group", for: .normal)
        btnGroup.contentHorizontalAlignment = .right
        btnGroup.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        label.text = "Countries"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let serch = UISearchBar()
        serch.backgroundImage = UIImage()
        serch.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIView()
        stack.backgroundColor = .white
//        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addSubview(btnGroup)
        stack.addSubview(label)
        stack.addSubview(serch)
        
        NSLayoutConstraint.activate([
            btnGroup.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 8),
            btnGroup.topAnchor.constraint(equalTo: stack.topAnchor),
            
            label.topAnchor.constraint(equalTo: btnGroup.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -8),
            
            serch.topAnchor.constraint(equalTo: label.bottomAnchor),
            serch.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            serch.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
        ])
        
        return stack
    }
    
    @objc func group(){
        
    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdent) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        
        if let country = viewModel.getCountryByIndex(index: indexPath.item) {
            cell.configCellBy(country)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return searchView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(CountryDetailViewController(), animated: true)
    }
    
}
