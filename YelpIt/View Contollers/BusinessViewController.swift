//
//  ViewController.swift
//  YelpIt
//
//  Created by Sudipta Bhowmik on 11/2/17.
//  Copyright © 2017 Sudipta Bhowmik. All rights reserved.
//

/*
 Autolayout constraints:
 
 RestaurantImgview - top, left. bottom is greater equal 12
 nameLabel - top, left, bottom(with starImage) , right(with distanceLabel = 8). Note that width of nameLabel should be such that actual distance to distanceLabel is 8px.
 Also note the content hugging of namelabel for horizontal hugging has LOW priority. The content compression resistance property for horizontal compression has HIGH priority.
 
*/


import UIKit
import CoreLocation
import EZLoadingActivity

class BusinessViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewControllerDelegate {
    
    
    
    //MARK - Outlets
    //===============
    @IBOutlet weak var restaurantsTableView: UITableView!
    
    
    //MARK - Properties
    //===================
    var businesses: [Business]? {
        didSet {
            self.restaurantsTableView.reloadData()
        }
    }
    
    var allBusinesses: [Business]?
    var filteredBusinesses : [Business]?
    let searchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Set up table view
        setupTableView()
        
        //Set up UISearchBar
        setupSearchBar()
        
        searchWithTerm(searchStr: "restaurants")
        
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    
    //MARK - TableView Functions
    //==============================
    func setupTableView() {
        restaurantsTableView.dataSource = self
        restaurantsTableView.delegate = self
        //Tells the table view to use whatever height constraints are specified by auto-layout
        restaurantsTableView.rowHeight = UITableViewAutomaticDimension
        //Give an estimate for the vertical scrollbar to be displayed. Actual is calculated lazily depending on autolayout
        restaurantsTableView.estimatedRowHeight = 120
        //restaurantsTableView.backgroundColor = UIColor(named: "clear")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return businesses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = restaurantsTableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! ResturantTableViewCell
        
            cell.business = businesses?[indexPath.row]
        
        return cell
    }
    
    
  
    //MARK - UISearchBar Functions
    //===============================
    
    func setupSearchBar() {
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.placeholder = "Restaurants"
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.gray
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text {
            //If there is text in the searchBar then filter the allBusinesses array with search text
            //and set the businesses array to filtered array which will trigger tableview reloaddata()
            if searchText.isEmpty {
                searchBar.text = "Restaurants"
                let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
                
                textFieldInsideSearchBar?.textColor = UIColor.gray
                searchWithTerm(searchStr: "restaurants")
            } else {
                self.businesses = self.allBusinesses?.filter({ (business : Business)->Bool in
                    if (business.name?.lowercased().contains(searchText.lowercased()))! {
                        return true
                    }
                    else {
                        return false
                    }
                })
            }
            
        }
    
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //When a search term is entered & user hits search, start a new search
        if let searchText = searchBar.text {
            if !searchText.isEmpty {
                searchWithTerm(searchStr: searchText)
            } else {
                searchWithTerm(searchStr: "restaurants")
            }
        }
    }
    
    
    // MARK: - Delegate Implementation
    func searchWithFilters(sort: YelpSortMode, distance: String?, hasDeals: Bool, categories: [String]?) {
      
       //Default search is for Restaurants. However, if a search term is entered in searchbar, and the categories set in filters is empty, we use the search term from searchbar
        var searchterm : String = "Restaurants"
        if let searchbarText = searchBar.text {
            if !searchbarText.isEmpty {
                if categories?.count == 0 {
                    searchterm = searchbarText
                }
            }
        }
        
        //If categories is set, we want to display them in the searchBar
        if let cats = categories {
            if (cats.count > 0) {
                var sbarText = ""
                for category in cats {
                    sbarText.append(category)
                }
                searchBar.text = sbarText
            }
        }
        
        Business.searchWithTerm(term: searchterm, sort: sort, categories: categories, completion: { (businesses: [Business]?, error: Error?) -> Void in
            //Store copy of businesses in allBusinesses
            self.allBusinesses = businesses
            
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                    print(business.categories!)
                    
                }
            }
            
            //set the businesses array to allBusinesses which will trigger tableview reloaddata()
            self.businesses = self.allBusinesses
            
        }
        )
    }
    
    func searchWithTerm(searchStr : String) {
        if self.navigationController?.topViewController == self {
        
        EZLoadingActivity.show("Loading...", disableUI: true)
        }
        Business.searchWithTerm(term: searchStr, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            
            
            //Store copy of businesses in allBusinesses
            self.allBusinesses = businesses
            
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                    print(business.categories!)
                    
                }
            }
            
            //set the businesses array to allBusinesses which will trigger tableview reloaddata()
            
            self.businesses = self.allBusinesses
            EZLoadingActivity.hide()
            
        }
        )
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "mapsSegue":
                if let vc = segue.destination as? MapsViewController {
                    var rests : [Restaurant]?
                    rests = self.businesses?.map({ (b) -> Restaurant in
                        let rest = Restaurant(title: b.name!, coordinate: CLLocationCoordinate2DMake(b.latitude!, b.longitude!))
                        return rest
                    })
                     vc.mapRestaurants = rests
                    
                }
            case "filtersSegue":
                let navigationController = segue.destination as! UINavigationController
                let filtersViewController = navigationController.topViewController as! FiltersViewController
                filtersViewController.delegate = self
                
            default:
                break
            }
        }
        
    }
}


