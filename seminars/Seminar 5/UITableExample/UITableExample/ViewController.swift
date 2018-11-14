//
//  ViewController.swift
//  UITableExample
//
//  Created by grade on 8.11.18.
//  Copyright © 2018 grade. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,
UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cc", for: indexPath)
        
        return cell
    }
    
    let cellIdentifier = "tableCell"
    let cellIdentifier2 = "rightAlignedCell"
    
    let sections = [["A", "B"], ["one", "two", "3"]]
    

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    

    //MARK: - data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Letters" : "Other"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = indexPath.section == 0 ? cellIdentifier : cellIdentifier2
        
        if let cell:MyCell = tableView.dequeueReusableCell(withIdentifier: cellId) as? MyCell{
            
            let data = sections[indexPath.section][indexPath.row]
            cell.label.text = data
            print("create cell[\(indexPath)] = \(data)")
            return cell
        }
        print("DEFAULT")
        return UITableViewCell()
    }


}

