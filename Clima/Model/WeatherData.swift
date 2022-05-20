import Foundation

struct WeatherData : Decodable {
    
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Float
}

struct Weather: Decodable {
    let description: String
    let id: String
}
