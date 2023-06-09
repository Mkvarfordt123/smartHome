//
//  DevicesTableViewController.swift
//  SmartHome
//
//  Created by Milo Kvarfordt on 6/7/23.
//

import UIKit

class DevicesTableViewController: UITableViewController {
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationCenter()
        
    }
 // MARK: - Actions
    
    @IBAction func deviceButtonTapped(_ sender: Any) {
       presentAlertController()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DeviceController.sharedInstance.devices.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell", for: indexPath) as? DeviceTableViewCell else { return UITableViewCell()}

        let device = DeviceController.sharedInstance.devices[indexPath.row]
        cell.updateUI(device: device)
        cell.delegate = self
        
        return cell
    }
    
    // MARK: - Functions
    func notificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(turnAllDevicesOn), name: Constants.Notifications.allDevicesOn, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(turnAllDevicesOff), name: Constants.Notifications.allDevicesOff, object: nil)
    }
    
    @objc func turnAllDevicesOn() {
        DeviceController.sharedInstance.toggleAllDevicesOn()
        tableView.reloadData()
    }
    @objc func turnAllDevicesOff() {
        DeviceController.sharedInstance.toggleAllDevicesOff()
        tableView.reloadData()
    }
    
    func presentAlertController() {
        let alertController = UIAlertController(title: "New Device Name", message: "Enter the name of your device below", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "New device name..."
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(dismissAction)
        let confirmAction = UIAlertAction(title: "Create", style: .default) { _ in
            guard let contentTextField = alertController.textFields?.first,
                  let name = contentTextField.text else { return }
            DeviceController.sharedInstance.createDevice(name: name)
            self.tableView.reloadData()
        }
        
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} //end of class

// MARK: - Extensions
extension DevicesTableViewController : DeviceTableViewCellDelegate {
    func isONSwithToggled(cell: DeviceTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let device = DeviceController.sharedInstance.devices[indexPath.row]
        DeviceController.sharedInstance.switchIsOn(device: device)
        cell.updateUI(device: device)
    }
} //end of class
