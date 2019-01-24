//
//  Board.swift
//  Trello
//
//  Created by huda elhady on 1/24/19.
//  Copyright © 2019 huda.elhady. All rights reserved.
//

import Foundation
class Board: Codable {
      var title: String
      var items:[String]
      
      init(title: String,items: [String]) {
            self.title = title
            self.items = items
      }
}
