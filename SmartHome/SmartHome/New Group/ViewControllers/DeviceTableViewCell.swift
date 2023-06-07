//
//  DeviceTableViewCell.swift
//  SmartHome
//
//  Created by Milo Kvarfordt on 6/7/23.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {

  // MARK: - Outlets
    @IBOutlet weak var deviceTextLabel: UILabel!
    @IBOutlet weak var isOnSwitch: UISwitch!
    
    // MARK: - Properties
    
    
    // MARK: - Functions
    func updateUI(device: Device) {
        deviceTextLabel.text = device.name
        
    }

    // MARK: - Actions
    @IBAction func isOnSwitchTapped(_ sender: Any) {
        
    }
} //end of class