//
//  SearchFilter.swift
//  Yelp
//
//  Created by Kumawat, Diwakar on 4/10/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import Foundation

import UIKit

class SearchFilter: NSObject {
    let name: String?
    let options: [SearchOption]?
    var filteredOptions: [SearchOption]?
    let isExclusive: Bool?
    var showAll: Bool? {
        didSet {
            if showAll! {
                filteredOptions = options
            } else {
                filteredOptions = [SearchOption]()
                for option in options! {
                    if (option.isOn) {
                        filteredOptions?.append(option)
                    }
                }
            }
        }
    }
    
    init(name: String, isExclusive: Bool, options: [SearchOption]) {
        self.name = name
        self.isExclusive = isExclusive
        self.options = options
        if isExclusive {
            filteredOptions = [SearchOption]()
            for option in options {
                if (option.isOn) {
                    self.filteredOptions?.append(option)
                }
            }
        } else {
            filteredOptions = options
        }
        self.showAll = false
    }
    
    class func createFilters() -> [SearchFilter] {
        return [
            SearchFilter(name: "Offering a Deal", isExclusive: false, options: [
                SearchOption(value: nil, title: "Offering a Deal"),
                ]),
            SearchFilter(name: "Distance", isExclusive: true, options: [
                SearchOption(value: 0, title: "Best Match", isOn: true),
                SearchOption(value: 1, title: "0.3 miles"),
                SearchOption(value: 2, title: "1 mile"),
                SearchOption(value: 3, title: "5 miles"),
                SearchOption(value: 4, title: "20 miles"),
                ]),
            SearchFilter(name: "Sort By", isExclusive: true, options: [
                SearchOption(value: YelpSortMode.bestMatched, title: "Best Match", isOn: true),
                SearchOption(value: YelpSortMode.distance, title: "Distance"),
                SearchOption(value: YelpSortMode.highestRated, title: "Rating"),
                SearchOption(value: YelpSortMode.highestRated, title: "Most Reviewed"),
                ]),
            SearchFilter(name: "Category", isExclusive: false, options:
                yelpCategories()
            ),
        ];
    }
    
    class func yelpCategories() -> [SearchOption] {
        var options = [SearchOption]()
        
        // read categories.json from Yelp
        if let url = Bundle.main.url(forResource: "categories", withExtension: "json") {
            let data = try! Data(contentsOf: url)
            if let json = try! JSONSerialization.jsonObject(with: data, options:[]) as? [NSDictionary] {
                for dict in json {
                    let option = SearchOption(categoryDict: dict as NSDictionary)
                    if (option.parents?.contains("restaurants"))! {
                        options.append(option)
                    }
                }
            }
        }
        
        return options
    }

}
