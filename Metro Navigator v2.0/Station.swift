//
//  Station.swift
//  Metro Navigator v2.0
//
//  Created by Alex on 6/16/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import Foundation


class Station {
    
    var name: String
    var timeToNextStation: Int
    var line: Line
    
    init(_ name: String, _ timeToNextStation: Int, _ line: Line) {
        self.name = name
        self.timeToNextStation = timeToNextStation
        self.line = line
    }
    
}

enum Line {
    case red
    case blue
    case green
}
