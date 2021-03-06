//
//  city.swift
//  WeatherApp
//
//  Created by Sofi on 05.03.2021.
//

import Foundation

struct City: Equatable {
    let name: String
}

extension City {
    static func getListOfTeam () -> [City] {
        var teamMembers:[City] = []
        let names = DataManager.shard.city
        for index in 0..<names.count {
            let person = City(name: names[index])
            teamMembers.append(person)
        }
        return teamMembers
    }
}
