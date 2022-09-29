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
    private let serchBar = UISearchBar()
    private let btnGroup = UIButton(type: .system)
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel.countriesSaved.count == 0 {
            setupView()
            fetchCountries()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.isHidden = false
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupView(){
        serchBar.delegate = self
        
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
        btnGroup.removeFromSuperview()
        serchBar.removeFromSuperview()
        
        btnGroup.translatesAutoresizingMaskIntoConstraints = false
        btnGroup.tintColor = Colors.Enfasis.color
        btnGroup.setTitle("Group", for: .normal)
        btnGroup.addTarget(self, action: #selector(group), for: .touchUpInside)
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        label.text = "Countries"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        serchBar.backgroundImage = UIImage()
        serchBar.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIView()
        stack.backgroundColor = .white
        
        stack.addSubview(btnGroup)
        stack.addSubview(label)
        stack.addSubview(serchBar)
        
        NSLayoutConstraint.activate([
            btnGroup.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -8),
            btnGroup.topAnchor.constraint(equalTo: stack.topAnchor),
            
            label.topAnchor.constraint(equalTo: btnGroup.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -8),
            
            serchBar.topAnchor.constraint(equalTo: label.bottomAnchor),
            serchBar.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            serchBar.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
        ])
        
        return stack
    }
    
    func regionLabel(name: String, section: Int) -> UIView {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.backgroundColor = .white
        
        if section == 0{
            
            lbl.text = " \(name)"
            btnGroup.removeFromSuperview()
            
            btnGroup.translatesAutoresizingMaskIntoConstraints = false
            btnGroup.tintColor = Colors.Enfasis.color
            btnGroup.setTitle("Ungroup", for: .normal)
            btnGroup.addTarget(self, action: #selector(group), for: .touchUpInside)
            
            lbl.translatesAutoresizingMaskIntoConstraints = false
            
            let stack = UIView()
            
            stack.backgroundColor = .white
            
            stack.addSubview(btnGroup)
            stack.addSubview(lbl)
            
            NSLayoutConstraint.activate([
                btnGroup.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -8),
                btnGroup.topAnchor.constraint(equalTo: stack.topAnchor),
                
                lbl.topAnchor.constraint(equalTo: btnGroup.bottomAnchor),
                lbl.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 8),
                lbl.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -8)
            ])
            
            return stack
        } else {
            
            lbl.text = "   \(name)"
            return lbl
        }
    }
    
    @objc func group(){
        if btnGroup.titleLabel?.text == "Group" {
            btnGroup.setTitle("Ungroup", for: .normal)
            viewModel.isGrouped = true
        } else {
            viewModel.isGrouped = false
            btnGroup.setTitle("Group", for: .normal)
        }
        
        serchBar.resignFirstResponder()
        tableView.reloadData()
    }
}

extension CountriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count > 2 else {
            viewModel.isLookingFor(false)
            tableView.reloadData()
            return
        }
        
        viewModel.isLookingFor(true, text: searchText)
        tableView.reloadData()
    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.isGrouped {
            return viewModel.numberOfSections()
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdent) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        
        if let country = viewModel.getCountryByIndex(index: indexPath) {
            cell.configCellBy(country)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if viewModel.isGrouped {
            
            if section == 0 {
                return 60
            } else {
                return 40
            }
        }else {
            return 135
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if viewModel.isGrouped {
            let regionName = viewModel.getRegionName(section: section)
            
            return regionLabel(name: regionName, section: section)
        } else {
            return searchView()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showLoading()
        self.tableView.isHidden = true
        
        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { _ in
            self.viewModel.lookForCountryDetail(indexPath: indexPath) { country, isSaved in
                if let country = country {
                    let viewM = CountryDetailViewModel(countryDetail: country, isSaved: isSaved)
                    let detailVC = CountryDetailViewController(viewModel: viewM)
                    
                    detailVC.hidesBottomBarWhenPushed = true
                    
                    self.navigationController?.pushViewController(detailVC, animated: true)
                    self.hideLoading()
                } else {
                    self.tableView.isHidden = false
                }
            }
        }
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        serchBar.resignFirstResponder()
    }
}
