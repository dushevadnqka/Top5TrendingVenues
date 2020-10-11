//
//  ViewController.swift
//  Top5TrendingVenues
//
//  Created by Georgi on 8.10.20.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var segmentedControlEl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lastTop5VenuesScreen: UIView!
    
    var indicator = MyCustomActivityIndicator()
    let aboutUsScreen = AboutSegmentView()
    
    var venueItems: [VentureModel] = [
        VentureModel(name: "Ala", desc: "bala"),
        VentureModel(name: "Dve", desc: "Dve asdasd"),
        VentureModel(name: "Tri", desc: "Tri asdsfff")
    ]
    
    let cellNibName = "Top5VenuesCell"
    let cellID = "ReusableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: cellID)
        
        setupSubViews()
    }
    
    func setupSubViews() {
        // activity indicator init & start
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        
        // aboutus segment view
        aboutUsScreen.center = self.view.center
        self.view.addSubview(aboutUsScreen)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        previewFirstElement()
    }
    
    // MARK: - switch between items in segmented control
    
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
    
    func previewFirstElement() {
        lastTop5VenuesScreen.isHidden = false
        aboutUsScreen.isHidden = true
        indicator.activityIndicatorTrigger()
        
        print("btn 1 was clicked!")
    }
    
    func previewSecondElement() {
        
        lastTop5VenuesScreen.isHidden = true
        aboutUsScreen.isHidden = false
        
        print("btn 2 was clicked!")
    }
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venueItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let venue = venueItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! Top5VenuesCell
        
        DispatchQueue.main.async {
            cell.ventureTitle.text = "\(indexPath.row + 1). \(venue.name)"
            cell.ventureDesc.text = venue.desc
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    // MARK: - Remove activity indicator when the table is loaded
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        indicator.activityIndicatorStop()
    }
}

//MARK: - FilterTags
