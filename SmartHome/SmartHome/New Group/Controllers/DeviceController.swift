//
//  DeviceController.swift
//  SmartHome
//
//  Created by Milo Kvarfordt on 6/7/23.
//

import Foundation

class DeviceController {
    
    // MARK: - Properties
    static let sharedInstance = DeviceController()
    var devices: [Device] = []
    
    init() {
        load()
    }
    // MARK: - CRUD Functions
    func createDevice(name: String) {
        let device = Device(name: name)
        devices.append(device)
        save()
    }
    
    func deleteDevice() {
        
    }
    
    func switchIsOn(device: Device) {
        device.isOn.toggle()
        save()
        
    }
    
    // MARK: - Persistence
    func save() {
        guard let url = fileURL else { return }
        do {
            //this is for the single source of truth
            let data = try JSONEncoder().encode(devices)
            try data.write(to: url)
        } catch {
            print(error)
        }
    }
    
    func load() {
        guard let url = fileURL else { return }
        do {
            let data = try Data(contentsOf: url)
            let devices = try JSONDecoder().decode([Device].self, from: data)
            self.devices = devices
        } catch {
            print(error)
        }
    }
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
        let url = documentsDirectory.appendingPathComponent("devices.json")
        return url
    }
}//end of class
