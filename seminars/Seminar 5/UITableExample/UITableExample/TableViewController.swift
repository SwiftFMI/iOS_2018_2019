//
//  TableViewController.swift
//  UITableExample
//
//  Created by grade on 8.11.18.
//  Copyright © 2018 grade. All rights reserved.
//

import UIKit

class TableViewController : UITableViewController {
    let cellIdentifier = "tableCell"
    let cellIdentifier2 = "rightAlignedCell"
    
    let sections = [["A", "B"], ["one", "two", "3"]]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Letters" : "Other"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = indexPath.section == 0 ? cellIdentifier : cellIdentifier2
        
        if let cell:MyCell = tableView.dequeueReusableCell(withIdentifier: cellId) as? MyCell{
        
            let data = sections[indexPath.section][indexPath.row]
            cell.label.text = data
            print("create cell[\(indexPath)] = \(data)")
            return cell
        }
        
        return UITableViewCell()
    }
    
   
    
 
    
}

class MyCell : UITableViewCell {
    @IBOutlet var label:UILabel!
}
