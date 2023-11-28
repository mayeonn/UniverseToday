//
//  LaunchManager.swift
//  UniverseToday
//
//  Created by 김하연 on 11/28/23.
//

import Foundation

protocol LaunchManagerDelegate {
    func launchLoaded()
}

class LaunchManager {
    var launches = [LaunchModel]()
    var delegate: LaunchManagerDelegate?
    
    func performRequest(){
        if let url = URL(string: K.launchURL){
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let safeData = data {
                    if let launchResults = self.parseJSON(safeData) {
                        self.launches = launchResults
                        self.delegate?.launchLoaded()
                    }
                }
                else if let error = error {
                    print(error)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ launchData: Data) -> [LaunchModel]? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(LaunchData.self, from: launchData)
            let results = decodeData.results
            var launchResults = [LaunchModel]()
            for launch in results {
                let image: String = launch.image
                let rocketName: String = launch.rocket.configuration.full_name
                let mission: String = launch.mission.name
                let net: String = launch.net
                let status: String = launch.status.name
                let agency: String = launch.launch_service_provider.name
                let padName: String = launch.pad.name
                let padLocation: String = launch.pad.location.name
                
                let newLaunch = LaunchModel(image: image, status: status, rocketName: rocketName, agency: agency, mission: mission, net: net, padName: padName, padLocation: padLocation)
                launchResults.append(newLaunch)
            }
            return launchResults
        } catch {
            print(error)
            return nil
        }
    }
}
