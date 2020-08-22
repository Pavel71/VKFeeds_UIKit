//
//  UserResponse.swift
//  VKFeeds
//
//  Created by PavelM on 22/08/2019.
//  Copyright © 2019 PavelM. All rights reserved.
//

import Foundation


struct UserResponseWrapped: Decodable {
  
  let response: [UserResponse]
  
}

struct UserResponse: Decodable {
  let photo100: String
}


