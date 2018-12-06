//
//  ViewController.swift
//  ImageDownload
//
//  Created by Dragomir Ivanov on 5.12.18.
//  Copyright © 2018 Dragomir Ivanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        Networking.getImage { [weak self] (image) in
            self?.imageView.image = image
            self?.activityIndicator.stopAnimating()
        }
    }
}

