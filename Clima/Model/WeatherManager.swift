import Foundation
import UIKit

struct WeatherManager {

    let openWeatherBaseURL: String = "https://api.openweathermap.org/data/2.5/weather?";
    
    //DONOT COMMIT THIS IN CODE
    let appId = "TO INSERT OPEN WEATHER APP ID HERE";
    
    var delegate: WeatherManagerDelegate? ;
    
    func fetchWeather(_ cityName: String) {
        //fetch weather from weather API
        let urlString = "\(openWeatherBaseURL)&q=\(cityName)&appid=\(appId)&units=metric";
        print("The url is \(urlString)")
        performRequest(urlString)
    }
    
    func fetchWeather(_ lat: Double, _ lon: Double){
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(appId)&units=metric";
        performRequest(urlString);
    }
    
    func performRequest(_ urlString: String) {
        
        //Networking steps
        //Step 1: Create URL
        if let url = URL(string: urlString){
            
            //Step 2: Create URL Session
            let session = URLSession(configuration: .default )
            
            //Step 3: Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!);
                    return ;
                }
                
                if let safeData = data {
                    //let dataString = String(data: safeData, encoding: .utf8)
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather)
                    }
                }
            }
            
            //Step 4: Start the task
            task.resume()

        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder();
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id;
            let name = decodedData.name;
            let temp = decodedData.main.temp;
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp);
            let desc = weather.conditionName;
            print("Decoded JSON Data. Location is - \(name) and temp is \(temp).\n Weather description : \(decodedData.weather[0].description)  ");
            print("condition name is \(desc)") ;
            
            return weather ;
        }
        catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel)
    func didFailWithError(error: Error)
    
}

