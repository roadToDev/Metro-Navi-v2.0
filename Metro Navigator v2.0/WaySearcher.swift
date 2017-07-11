import Foundation

public class WaySearcher {
    
    let allStations = NavigatorData.redLine + NavigatorData.blueLine + NavigatorData.greenLine
    var way = [Station]()
    
    var departureStationName : String
    var arrivalStationName : String
    var changeStationName : String?
    
    
    init(departure: String, arrival: String) {
        departureStationName = departure
        arrivalStationName = arrival
    }
    
    func getStationFromName (_ name: String) -> Station{
        for station in allStations {
            if station.name.lowercased() == name.lowercased() {
                return station
            }
        }
        return Station("", 0, .blue)
    }
    
    func reverseIfOppositeDirection(_ stations: [Station], _ depStation: String, _ arrStation: String) -> [Station] {
        var reversedPath = stations
        
        var arrivalStationIndex = 0
        var departureStationIndex = 0
        
        for ( index , station ) in stations.enumerated() {
            if station.name.lowercased() == depStation.lowercased() {
                departureStationIndex = index
            }
            else if station.name.lowercased() == arrStation.lowercased() {
                arrivalStationIndex = index
            }
        }
        
        if departureStationIndex > arrivalStationIndex {
            reversedPath = TimeHandler.changeTheTimeToNextStation(reversedPath)
            reversedPath = reversedPath.reversed()
        }
        
        return reversedPath
    }
    
    func getStationsFromTheLine(_ depStation: String, _ arrStation: String) -> [Station] {
        var lineStations : [Station]
        var cuttedLine = [Station]()
        var flag = false
        var onlyOneStationInLine : Station?
        let lineColor = getStationFromName(depStation).line
        
        switch lineColor {
        case .red:
            lineStations = NavigatorData.redLine
        case .blue:
            lineStations = NavigatorData.blueLine
        case .green:
            lineStations = NavigatorData.greenLine
        }
        
        lineStations = reverseIfOppositeDirection(lineStations, depStation, arrStation)
        
        for station in lineStations {
            if station.name.lowercased() == depStation.lowercased() {
                onlyOneStationInLine = station
                flag = true
            } else if station.name.lowercased() == arrStation.lowercased() {
                flag = false
                cuttedLine.append(station)
            }
            if flag {
                cuttedLine.append(station)
            }
        }
        
        if flag {
            onlyOneStationInLine?.timeToNextStation = 0
            return [onlyOneStationInLine!]
        }
        cuttedLine[0].timeToNextStation = 0
        return cuttedLine
    }
    
    func pathCutDifferentLines() -> [Station]{
        
        let firstLineChangeStation = getChangeStationsNames().firstChange
        let secondLineChangeStation = getChangeStationsNames().secondChange
        
        let firstLineStations = getStationsFromTheLine(departureStationName, firstLineChangeStation!)
        var secondLineStations = getStationsFromTheLine(secondLineChangeStation!, arrivalStationName)
        secondLineStations[0].timeToNextStation = 300
        return firstLineStations + secondLineStations
        
    }
    
    func getTheWay() -> [Station]{
        changeStationName = getChangeStationsNames().firstChange
        let departureStation = getStationFromName(departureStationName)
        let arivalStation = getStationFromName(arrivalStationName)
    
        if departureStation.line == arivalStation.line {
           return getStationsFromTheLine(departureStationName, arrivalStationName)
        } else {
           return pathCutDifferentLines()
        }
    
    }

    func getChangeStationsNames() -> (firstChange: String?, secondChange: String?) {
        
        let departure = getStationFromName(departureStationName)
        let arrival = getStationFromName(arrivalStationName)
        
        let allChangeStations = ["Театральна",
                                 "Хрещатик",
                                 "Золоті Ворота",
                                 "Палац Спорту",
                                 "Майдан Незалежності",
                                 "Площа Льва Толстого"
                                 ]
        
        if departure.line == arrival.line {
            return (nil, nil)
        } else {
        
            switch departure.line {
            case .red:
                if arrival.line == .green {
                    return (allChangeStations[0], allChangeStations[2])
                } else {
                    return (allChangeStations[1], allChangeStations[4])
                }
            case .green:
                if arrival.line == .red {
                    return (allChangeStations[2], allChangeStations[0])
                } else {
                    return (allChangeStations[3], allChangeStations[5])
                }
            case .blue:
                if arrival.line == .red {
                    return (allChangeStations[4], allChangeStations[1])
                } else {
                    return (allChangeStations[5], allChangeStations[3])
                }
            }
        }
    }
}


 
