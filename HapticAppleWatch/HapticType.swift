//
//  HapticType.swift
//  OSCTuesday
//
//  Created by Louis Villejoubert on 24/07/2024.
//

#if os(watchOS)
import WatchKit
#endif

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

    #if os(watchOS)
    var wkHapticType: WKHapticType {
        switch self {
        case .notification:
            return .notification
        case .directionUp:
            return .directionUp
        case .directionDown:
            return .directionDown
        case .success:
            return .success
        case .failure:
            return .failure
        case .retry:
            return .retry
        case .start:
            return .start
        case .stop:
            return .stop
        case .click:
            return .click
        }
    }
    #endif
}
