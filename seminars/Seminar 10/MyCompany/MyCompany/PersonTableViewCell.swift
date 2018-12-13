//
//  PersonTableViewCell.swift
//  MyCompany
//
//  Created by Spas Bilyarski on 12.12.18.
//  Copyright © 2018 FMI Practice. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet private weak var pictureImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
    
    func setData(from employee: EmployeeModel?) {
        nameLabel.text = employee?.name
        pictureImageView.image = employee?.image
    }

}
