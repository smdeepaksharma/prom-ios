//
//  InvitePresenter.swift
//  prom
//
//  Created by Deepak Sharma S M on 4/21/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

class InvitePresenter: NSObject {
    
    let inviteService: InviteService?
    
    init(inviteService: InviteService) {
        self.inviteService = inviteService
    }
    
    
    func getMembersList() {
        
        let s = InviteService()
        s.getPromUsers(onMembersFetched: { promUsers in
            for user in promUsers {
                print(user.email)
            }
        })
        
        
        
    }

}
