//
//  Constants.swift
//  Top5TrendingVenues
//
//  Created by Georgi on 11.10.20.
//

struct Constants {
    static let sourceDataLabelTextFoursquare = "...loaded from Foursquare"
    static let sourceDataLabelTextLocal = "...loaded from local"
    
    struct HttpConnAtts {
        static let clientID = "PA0ME4BYDUGKRTHGBDRASO241C4INYVVEUVFY3USFH2SSE1V"
        static let clientSecret = "QN1FAO3VAH3HG4YN1R5EGZYSJ4TGHYBIRLEV012WLI11XKVI"
        static let fetchItemsLimit = 5
        static let requestVersion = "20200606" // it is hardcoded, i understand the purpose of having it
    }
    
    struct ReusableCell {
        static let cellNibName = "Top5VenuesCell"
        static let cellID = "ReusableCell"
    }
    
    struct NSNotificationName {
        static let rawValue = "refreshList"
    }
    
    struct NWPathMonitorQueue{
        static let label = "Monitor"
    }
}
