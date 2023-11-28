//
//  LaunchModel+data.swift
//  UniverseToday
//
//  Created by 김하연 on 11/28/23.
//

import Foundation

struct LaunchData: Decodable {
    let results: [Launch]
}

struct Launch: Decodable {
    let image: String
    let rocket: Rocket
    let mission: Mission
    let net: String //time
    let status: LaunchStatus
    let launch_service_provider: LaunchServiceProvider
    let pad: Pad //발사대
}
struct Rocket: Decodable {
    let configuration: Configuration
}
struct Configuration: Decodable {
    let full_name: String
}
struct Mission: Decodable {
    let name: String
    let description: String //unused
}
struct LaunchStatus: Decodable {
    let name: String
}
struct LaunchServiceProvider: Decodable {
    let name: String
}
struct Pad: Decodable {
    let name: String
    let location: Location
}
struct Location: Decodable {
    let name: String
}



struct LaunchModel {
    let image: String
    let status: String
    let rocketName: String
    let agency: String
    let mission: String
    let net: String
    var time: String {
        return convertTimezone(timezone: net)
    }
    let padName: String
    let padLocation: String
    
    
    func convertTimezone(timezone: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let dateUTC = dateFormatter.date(from: timezone)
        
        if let date = dateUTC {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
            let localTimeStamp = dateFormatter.string(from: date)
            return localTimeStamp
        }
        return ""
    }
}


