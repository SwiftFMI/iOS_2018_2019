//
//  RoundedView.swift
//  Login Start
//
//  Created by Spas Bilyarski on 18.10.18.
//  Copyright © 2018 FMI Practice. All rights reserved.
//

import UIKit

@IBDesignable
final class RoundedView: UIView {

    /// Чрез тази променлива можете да контролирате заоблянето на ъглите на този контейнер.
    @IBInspectable var roundedCorners: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = roundedCorners
        }
    }

}
