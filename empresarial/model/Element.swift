//
//  Element.swift
//  empresarial
//
//  Created by Stefanie Luque on 31/05/18.
//  Copyright © 2018 Rafael vargas. All rights reserved.
//

import Foundation
import Gloss

//MARK: - Element
public struct Element: Glossy {
    
    public let distance : Distance!
    public let duration : Distance!
    public let status : String!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        distance = "distance" <~~ json
        duration = "duration" <~~ json
        status = "status" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "distance" ~~> distance,
            "duration" ~~> duration,
            "status" ~~> status,
            ])
    }
    
}
