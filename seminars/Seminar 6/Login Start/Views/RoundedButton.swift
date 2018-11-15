//
//  RoundedButton.swift
//  Login Start
//
//  Created by Spas Bilyarski on 15.11.18.
//  Copyright © 2018 FMI Practice. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    /// Чрез тази променлива можете да контролирате заоблянето на ъглите на този контейнер.
    @IBInspectable var roundedCorners: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = roundedCorners
        }
    }

}
