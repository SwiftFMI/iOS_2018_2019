//
//  LoginViewController.swift
//  Login Start
//
//  Created by Spas Bilyarski on 18.10.18.
//  Copyright © 2018 FMI Practice. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // Задача 1: Променете цвета на "placeholder"-а на текстовите полета в най-подходящия метод от жизнения цикъл на контролера. Използвайте помощният метод от extension-a на UITextField по-долу.
    
    // Задача 2: В LoginViewController сцената в Main.storyboard имa добавен UITapGestureRecognizer. При изпълнението на жеста трябва да се извика метода endEditing(_:), на view-то на този контролер.
    
    // Задача 3: Добавете UINavigationController.
    
    // Задача 4: Направете CongratsViewController rootViewControler на току що добавеният UINavigationController.
    
    // Задача 5: При натискане на бутона "Вход" трябва да презентирате UINavigationController-a на CongratsViewController и да подадете данните от двете текстови полета на CongratsViewController.

}

extension UITextField {
    
    func setPlaceholderColor(_ color: UIColor) {
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [.foregroundColor: color])
    }
    
}

