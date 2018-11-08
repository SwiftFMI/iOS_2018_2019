//
//  ViewController.swift
//  Telephone
//
//  Created by Dragomir Ivanov on 25.10.18.
//  Copyright © 2018 Dragomir Ivanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var model = PhoneBook() { [weak self] in
        self?.updateView()
    }
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var eraseButton: UIButton!
    @IBOutlet var numButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(forName: .modelUpdated,
//                                               object: nil,
//                                               queue: nil) { [weak self] _ in
//                                                self?.updateView()
//        }
        
        callButton.backgroundColor = .green
        callButton.layer.cornerRadius = callButton.frame.width/2
        
        for button in numButtons {
            button.layer.cornerRadius = button.frame.width/2
        }
        
//        PhoneBook.shared.number = nil
        model.store = nil
    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }

    @IBAction func buttonTap(_ sender: UIButton) {
        if let buttonTitle = sender.currentTitle {
            model.store = (model.store ?? "") + buttonTitle
        }
    }
    
    @IBAction func erase() {
        model.store = "\(model.store?.dropLast() ?? "")"
    }
    
    @IBAction func zeroLongPress(_ sender: Any) {
        if (sender as? UILongPressGestureRecognizer)?.state == .began {
            model.store = (model.store ?? "") + "+"
        }
    }
    
    func updateView() {
        textLabel?.text = formatPhoneNumber(text: model.store, with: " ")
        eraseButton?.isHidden = model.store?.isEmpty ?? true
    }
    
    func formatPhoneNumber(text: String?, with separator: String) -> String? {
        guard let textUnwrapped = text else {
            return text
        }
        
        var formattedText = ""
        for (index, character) in textUnwrapped.enumerated() {
            if index != 0 && index % 3 == 0 {
                formattedText.append(separator)
            }
            
            formattedText.append(String(character))
        }
        
        return formattedText
    }
}
