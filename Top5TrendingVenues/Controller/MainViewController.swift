//
//  ViewController.swift
//  Top5TrendingVenues
//
//  Created by Georgi on 8.10.20.
//

import UIKit
import CoreLocation
import CoreData
import Network

class MainViewController: UIViewController {
    
    @IBOutlet weak var segmentedControlEl: UISegmentedControl!
    @IBOutlet weak var contentViewWrapper: UIView!
    @IBOutlet weak var sourceDataLabel: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
    
    let locationManager = CLLocationManager()
    let getVenuesRequest = GetTop5VenuesRequest()
    let indicator = MyCustomActivityIndicator()
    let aboutUsScreen = AboutSegmentView()
    let tableView = Top5TableView()
    
    var venueItems: [VenueTableModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(refreshItems),
            name:NSNotification.Name(rawValue: Constants.NSNotificationName.rawValue),
            object: nil
        )
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        getVenuesRequest.delegate = self
        
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: Constants.ReusableCell.cellNibName, bundle: nil),
            forCellReuseIdentifier: Constants.ReusableCell.cellID
        )
        
        setupSubViews()
    }
    
    func setupSubViews() {
        tableView.separatorStyle = .none
        
        let subViews = [tableView, indicator, aboutUsScreen]
        
        for subView in subViews {
            subView.center = self.view.center
            self.view.addSubview(subView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        previewFirstElement()
    }
}

//MARK: - VenuesGetDelegate

extension MainViewController: VenuesGetDelegate {
    func handleFetchedData(venues: [VenueModel]?) {
        indicator.activityIndicatorStop()
        
        if let venuesSafe = venues {
            
            removeFromCache()
            
            for venue in venuesSafe as [VenueModel] {
                // load table with fresh data
                venueItems.append(VenueTableModel(name: venue.name, address: venue.address))
                
                // store the data to local cache
                // for bigger number of items (currently they are always 5) i would prefer to store them batch
                let venueToCache = VenueCached(context: context)
                venueToCache.name = venue.name
                venueToCache.address = venue.address
                
                saveCache()
            }

            DispatchQueue.main.async {
                self.sourceDataLabel.isHidden = false
                self.sourceDataLabel.text = Constants.sourceDataLabelTextFoursquare
                self.tableView.reloadData()
            }
        }
    }
    
    func didFailWithError(error: Error) {
        indicator.activityIndicatorStop()
        print(error)
    }
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venueItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let venue = venueItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReusableCell.cellID, for: indexPath) as! Top5VenuesCell
        
        DispatchQueue.main.async {
            cell.venueTitle.text = "\(indexPath.row + 1). \(venue.name)"
            cell.venueAddress.text = venue.address
        }
        
        return cell
    }
}

//MARK: - CLLocationManagerDelegate

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            getVenuesRequest.getVenues(latitude: lat, longtitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        // probably add it to log would be perfect
        print(error)
    }
}

//MARK: - Data Source Management

extension MainViewController {
    @objc func refreshItems() {
        // invalidate old items
        if venueItems.count > 0 {
            venueItems.removeAll()
        }
        
        loadData()

        indicator.activityIndicatorTrigger()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadData() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: Constants.NWPathMonitorQueue.label)
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.locationManager.requestLocation()
            } else {
                self.getLastStoredItemsFromCache()
            }
        }
        
        monitor.start(queue: queue)
        monitor.cancel()
    }
    
    func removeFromCache() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "VenueCached")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }

        saveCache()
    }
    
    func getLastStoredItemsFromCache() {
        indicator.activityIndicatorStop()
        
        let request: NSFetchRequest<VenueCached> = VenueCached.fetchRequest()
        
        do {
            let venuesCachedResult = try context.fetch(request)
            
            for venue in venuesCachedResult {
                if let venueNameSafe = venue.name, let venueAddressSafe = venue.address {
                    venueItems.append(VenueTableModel(name: venueNameSafe, address: venueAddressSafe))
                }
            }
        } catch {
            print(error)
        }
        
        DispatchQueue.main.async {
            self.sourceDataLabel.isHidden = false
            self.sourceDataLabel.text = Constants.sourceDataLabelTextLocal
            self.tableView.reloadData()
        }
    }
    
    func saveCache() {
        do {
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
}

//MARK: - Switch between items in segmented control

extension MainViewController {
    func previewFirstElement() {
        tableView.isHidden = false
        sourceDataLabel.isHidden = true
        aboutUsScreen.isHidden = true
        
        refreshItems()
    }
    
    func previewSecondElement() {
        
        tableView.isHidden = true
        sourceDataLabel.isHidden = true
        aboutUsScreen.isHidden = false
    }
    
    @IBAction func segmentedControllSwitch(_ sender: UISegmentedControl) {
        switch segmentedControlEl.selectedSegmentIndex {
        case 0:
            previewFirstElement()
        case 1:
            previewSecondElement()
        default:
            break;
        }
    }
}
