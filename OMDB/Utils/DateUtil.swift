//
//  DateUtil.swift
//  OMDB
//
//  Created by Rohit Jain on 04/10/18.
//  Copyright © 2018 Rohit Jain. All rights reserved.
//

import Foundation

public class DateUtil{
    static func getMovieReleaseDate(movieYear: String) -> String{
        let formatter = DateFormatter()
        
        let startIndex = movieYear.index(movieYear.startIndex, offsetBy: 4)
        let str = movieYear[..<startIndex]
        
        let dateStr = "01 JAN \(str)"
        formatter.dateFormat = "dd MMM yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let date = formatter.date(from: dateStr)
        
        let numberOfYears = Date().years(from: date!)
        if numberOfYears == 0 {
            let numberOfMonths = Date().months(from: date!)
            if(numberOfMonths == 0){
                let numberOfDays = Date().days(from: date!)
                return "\(numberOfDays) days ago"
            }else{
                if(numberOfMonths == 1){
                    return "1 month ago"
                }else{
                    return "\(numberOfMonths) months ago"
                }
            }
        }else{
            if(numberOfYears == 1){
                return "1 year ago"
            }else{
                return "\(numberOfYears) years ago"
            }
        }
    }
}
