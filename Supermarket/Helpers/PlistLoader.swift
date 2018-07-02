//
//  PlistLoader.swift
//  Supermarket
//
//  Created by Kirill Koleno on 02.07.2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import Foundation

enum PlistError: Error {
    case invalidResource
    case parsingFailure
}

/// Class witch get data from file and set it to Array of Dictionaryes
class PlistLoader {
    static func array(fromFile name: String, ofType type: String) throws -> [[String: String]] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else { throw PlistError.invalidResource }
        guard let array = NSArray(contentsOfFile: path) as? [[String: String]] else { throw PlistError.parsingFailure }
        
        return array
    }
}
