//
//  RandomDate.swift
//  lessson 3
//
//  Created by Alexander Myskin on 24.07.2020.
//  Copyright © 2020 Alexander Myskin. All rights reserved.
//

import Foundation
class RandomDate{
    
    static func generateRandomDate(daysBack : Int) -> String{
        //let daysBack = 100
        let day = arc4random_uniform(UInt32(daysBack))+1
        let hour = arc4random_uniform(23)
        let minute = arc4random_uniform(59)
        
        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = -1 * Int(day - 1)
        offsetComponents.hour = -1 * Int(hour)
        offsetComponents.minute = -1 * Int(minute)
        
        guard let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) ) else {return "01-01-1900"}
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-YYYY"
        let mydate = formatter.string(from: randomDate)
        
        
        return mydate
    }
}
