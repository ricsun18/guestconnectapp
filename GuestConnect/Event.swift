//
//  Event.swift
//  GuestConnect
//
//  Created by Richard Sunden on 12/7/19.
//  Copyright © 2019 Richard Sunden. All rights reserved.
//

import Foundation

class Event: Codable {
    var eventName: String
    var guestList = [GuestDetail]()
    
    init(eventName: String, guestList: [GuestDetail]) {
        self.eventName = eventName
    }
}
