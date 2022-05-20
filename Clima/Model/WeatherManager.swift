import Foundation
import UIKit

struct WeatherManager {

    let openWeatherBaseURL: String = "https://api.openweathermap.org/data/2.5/weather?";
    let appId = "9698da09f02ae8d753e904c96e776cea";
    
    func fetchWeather(_ cityName: String) {
        //fetch weather from weather API
        let urlString = "\(openWeatherBaseURL)&q=\(cityName)&appid=\(appId)&units=metric";
        print("The url is \(urlString)")
        performRequest(urlString)
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
                    print(error!)
                    return ;
                }
                
                if let safeData = data {
                    //let dataString = String(data: safeData, encoding: .utf8)
                    self.parseJSON(weatherData: safeData)
                }
            }
            
            //Step 4: Start the task
            task.resume()

        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder();
        
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print("Decoded JSON Data. Location is - \(decodedData.name) and temp is \(decodedData.main.temp).\n Weather description : \(decodedData.weather[0].description)  ");
            let _ = decodedData.weather[0].id;
        }
        catch {
            print(error)
        }
    }
    
    func getConditionName(weatherData: Int) -> String {
        switch(weatherData) {
            
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        default:
            return "cloud.clear"
        }
    }
    
    

}

