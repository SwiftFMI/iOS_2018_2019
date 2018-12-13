//
//  AddViewController.swift
//  Employees
//
//  Created by Spas Bilyarski on 12.12.18.
//  Copyright © 2018 FMI Practice. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var isManagerSwitch: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var developers = [DeveloperModel]()
    
    private lazy var managers = [ManagerModel]()
    
    @IBAction func isManagerSwitchAction(_ sender: UISwitch) {
        tableView.allowsMultipleSelection = sender.isOn
        tableView.reloadData()
    }
    
    @IBAction func tapOnPictureAction(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addAction(_ sender: Any) {
    
        let imageData = pictureImageView.image?.pngData()
        var employee: EmployeeModel?
        
        if isManagerSwitch.isOn {
            let selectedDevelopers = tableView.indexPathsForSelectedRows?.compactMap { developers[$0.row] }
            employee = ManagerModel(name: nameTextField.text, picture: imageData, employees: selectedDevelopers)
        } else {
            if let selectedIndex = tableView.indexPathForSelectedRow?.row {
                employee = DeveloperModel(name: nameTextField.text, picture: imageData, manager: managers[selectedIndex])
            } else {
                employee = DeveloperModel(name: nameTextField.text, picture: imageData, manager: nil)
            }
        }
        
        print(employee ?? "nil")
        
        dismiss(animated: true, completion: nil)
    }
}

extension AddViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isManagerSwitch.isOn ? developers.count : managers.count
    }
    
    func tableView(_ tableViewP: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewP.dequeueReusableCell(withIdentifier: "employeesIdentifier", for: indexPath) as! PersonTableViewCell
        
        let data = isManagerSwitch.isOn ? developers[indexPath.row] : managers[indexPath.row]
        cell.setData(from: data)

        return cell
    }
    
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.pictureImageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
