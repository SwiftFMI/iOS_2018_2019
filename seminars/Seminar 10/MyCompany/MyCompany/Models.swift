//
//  Models.swift
//  MyCompany
//
//  Created by Spas Bilyarski on 12.12.18.
//  Copyright © 2018 FMI Practice. All rights reserved.
//

import UIKit


class EmployeeModel {
    
    let name: String?
    let picture: Data?
    
    var image: UIImage? {
        guard let picture = picture else {
            return nil
        }
        
        return UIImage(data: picture)
    }
    
    init(name: String?, picture: Data?) {
        self.name = name
        self.picture = picture
    }
    
}

class DeveloperModel: EmployeeModel {
    
    let manager: ManagerModel?
    
    init(name: String?, picture: Data?, manager: ManagerModel?) {
        self.manager = manager
        super.init(name: name, picture: picture)
    }
    
}

class ManagerModel: EmployeeModel {
    
    let employees: [EmployeeModel]?
    
    init(name: String?, picture: Data?, employees: [EmployeeModel]?) {
        self.employees = employees
        super.init(name: name, picture: picture)
    }
    
}
