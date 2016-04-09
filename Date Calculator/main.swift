//
//  main.swift
//  Date Calculator
//
//  Created by Apro on 08/04/16.
//  Copyright © 2016 Apro. All rights reserved.
//

import Foundation

enum InputError : ErrorType{
    case InvalidInput
}

// regex for date range 01.01.1901 to 31.12.2999
let dateRegex = "^([0-2][1-9]|3[01])\\/(0[1-9]|1[0-2])\\/(19\\d{2}|2\\d{3})$"

func dateCalc(date: String, secondDate: String) throws -> Int {
    do{
        let extDate1 = try extractDate(date)
        let extDate2 = try extractDate(secondDate)
        
        let numDays = abs(julianDay(day: extDate1.day, month: extDate1.month, year: extDate1.year) -
            julianDay(day: extDate2.day, month: extDate2.month, year: extDate2.year))
        
        return max(0, numDays - 1)
    } catch{
        throw error
    }
}

func extractDate(date: String) throws -> (day: Int, month: Int, year: Int) {
    var extDate = [Int]()
    
    do{
        
        let regex = try NSRegularExpression(pattern: dateRegex, options: [])
        let results = regex.matchesInString(date, options: [], range: NSRange(location: 0, length: date.characters.count))
        
        guard let result = results.first else{
            throw InputError.InvalidInput
        }
        
        for i in 1..<result.numberOfRanges {
            let value = Int((date as NSString).substringWithRange(result.rangeAtIndex(i)))!
            extDate.append(value)
        }
        return (extDate[0], extDate[1], extDate[2])
        
    }catch{
        throw error
    }
}

func julianDay(day day: Int, month: Int, year: Int) -> Int {
    let a = (14 - month)/12
    let y = year + 4800 - a
    let m = month + 12*a - 3
    
    return day + ((153*m + 2)/5) + 365*y + (y/4) - (y/100) + (y/400) - 32045
}

print("Please enter a date in the following format - 'dd/mm/yyyy'.")
let a = readLine()

print("Please enter a second date in the following format - 'dd/mm/yyyy'.")
let b = readLine()

guard let a = a, b = b else{
    print("Invalid date format")
    exit(-1)
}

do {
    try print("\(dateCalc(a, secondDate: b)) days.")
} catch{
    print(error)
}
