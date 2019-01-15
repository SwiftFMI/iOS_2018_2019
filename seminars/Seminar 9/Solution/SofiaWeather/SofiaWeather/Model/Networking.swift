//
//  Networking.swift
//  SofiaWeather
//
//  Created by Dragomir Ivanov on 6.12.18.
//  Copyright © 2018 SwiftFMI. All rights reserved.
//

import Foundation

final class Networking {
    typealias CurrentCoditionsCompletion = (Weather.Current?) -> ()

    static func getCurrentConditions(completion: @escaping CurrentCoditionsCompletion) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Sofia,bg&units=metric&lang=bg&appid=7df485076cd86fd0dbab7e38b388e8dc")!

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let weather = try JSONDecoder().decode(Weather.Current.self, from: data)
                
                completion(weather)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}

//API_KEY: 7df485076cd86fd0dbab7e38b388e8dc

//Current weather
//http://api.openweathermap.org/data/2.5/weather?q=Sofia,bg&units=metric&lang=bg&appid={API_KEY}
//Base URL: http://api.openweathermap.org
//Path: data/2.5/weather
//Parameters: q - Sofia,bg;units - metric, lang - bg, appid - API_KEY
//Response - CurrentWeatherResponse.json


//5-day forecast
//http://api.openweathermap.org/data/2.5/forecast?q=Sofia,bg&units=metric&lang=bg&appid={API_KEY}
//Base URL: http://api.openweathermap.org
//Path: data/2.5/forecast
//Parameters: q - Sofia,bg;units - metric, lang - bg, appid - API_KEY
//Response - ForecastResponse.json
