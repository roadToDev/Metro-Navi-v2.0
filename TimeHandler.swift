import Foundation

class TimeHandler {
    
    static func secondsToMinutesSeconds (seconds : Int) -> (String){
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
    
        if minutes == 0 {
            return ""
        } else if seconds == 0 {
            return ("\(minutes):00 хв")
        }  else {
            return ("\(minutes):\(seconds) хв")
        }
    }
    static func getFullTime (_ stations : [Station]) -> (String){
        
        var fullTime = 0
        
        for station in stations {
            fullTime += station.timeToNextStation
        }
        
        fullTime = fullTime + (10 * (stations.count - 1))
        
        let minutes = (fullTime % 3600) / 60
        let seconds = (fullTime % 3600) % 60
        
        if minutes == 0 {
            return ""
        } else if minutes == 0 {
            return ("\(minutes):00 хв")
        }  else {
            if seconds < 10 {
                return ("Час в дорозі ≈ \(minutes):0\(seconds) хв")
            } else {
                return ("Час в дорозі ≈ \(minutes):\(seconds) хв")
            }
        
        }
    }
    
    static func changeTheTimeToNextStation(_ stations: [Station]) -> [Station] {
        
        var stationsWithReversedTime = stations
        
        for i in 0..<stationsWithReversedTime.count - 1 {
            stationsWithReversedTime[i].timeToNextStation = stations[i+1].timeToNextStation
        }

        return stationsWithReversedTime
    }
    
}
