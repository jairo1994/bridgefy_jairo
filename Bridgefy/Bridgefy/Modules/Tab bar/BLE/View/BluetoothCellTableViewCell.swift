//
//  BluetoothCellTableViewCell.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 30/09/22.
//

import CoreBluetooth
import UIKit

class BluetoothCellTableViewCell: UITableViewCell {
    var stack = UIStackView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(peripheral: CBPeripheral) {
        stack.removeFromSuperview()
        stack = getStack(axis: .vertical, aligment: .leading, space: 0)
        
        let nameLabel = getLabel(text: "Name: \(peripheral.name ?? "unknow")")
        nameLabel.numberOfLines = 0
        stack.addArrangedSubview(nameLabel)
        
        let identifier = getLabel(text: "Identifier: \(peripheral.identifier)")
        identifier.numberOfLines = 0
        stack.addArrangedSubview(identifier)
        
        var state = getLabel(text: "")
        state.numberOfLines = 0
        
        switch peripheral.state {
        case .connected:
            state.text = "Status: Connected"
        case .disconnected:
            state.text = "Status: Disconnected"
        case .connecting:
            state.text = "Status: Connecting"
        case .disconnecting:
            state.text = "Status: Sisconnecting"
        default:
            state.text = ""
        }
        stack.addArrangedSubview(state)
        
        
        contentView.addSubview(stack)
        stack.constraintToParent(parent: contentView, top: 8, leading: 8, trailing: -8, bottom: -8)
    }

}
