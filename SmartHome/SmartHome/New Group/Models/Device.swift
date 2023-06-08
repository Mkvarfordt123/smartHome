//
//  Device.swift
//  SmartHome
//
//  Created by Milo Kvarfordt on 6/7/23.
//

import Foundation

class Device: Codable {
 
    var name: String
    var isOn: Bool
    let uuid: UUID
    
    init(name: String, isOn: Bool = false, uuid: UUID = UUID()) {
        self.name = name
        self.isOn = isOn
        self.uuid = uuid
    }
}


 // MARK: - Extension
extension Device: Equatable {
    static func == (lhs: Device, rhs: Device) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
