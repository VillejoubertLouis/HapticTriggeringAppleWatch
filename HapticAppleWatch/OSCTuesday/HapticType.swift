//
//  HapticType.swift
//  OSCTuesday
//
//  Created by Louis Villejoubert on 24/07/2024.
//

enum HapticType: String {
    case notification = "notification"
    case directionUp = "directionUp"
    case directionDown = "directionDown"
    case success = "success"
    case failure = "failure"
    case retry = "retry"
    case start = "start"
    case stop = "stop"
    case click = "click"

    var hapticType: String {
        return self.rawValue
    }
}
