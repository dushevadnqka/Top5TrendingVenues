//
//  ApiResponseModel.swift
//  Top5TrendingVenues
//
//  Created by Georgi on 10.10.20.
//

import Foundation

struct RequestMetadata: Codable {
    let code: Int
}

struct Location: Codable {
    let formattedAddress: [String]
}

struct VenueModel: Codable {
    let name: String
    let location: Location
    
    var address: String {
        return location.formattedAddress.joined(separator: ", ")
    }
}

struct Response: Codable {
    let venues: [VenueModel]?
}

struct ApiResponseModel: Codable {
    let meta: RequestMetadata
    let response: Response
}
