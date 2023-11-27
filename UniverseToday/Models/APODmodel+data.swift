//
//  APODData.swift
//  Universe
//
//  Created by 김하연 on 11/17/23.
//

import Foundation

struct ApodModel {
    let url: String
    let title: String
    let explanation: String
}


struct APOD: Codable {
    let url: String
    let title: String
    let explanation: String
}
