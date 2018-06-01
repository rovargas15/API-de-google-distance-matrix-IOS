//
//  Row.swift
//  empresarial
//
//  Created by Stefanie Luque on 31/05/18.
//  Copyright © 2018 Rafael vargas. All rights reserved.
//

import Foundation
import Gloss

//MARK: - Row
public struct Row: Glossy {
    
    public let elements : [Element]!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        elements = "elements" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "elements" ~~> elements,
            ])
    }
    
}
