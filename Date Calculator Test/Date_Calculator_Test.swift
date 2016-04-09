//
//  Date_Calculator_Test.swift
//  Date Calculator Test
//
//  Created by Apro on 09/04/16.
//  Copyright © 2016 Apro. All rights reserved.
//

import XCTest

class Date_Calculator_Test: XCTestCase {
    
    func testDateCalc() {
        
        let d1 = "02/06/1983", d2 = "22/06/1983"
        
        XCTAssert(try dateCalc(d1, secondDate: d2) == 19)

        let d3 = "04/07/1984", d4 = "25/12/1984"
        XCTAssert(try dateCalc(d3, secondDate: d4) == 173)
        
        let d5 = "03/01/1989", d6 = "03/08/1983"
        XCTAssert(try dateCalc(d5, secondDate: d6) == 1979)
    }
}
