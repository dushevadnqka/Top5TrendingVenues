## The goal of the task is to demonstrate the ability of the candidate to implement CoreData, custom UI component, and Web Services integration.
##### Details and limitations:
- To get the top 5 trending venues, the application has to integrate the Foursquare API:
https://developer.foursquare.com/docs/api/venues/trending​.
- **The application must not use any third-party libraries and frameworks.**
- There should be two screens switched with UISegmentControl:
- List with the top 5 trending venues
- "About us" screen with sample text
- **The data has to be persisted using CoreData. When the application is loaded in offline mode, it should display the venues that were loaded last time.**
- The application has to support the iPhone only in portrait mode.
- The candidate can make assumptions about everything that is not clear in the description of the task.

## Top5TrendingVenues Task Solution
- It's built and tested on iPhone XR (phisical) & iPhone 11 (Simulator)
- iOS version 13.6
- The "trending" endpoint (GET https://api.foursquare.com/v2/venues/trending) does not work as expected (always returns empty venues collection []) and I have used "search" instead
- More tests can be added if required
