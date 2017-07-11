//
//  WaySearcherTests.swift
//  Metro Navigator v2.0
//
//  Created by Alex on 6/19/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import XCTest
@testable import Metro_Navigator_v2_0

class WaySearcherTests: XCTestCase {
    
    let testStations = [Station("Академмістечко", 130, .red),
                          Station("Житомирська", 160, .red),
                          Station("Святошин", 80, .red),
                          Station("Нивки", 100, .red),
                          Station("Берестейська", 170, .red),
                          Station("Шулявська", 100, .red)
                         ]
    
//    func testChangeTheTimeToNextStation() {
//        let waySearcher = WaySearcher(departure: "Житомирська", arrival: "Шулявська")
//        
//        
//        let expected1 = 130
//        let expected2 = 160
//        let expected3 = 80
//        var stations = testStations
//        stations = stations.reversed()
//        
//        XCTAssertEqual(waySearcher.changeTheTimeToNextStation(stations)[1].timeToNextStation, expected1)
//        XCTAssertEqual(waySearcher.changeTheTimeToNextStation(stations)[2].timeToNextStation, expected2)
//        XCTAssertEqual(waySearcher.changeTheTimeToNextStation(stations)[3].timeToNextStation, expected3)
//        
//    }
    
    func testGetStationsFromLine() {
        let waySearcher = WaySearcher(departure: "Нивки", arrival: "Вокзальна")
        
        let expected = "Берестейська"
        
        XCTAssertEqual(waySearcher.getStationsFromTheLine(testStations, "Святошин", "Берестейська")[2].name, expected)
        XCTAssertEqual(waySearcher.getStationsFromTheLine(testStations, "Святошин", "Берестейська").count, 3)
        
    }
    
    func testReverseIfOppositeDirection() {
        let waySearcher = WaySearcher(departure: "Берестейська", arrival: "Житомирська")
        
        let expected = "Шулявська"
        
        XCTAssertEqual(waySearcher.reverseIfOppositeDirection(testStations, "Берестейська", "Житомирська")[0].name, expected)
        
    }
    
    
    func testGetChangeStations() {
        
        var waySearcher = WaySearcher(departure: "Нивки", arrival: "Позняки")
        
        var expected1 = "Театральна"
        var expected2 = "Золоті Ворота"
        XCTAssertEqual(waySearcher.getChangeStationsNames().firstChange, expected1)
        XCTAssertEqual(waySearcher.getChangeStationsNames().secondChange, expected2)
        
        waySearcher = WaySearcher(departure: "Петрівка", arrival: "Дніпро")
        expected1 = "Майдан Незалежності"
        expected2 = "Хрещатик"
        XCTAssertEqual(waySearcher.getChangeStationsNames().firstChange, expected1)
        XCTAssertEqual(waySearcher.getChangeStationsNames().secondChange, expected2)
        
//        waySearcher = WaySearcher(departure: "Петрівка", arrival: "Дніпро")
//        expected1 = "Майдан"
//        expected2 = "Хрещатик"
//        XCTAssertEqual(waySearcher.getChangeStationsNames().firstChange, expected1)
//        XCTAssertEqual(waySearcher.getChangeStationsNames().secondChange, expected2)
        
//        waySearcher = WaySearcher(departure: "Петрівка", arrival: "Дніпро")
//        expected1 = "Хрещатик"
//        expected2 = "Майдан Незалежності"
//        XCTAssertEqual(waySearcher.getChangeStationsNames().firstChange, expected1)
//        XCTAssertEqual(waySearcher.getChangeStationsNames().secondChange, expected2)
      
    }
    
}
