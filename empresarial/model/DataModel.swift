//
//  DataModel.swift
//  empresarial
//
//  Created by Stefanie Luque on 31/05/18.
//  Copyright © 2018 Rafael vargas. All rights reserved.
//

import Foundation
import Gloss

//MARK: - DataModel
public struct DataModel: Glossy {
    
    public let destinationAddresses : [String]!
    public let originAddresses : [String]!
    public let rows : [Row]!
    public let status : String!
    
    
    
    //MARK: Decodable
    public init?(json: JSON){
        destinationAddresses = "destination_addresses" <~~ json
        originAddresses = "origin_addresses" <~~ json
        rows = "rows" <~~ json
        status = "status" <~~ json
    }
    
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "destination_addresses" ~~> destinationAddresses,
            "origin_addresses" ~~> originAddresses,
            "rows" ~~> rows,
            "status" ~~> status,
            ])
    }
    
}
