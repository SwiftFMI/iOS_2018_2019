//
//  PhoneBook.swift
//  Telephone
//
//  Created by Dragomir Ivanov on 31.10.18.
//  Copyright © 2018 Dragomir Ivanov. All rights reserved.
//

import Foundation

protocol PhoneBookDelegate: class {
    func numberDidUpdate()
}

protocol Model {
    associatedtype StoredValue
    typealias Updated = () -> Void
    
    var store: StoredValue? { set get }
    var updated: Updated { get }
}

class PhoneBook: Model {
    weak var delegate: PhoneBookDelegate? {
        didSet {
            delegate?.numberDidUpdate()
        }
    }
    
    let updated: Updated
    
    var store: String? {
        didSet {
            updated()
//            NotificationCenter.default.post(name: .modelUpdated, object: nil)
//            delegate?.numberDidUpdate()
        }
    }
    
    init(updatedClosure: @escaping Updated) {
        self.updated = updatedClosure
    }
    
//    static let shared = PhoneBook()
//    private init() { }
}

//extension Notification.Name {
//    static let modelUpdated = Notification.Name("modelUpdated")
//}
