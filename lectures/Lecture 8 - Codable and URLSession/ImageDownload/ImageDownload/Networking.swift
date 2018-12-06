//
//  Networking.swift
//  ImageDownload
//
//  Created by Dragomir Ivanov on 5.12.18.
//  Copyright © 2018 Dragomir Ivanov. All rights reserved.
//

import UIKit

final class Networking {

    private init() { }

    static func getImage(completion: @escaping (UIImage?) -> ()) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        URLSession.shared.dataTask(with: URL(string: "https://img1.fonwall.ru/o/yd/slon-zhivotnoe-doroga.jpg")!) { (data, response, error) in

            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                guard let data = data else {
                    completion(nil)
                    return
                }
                
                completion(UIImage(data: data))
            }
            }.resume()
    }
}
