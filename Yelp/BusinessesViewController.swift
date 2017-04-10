//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate {
    
    var businesses: [Business]!
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchBar: UISearchBar!
    var myLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        
        // add shadow
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowOpacity = 0.5
        searchBar.layer.masksToBounds = false
        
        // hide cancel button
        searchBar.showsCancelButton = true
        
        // hide bookmark button
        searchBar.showsBookmarkButton = false
        
        // set Default bar status.
        searchBar.searchBarStyle = UISearchBarStyle.default
        
        // set title
        searchBar.prompt = "Title"
        
        // set placeholder
        searchBar.placeholder = "Input text"
        
        // change the color of cursol and cancel button.
        searchBar.tintColor = UIColor.red
        
        // hide the search result.
        searchBar.showsSearchResultsButton = false
        
        // add searchBar to the view.
        self.view.addSubview(searchBar)
        
        // make UITextField
        myLabel = UILabel()
        myLabel.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        myLabel.text = ""
        myLabel.layer.borderWidth = 1.0
        myLabel.layer.borderColor = UIColor.gray.cgColor
        myLabel.layer.cornerRadius = 10.0
        
        // add the label to the view.
        self.view.addSubview(myLabel)
        self.navigationController?.navigationBar.addSubview(myLabel)
        
        // the UIViewController comes with a navigationItem property
        // this will automatically be initialized for you if when the
        // view controller is added to a navigation controller's stack
        // you just need to set the titleView to be the search bar
        navigationItem.titleView = searchBar
        
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            }
        )
    }
    
    // called whenever text is changed.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        myLabel.text = searchText
    }
    
    // called when cancel button is clicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        searchBar.text = ""
        let searchTerm = searchBar.text ?? ""
        
        Business.searchWithTerm(term: searchTerm, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
        })
    }
    
    // called when search button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // myLabel.text = "Searching"
        //searchBar.text = ""
        
        
        let searchTerm = searchBar.text ?? ""
        
        Business.searchWithTerm(term: searchTerm, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let navigationController = segue.destination as! UINavigationController
        // Pass the selected object to the new view controller.
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        let categories = filters["categories"] as? [String]
        Business.searchWithTerm(term: "Restaurants", sort: nil, categories: categories, deals: nil) { (businesses, error) in
            self.businesses = businesses
            self.tableView.reloadData()
        }
    }
}
