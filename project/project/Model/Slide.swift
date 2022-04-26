//
//  Slide.swift
//  project
//
//  Created by Zefferer Chiara on 26.04.22.
//

import Foundation

struct Slide : Equatable, Identifiable {
    let id: UUID = UUID()
    var number: Int = 0
    var title: String = "unknown"
    var imgFileName: String
    
    
}

extension Slide:Decodable {
    enum CodingKeys: String, CodingKey{
        case imgFileName = "filename"
        case number = "id"
        case title
        
    }
    
}
