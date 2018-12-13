//
//  ListViewController.swift
//  Employees
//
//  Created by Spas Bilyarski on 12.12.18.
//  Copyright © 2018 FMI Practice. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UITableViewController {
    
    var selectedIndex = 0
    
    private var developers = [DeveloperModel]()
    
    private var managers = [ManagerModel]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue", let details = segue.destination as? DetailsViewController {
            if selectedIndex < managers.count {
                let data = managers[selectedIndex]
                details.manager = data
            } else {
                let data = developers[selectedIndex - managers.count]
                details.developer = data
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managers.count + developers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeesIdentifier", for: indexPath) as! PersonTableViewCell
        
        var data: EmployeeModel?
        
        if indexPath.row < managers.count {
            data = managers[indexPath.row]
        } else {
            data = developers[indexPath.row - managers.count]
        }
        
        cell.setData(from: data)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "detailsSegue", sender: tableView)
    }

}

