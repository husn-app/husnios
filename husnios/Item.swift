//
//  Item.swift
//  husnios
//
//  Created by Prashant Shishodia on 18/10/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
