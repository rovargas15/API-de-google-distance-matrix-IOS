//
//  Distance.swift
//  empresarial
//
//  Created by Stefanie Luque on 31/05/18.
//  Copyright © 2018 Rafael vargas. All rights reserved.
//

import Foundation
import Gloss

//MARK: - Distance
public struct Distance: Glossy {
    
    public let text : String!
    public let value : Int!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        text = "text" <~~ json
        value = "value" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "text" ~~> text,
            "value" ~~> value,
            ])
    }
    
}
