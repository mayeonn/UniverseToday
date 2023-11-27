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
            return K.Category.APOD
        case 2:
            return K.Category.News
        case 3:
            return K.Category.Launch
        case 4:
            return K.Category.Quotes
        case 5:
            return K.Category.Music
        default:
            return K.Category.APOD
        }
    }
    
    var subTitle: String {
        switch id {
        case 1:
            return K.CategoryExplanation.APOD
        case 2:
            return K.CategoryExplanation.News
        case 3:
            return K.CategoryExplanation.Launch
        case 4:
            return K.CategoryExplanation.Quotes
        case 5:
            return K.CategoryExplanation.Music
        default:
            return K.CategoryExplanation.APOD
        }
    }
}
