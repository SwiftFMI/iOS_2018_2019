import Foundation

final class Weather {
    static let shared = Weather()
    private(set) var current: Current?

    func requestCurrentWeatherWithCompletion(completion: @escaping Networking.CurrentCoditionsCompletion) {
        Networking.getCurrentConditions(completion: completion)
    }

    private init() { }

    struct Current: Decodable {
        private enum TopLevelCodingKeys: String, CodingKey {
            case weather, main
        }

        private enum WeatherCodingKeys: String, CodingKey {
            case main, description
        }

        private enum MainCodingKeys: String, CodingKey {
            case temp, humidity
        }

        let conditions: String
        let imageName: String
        let temp: Int

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: TopLevelCodingKeys.self)

            let mainNestedContainer = try container.nestedContainer(keyedBy: MainCodingKeys.self, forKey: .main)
            temp = try mainNestedContainer.decode(Int.self, forKey: .temp)

            var weatherNestedContainer = try container.nestedUnkeyedContainer(forKey: .weather)

            let weatherValueContainer = try weatherNestedContainer.nestedContainer(keyedBy: WeatherCodingKeys.self)

            conditions = try weatherValueContainer.decode(String.self, forKey: .description)
            imageName = try weatherValueContainer.decode(String.self, forKey: .main).lowercased()
        }
    }

    struct Forecast {
        
    }
}
