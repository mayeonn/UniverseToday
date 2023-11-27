//
//  Category.swift
//  Universe
//
//  Created by 김하연 on 11/13/23.
//

import Foundation

struct Category: Identifiable {
    let id: Int    
    var title: String {
        switch id {
        case 1:
            return "APOD"
        case 2:
            return "News"
        case 3:
            return "Launch"
        case 4:
            return "Quotes"
        case 5:
            return "Music"
        default:
            return "APOD"
        }
    }
    
    var subTitle: String {
        switch id {
        case 1:
            return "Astronomy picture of the Day"
        case 2:
            return "Spaceflight News"
        case 3:
            return "Orbital launches and a number of popular suborbital launches"
        case 4:
            return "A"
        case 5:
            return "B"
        default:
            return "Astronomy picture of the Day"
        }
    }
}
