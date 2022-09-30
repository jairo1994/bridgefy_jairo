//
//  BlueViewController.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 30/09/22.
//

import CoreBluetooth
import UIKit

class BLEViewController: UIViewController {
    var centralManager: CBCentralManager?
    var peripherals = Array<CBPeripheral>()
    private let ident = "bluetoothCell"
    private var withOutScanView = UIView()
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    private let btnScan = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialise CoreBluetooth Central Manager
        setupView()
        showDefaultView()
        btnScan.setTitle("Scan", for: .normal)
    }
    
    @objc func scanBLE(){
        withOutScanView.removeFromSuperview()
        btnScan.setTitle("Looking for...", for: .normal)
        btnScan.isUserInteractionEnabled = false
        setupView()
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        
        Timer.scheduledTimer(withTimeInterval: 30.0, repeats: false) { _ in
            self.btnScan.setTitle("Scan", for: .normal)
            self.btnScan.isUserInteractionEnabled = true
            self.centralManager?.stopScan()
        }
        
    }
    
    func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BluetoothCellTableViewCell.self, forCellReuseIdentifier: ident)
        
        view.addSubview(tableView)
        
        btnScan.removeFromSuperview()
        
        btnScan.translatesAutoresizingMaskIntoConstraints = false
        btnScan.tintColor = Colors.Enfasis.color
        btnScan.addTarget(self, action: #selector(scanBLE), for: .touchUpInside)
        
        
        view.addSubview(btnScan)
        
        NSLayoutConstraint.activate([
            btnScan.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            btnScan.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: btnScan.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func showDefaultView(){
        let countryImage = UIView().getImage()
        let lookForlbl = UIView().getLabel(text: "Press scan button for search devices")
        countryImage.image = UIImage(named: "bluetooth")
        countryImage.tintColor = Colors.Enfasis.color
        
        let stack = UIView().getStack()
        stack.addArrangedSubview(countryImage)
        stack.addArrangedSubview(lookForlbl)
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            countryImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            countryImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }
    
    func titleView() -> UILabel{
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        label.text = " BLE"
        label.translatesAutoresizingMaskIntoConstraints = false
    
        return label
    }

}

extension BLEViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if (central.state == .poweredOn){
            self.centralManager?.scanForPeripherals(withServices: nil, options: nil)
        }
        else {
            // do something like alert the user that ble is not on
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if peripherals.firstIndex { $0.name == peripheral.name } == nil {
            peripherals.append(peripheral)
        }
        
        self.tableView.reloadData()
    }
}

extension BLEViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: ident)! as? BluetoothCellTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configCell(peripheral: peripherals[indexPath.item])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return titleView()
    }
}
