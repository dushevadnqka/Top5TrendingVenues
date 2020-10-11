//
//  ApiResponseModelTest.swift
//  Top5TrendingVenuesTests
//
//  Created by Georgi on 11.10.20.
//

import XCTest
@testable import Top5TrendingVenues

class ApiResponseModelTest: XCTestCase {
    
    var resModel: ApiResponseModel!
    var cityName: String!
    var streetName: String!
    var streetNumber: String!
    var formattedAddress: [String]!
    var venue1Name: String!
    var venue2Name: String!
    var meta: RequestMetadata!
    var location: Location!
    var response: Response!
    
    override func setUpWithError() throws {
        cityName = "City"
        streetName = "StreetName"
        streetNumber = "number"
        formattedAddress = [cityName, streetName, streetNumber]
        venue1Name = "Some Venue Name"
        venue2Name = "Some Another Venue Name"
        meta = RequestMetadata(code: 200)
        location = Location(formattedAddress: formattedAddress)
        
        response = Response(venues: [
            VenueModel(name: venue1Name, location: location),
            VenueModel(name: venue2Name, location: location)
        ])
        resModel = ApiResponseModel(meta: meta, response: response)
    }
    
    override func tearDownWithError() throws {
        resModel = nil
    }
    
    func testVenueModelIsComputed() {
        let expectedComputedResult = formattedAddress.joined(separator: ", ")
        
        if let venues = resModel.response.venues {
            for venue in venues {
                XCTAssertEqual(venue.address, expectedComputedResult)
            }
        }
    }
    
    func testPerformanceVenuModelAddressComputation() throws {
        self.measure {
            if let venues = resModel.response.venues {
                for venue in venues {
                    print(venue.address)
                }
            }
        }
    }
    
}
