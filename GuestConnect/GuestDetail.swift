//
//  File.swift
//  GuestConnect
//
//  Created by Richard Sunden on 12/7/19.
//  Copyright © 2019 Richard Sunden. All rights reserved.
//

import Foundation

class GuestDetail: Codable {

    var firstName: String?
    var lastName: String?
    var instagramUsername: String?
    var snapchatUsername: String?
    
    init(firstName: String?, lastName: String?, instagramUsername: String?, snapchatUsername: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.instagramUsername = instagramUsername
        self.snapchatUsername = snapchatUsername
    }
}
