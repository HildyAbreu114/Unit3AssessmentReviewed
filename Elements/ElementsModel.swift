//
//  ElementsModel.swift
//  Elements
//
//  Created by hildy abreu on 9/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

//struct ElementsInfo: Codable {
//    let elementsData: [ElementWrapper]
// 
//    }

struct ElementWrapper: Codable {
    let name: String
    let symbol: String
    let weight: Double
    let number: Int
    let meltingPoint: Double?
    let boilingPoint: Double?
    let discoveryBy: String?
    
    var threeDigitNumber: String {
        switch number{
        case 1...9:
            return "00\(number)"
        case 10...99:
            return "0\(number)"
        default:
            return "100"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case weight = "atomic_mass"
        case number
        case meltingPoint = "melt"
        case boilingPoint = "boil"
        case discoveryBy = "discovered_by"

}

}

