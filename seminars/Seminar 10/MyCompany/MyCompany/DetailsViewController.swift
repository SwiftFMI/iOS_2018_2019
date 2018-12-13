//
//  DetailsViewController.swift
//  Employees
//
//  Created by Spas Bilyarski on 12.12.18.
//  Copyright © 2018 FMI Practice. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var developer: DeveloperModel?
    var manager: ManagerModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = manager {
            pictureImageView.image = data.image
            nameLabel.text = data.name
            descriptionLabel.text = "Екип:"
        } else if let data = developer {
            pictureImageView.image = data.image
            nameLabel.text = data.name
            descriptionLabel.text = "Мениджър:"
        }
    }
    
}

extension DetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let manager = manager {
            return manager.employees?.count ?? 0
        } else if developer != nil {
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeesIdentifier", for: indexPath) as! PersonTableViewCell
        
        if let data = manager?.employees?[indexPath.row] {
            cell.setData(from: data)
            
        } else if let data = developer?.manager {
            cell.setData(from: data)
        }
        
        return cell
    }
    
}
