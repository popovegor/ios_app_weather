//
//  WeatherIconMapper.swift
//
//
//  Created by Egor Popov on 17.03.2026
//

import Foundation

enum WeatherIconMapper {

    static let defaultIcon = "cloud.fill"

    static let dayIcons: [Int: String] = [
        1000: "sun.max.fill",
        1003: "cloud.sun.fill",
        1006: "cloud.fill",
        1009: "smoke.fill",
        1030: "cloud.fog.fill",
        1063: "cloud.drizzle.fill",
        1066: "cloud.snow.fill",
        1069: "cloud.sleet.fill",
        1072: "cloud.drizzle.fill",
        1087: "cloud.bolt.fill",
        1114: "wind.snow",
        1117: "wind.snow",
        1135: "cloud.fog.fill",
        1147: "cloud.fog.fill",
        1150: "cloud.drizzle.fill",
        1153: "cloud.drizzle.fill",
        1168: "cloud.drizzle.fill",
        1171: "cloud.drizzle.fill",
        1180: "cloud.rain.fill",
        1183: "cloud.rain.fill",
        1186: "cloud.rain.fill",
        1189: "cloud.rain.fill",
        1192: "cloud.heavyrain.fill",
        1195: "cloud.heavyrain.fill",
        1198: "cloud.rain.fill",
        1201: "cloud.heavyrain.fill",
        1204: "cloud.sleet.fill",
        1207: "cloud.sleet.fill",
        1210: "cloud.snow.fill",
        1213: "cloud.snow.fill",
        1216: "cloud.snow.fill",
        1219: "cloud.snow.fill",
        1222: "cloud.snow.fill",
        1225: "cloud.snow.fill",
        1237: "cloud.hail.fill",
        1240: "cloud.rain.fill",
        1243: "cloud.heavyrain.fill",
        1246: "cloud.heavyrain.fill",
        1249: "cloud.sleet.fill",
        1252: "cloud.sleet.fill",
        1255: "cloud.snow.fill",
        1258: "cloud.snow.fill",
        1261: "cloud.hail.fill",
        1264: "cloud.hail.fill",
        1273: "cloud.bolt.rain.fill",
        1276: "cloud.bolt.rain.fill",
        1279: "cloud.bolt.fill",
        1282: "cloud.bolt.fill"
    ]

    static let nightIcons: [Int: String] = [
        1000: "moon.stars.fill",
        1003: "cloud.moon.fill"
    ]

    static func sfSymbol(for code: Int, isDay: Bool = true) -> String {
        if !isDay, let nightIcon = nightIcons[code] {
            return nightIcon
        }
        return dayIcons[code] ?? defaultIcon
    }
}
