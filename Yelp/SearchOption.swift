//
//  SearchOption.swift
//  Yelp
//
//  Created by Kumawat, Diwakar on 4/10/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import Foundation

class SearchOption: NSObject {
    let value: Any?
    let title: String?
    let parents: [String]?
    var isOn: Bool = false
    
    init(value: Any?, title: String) {
        self.value = value
        self.title = title
        self.parents = [String]()
    }
    
    init(value: Any?, title: String, isOn: Bool) {
        self.value = value
        self.title = title
        self.isOn = isOn
        self.parents = [String]()
    }
    
    init(category: NSDictionary) {
        self.value = category["alias"] as? String
        self.title = category["title"] as? String
        self.parents = category["parents"] as? [String]
    }
}
