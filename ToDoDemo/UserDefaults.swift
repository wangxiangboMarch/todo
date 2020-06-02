//
//  UserDefaults.swift
//  ToDoDemo
//
//  Created by wangxiangbo on 2020/5/20.
//  Copyright © 2020 Mars. All rights reserved.
//

import Foundation

enum DateMode: Int {
    case text
    case digit

    var format: String {
        return self == .text ? "E, dd MMMM" : "EEEEE, MM/dd"
    }
}

enum TemperatureMode: Int {
    case celsius
    case fahrenheit
}

struct UserDefaultsKeys {
    static let dateMode = "dateMode"
    static let temperatureMode = "temperatureMode"
    static let locations = "myLocations"
}

extension UserDefaults {
    
    static func addLocation(_ location: Location) {
        var locations = loadLocations()
        locations.append(location)

        saveLocations(locations)
    }

    static func removeLocation(_ location: Location) {
        var locations = loadLocations()

        guard let index = locations.firstIndex(of: location) else {
            return
        }

        locations.remove(at: index)

        saveLocations(locations)
    }
    
    static func saveLocations(_ locations: [Location]) {
        let dictionaries: [[String: Any]] =
            locations.map { $0.toDictionary }

        UserDefaults.standard.set(dictionaries, forKey: UserDefaultsKeys.locations)
    }
    
    static func loadLocations() -> [Location] {
        let data = UserDefaults.standard.array(
            forKey: UserDefaultsKeys.locations)
        guard let dictionaries = data as? [[String: Any]] else {
            return []
        }

        // compactMap
        return dictionaries.compactMap {
            return Location(from: $0)
        }
    }
    
    static func dateMode() -> DateMode {
        let value = UserDefaults.standard.integer(
            forKey: UserDefaultsKeys.dateMode)

        return DateMode(rawValue: value) ?? DateMode.text
    }

    static func setDateMode(to value: DateMode) {
        UserDefaults.standard.set(
            value.rawValue,
            forKey: UserDefaultsKeys.dateMode)
    }

    static func temperatureMode() -> TemperatureMode {
        let value = UserDefaults.standard.integer(
            forKey: UserDefaultsKeys.temperatureMode)

        return TemperatureMode(rawValue: value) ??
            TemperatureMode.celsius
    }

    static func setTemperatureMode(to value: TemperatureMode) {
        UserDefaults.standard.set(
            value.rawValue,
            forKey: UserDefaultsKeys.temperatureMode)
    }
}
