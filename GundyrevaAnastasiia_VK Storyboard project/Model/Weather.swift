//
//  Weather.swift
//  GundyrevaAnastasiia_VK Storyboard project
//
//  Created by Asya Checkanar on 08.02.2023.
//

import Foundation



class WeatherResponse: Decodable {
    let list: [Weather]
}

class Weather: Decodable {
    var date = Date()
    var temp = ""
    var pressure = 0.0
    var humidity = 0
    var weatherName = ""
    var weatherDescription = ""
    var feelsLike = ""
    var tempMin = ""
    var tempMax = ""
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
    }
    enum MainKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
    enum WeatherKeys: String, CodingKey {
        case main, description
    }

    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        //блок операций дата
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
//        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        let dat = try values.decode(Int.self, forKey: .date)
        self.date = formatter.date(from: String(dat)) ?? Date()
        
        let mainValues = try values.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        
        //блок операций температура
        
        let tempFormatter = MeasurementFormatter()
        tempFormatter.unitOptions = .providedUnit
        let temNorm = try mainValues.decode(Double.self, forKey: .temp)
        let t = Measurement(value: temNorm, unit: UnitTemperature.fahrenheit)
        self.temp = tempFormatter.string(from: t.converted(to: .celsius))
        
        let temFeels = try mainValues.decode(Double.self, forKey: .feelsLike)
        let t2 = Measurement(value: temFeels, unit: UnitTemperature.fahrenheit)
        self.feelsLike = tempFormatter.string(from: t2.converted(to: .celsius))
        
        let temMin = try mainValues.decode(Double.self, forKey: .tempMin)
        let t3 = Measurement(value: temMin, unit: UnitTemperature.fahrenheit)
        self.tempMin = tempFormatter.string(from: t3.converted(to: .celsius))
        
        let temMax = try mainValues.decode(Double.self, forKey: .tempMax)
        let t4 = Measurement(value: temMax, unit: UnitTemperature.fahrenheit)
        self.tempMax = tempFormatter.string(from: t4.converted(to: .celsius))
        
        //конец блока
        
        self.pressure = try mainValues.decode(Double.self, forKey: .pressure)
        self.humidity = try mainValues.decode(Int.self, forKey: .humidity)
        
        var weatherValues = try values.nestedUnkeyedContainer(forKey: .weather)
        let firstValue = try weatherValues.nestedContainer(keyedBy: WeatherKeys.self)
        
        self.weatherName = try firstValue.decode(String.self, forKey: .main)
        self.weatherDescription = try firstValue.decode(String.self, forKey: .description)
        
        
        
    }
}







//struct Place: Decodable {
//    var weather: [Weather]
//    var main: Main
//    var date: String
//    var sys: System
//    var name: String
//
//    enum PlaceKeys: String, CodingKey {
//        case weather
//        case main
//        case date = "dt"
//        case sys
//        case name
//    }
//}
//
//struct Weather: Decodable {
//    var main: String
//    var description: String
//}
//
//struct Main: Decodable {
//    var temp: String
//    var feelsLike: String
//    var tempMin: String
//    var tempMax: String
//
//    enum MainKeys: String, CodingKey {
//        case temp
//        case feelsLike = "feels_like"
//        case tempMin = "temp_min"
//        case tempMax = "temp_max"
//    }
//}
//
//struct System: Decodable {
//    var country: String
//    var sunrise: String
//    var sunset: String
//}






//struct CurrentTime: Decodable {
//    var date: String
//    var temp: String
//    var feelsLike: String
//    var weather: [Weather]
//    var minutely: [byMinute]
//    var hourly: [byHour]
//    var daily: [byDay]
//    var alerts: [Alerts]
    
//    enum CodingKeys: String, CodingKey {
//        case date = "dt"
//        case temp
//        case feelsLike = "feels_like"
//        case weather
//        case minutely
//        case hourly
//        case daily
//        case alerts
//    }
//}
//
//struct Weather: Decodable {
//    var main: String
//    var description: String
//
//}
//
//struct byMinute: Decodable {
//    var date: String
//
//    enum MinuteKeys: String, CodingKey {
//        case date = "dt"
//    }
//}
//
//struct byHour: Decodable {
//    var date: String
//    var temp: String
//    var feelsLike: String
//    var weather: [Weather]
//
//    enum HourKeys: String, CodingKey {
//        case date = "dt"
//        case temp
//        case feelsLike = "feels_like"
//        case weather
//    }
//}
//
//struct byDay: Decodable {
//    var date: String
//    var sunrise: String
//    var sunset: String
//    var moonrise: String
//    var moonset: String
//    var temp: tempByDay
//    var feelsLike: feelsLikeByDay
//    var weather: [Weather]
//
//    enum DayKeys: String, CodingKey {
//        case date = "dt"
//        case sunrise
//        case sunset
//        case moonrise
//        case moonset
//        case temp
//        case feelsLike = "feels_like"
//        case weather
//    }
//}
//
//struct tempByDay: Decodable {
//    var day: String
//    var min: String
//    var max: String
//    var night: String
//    var eve: String
//    var morn: String
//}
//
//struct feelsLikeByDay: Decodable {
//    var day: String
//    var night: String
//    var eve: String
//    var morn: String
//}
//
//struct Alerts: Decodable {
//    var senderName: String
//    var event: String
//    var start: String
//    var end: String
//    var description: String
//
//    enum DayKeys: String, CodingKey {
//        case senderName = "sender_name"
//        case event
//        case start
//        case end
//        case description
//    }
//
//}
