//
//  CurrentConditionsViewController.swift
//  SofiaWeather
//
//  Created by Dragomir Ivanov on 6.12.18.
//  Copyright © 2018 SwiftFMI. All rights reserved.
//

import UIKit

class CurrentConditionsViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var conditionsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        clear()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if Weather.shared.current == nil {
            Weather.shared.requestCurrentWeatherWithCompletion { [weak self] (current) in
                DispatchQueue.main.async {
                    guard let current = current else {
                        self?.clear()
                        return
                    }

                    self?.conditionsLabel.text = current.conditions.capitalized
                    self?.tempLabel.text = "\(current.temp)℃"
                    self?.imageView.image = UIImage(named: current.imageName)
                
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }

    func clear() {
        activityIndicator.startAnimating()
        tempLabel.text = nil
        conditionsLabel.text = nil
        imageView.image = nil
    }
}
