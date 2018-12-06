import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

struct Weather {
    let location: String
    let date: String
    let day: String
    let condtion: String
    let temperature: String
    
    enum WeatherKeys: String, CodingKey {
        case location
        case date
        case day
        case temperature
        case condtion = "skytext"
    }
    
    enum ResponseKeys: String, CodingKey {
        case data
    }
}

extension Weather: Decodable {
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: ResponseKeys.self)
        let weather = try response.nestedContainer(keyedBy: WeatherKeys.self, forKey: .data)
        location = try weather.decode(String.self, forKey: .location)
        date = try weather.decode(String.self, forKey: .date)
        day = try weather.decode(String.self, forKey: .day)
        condtion = try weather.decode(String.self, forKey: .condtion)
        temperature = try weather.decode(String.self, forKey: .temperature)
    }
}

final class Networking {
    private init() { }

    static func getCurrentWeather(completion: @escaping (Weather?) -> ())  {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.5dayweather.org"
        components.path = "/api.php"

        let cityParameter = URLQueryItem(name: "city", value: "Sofia")
        components.queryItems = [cityParameter]

        let url = components.url!

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            completion(try? JSONDecoder().decode(Weather.self, from: data))
        }.resume()
    }
}

URLSession.shared.dataTask(with: URL(string: "https://i.imgur.com/8xmNS4k.jpg")!) { (data, response, error) in

    print(data?.count)

}.resume()

//Networking.getCurrentWeather { (weather) in
//    print(weather?.condtion)
//    PlaygroundPage.current.finishExecution()
//}

