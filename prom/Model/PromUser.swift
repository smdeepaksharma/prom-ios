//
//  PromUser.swift
//  prom
//
//  Created by Deepak Sharma S M on 3/11/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

class PromUser: Decodable {
    
    var uid: String?
    var name: String?
    var email: String?
    
    init(uid: String, name: String) {
        self.uid = uid
        self.name = name
    }
}

