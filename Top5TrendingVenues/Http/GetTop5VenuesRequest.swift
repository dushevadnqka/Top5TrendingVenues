//
//  GetTop5VenuesRequest.swift
//  Top5TrendingVenues
//
//  Created by Georgi on 9.10.20.
//

import Foundation
import CoreLocation

protocol VenuesGetDelegate {
    func handleFetchedData(venues: [VenueModel]?)
    func didFailWithError(error: Error)
}

class GetTop5VenuesRequest: HttpRequest {
    
    var delegate: VenuesGetDelegate?
    
    private func prepareRequest(llParam: String) -> URLRequest {
        let getParamsString = "?v=\(Constants.HttpConnAtts.requestVersion)&limit=\(Constants.HttpConnAtts.fetchItemsLimit)&client_id=\(Constants.HttpConnAtts.clientID)&client_secret=\(Constants.HttpConnAtts.clientSecret)&ll=\(llParam)"
        
        let url =
            URL(string: "https://api.foursquare.com/v2/venues/search\(getParamsString)")
        
        guard let requestUrl = url else { fatalError() }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
    func decode(_ data: Data) {
        do {
            let decodedData = try JSONDecoder().decode(ApiResponseModel.self, from: data)

            delegate?.handleFetchedData(venues: decodedData.response.venues)
        } catch {
            delegate?.didFailWithError(error: error)
        }
    }
    
    func getVenues(latitude: CLLocationDegrees, longtitude: CLLocationDegrees) -> Void {
        let llParam = "\(latitude),\(longtitude)"
        let request = prepareRequest(llParam: llParam)
        
        execRequest(request: request)
    }
}
