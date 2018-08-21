//
//  Filters.swift
//  YelpIt
//
//  Created by Sudipta Bhowmik on 1/30/18.
//  Copyright © 2018 Sudipta Bhowmik. All rights reserved.
//

import Foundation

enum FilterSectionIdentifiers : String {
    case Deals, Distance, SortBy, Category
}

class FilterItem {
    var displayName : String
    var filterValue : Any
    
    
    init(displayName : String, filterValue : Any) {
        self.displayName = displayName
        self.filterValue = filterValue
        
    }
    
    
    init(categoryItem : [String : String]/*<==== ARRAY LITERAL*/) {
        self.displayName = categoryItem["name"]!
        self.filterValue = categoryItem["code"] as Any
        
    }
}

class FilterSection {
    
    var filterTitle : String? //The name of the filter that will be displayed in the section header
    var filterKey : String //The name of the parameter to be used in the search query
    var filterItems : [FilterItem]
    var numItemsDisplayedDefault : Int
    var isExpanded : Bool
    var sectionIdentifier : FilterSectionIdentifiers //The section id to which this filterSection belongs
    
    var numberOfFilters : Int {
        var numFilters = 0
        if (sectionIdentifier == FilterSectionIdentifiers.Category) {
            //For the category section we always display an extra cell for "Show More" or "Show less"
            numFilters = self.isExpanded ? self.filterItems.count + 1 : numItemsDisplayedDefault + 1
        } else {
            numFilters = self.isExpanded ? self.filterItems.count : numItemsDisplayedDefault
        }
        return numFilters
    }
    
    var selectedFilters : [Int]?
    
    init(filterTitle : String? = nil, filterKey : String, filterItems : [FilterItem], numItemsDisplayedDefault : Int, isExpanded : Bool, selectedFilterIndex : [Int]? = [Int](), sectionIdentifier : FilterSectionIdentifiers) {
        self.filterTitle = filterTitle
        self.filterKey = filterKey
        self.filterItems = filterItems
        self.numItemsDisplayedDefault = numItemsDisplayedDefault
        self.isExpanded = isExpanded
        self.selectedFilters = selectedFilterIndex
        self.sectionIdentifier = sectionIdentifier
    }
    
    
    
}

class SearchFilter {
    //var filterTitle : String //The Title that will be displayed in the section header
    
    
    //let categories : [FilterItem] = Categories.categoryArr.map{FilterItem(category : $0)}
    
    var filterSections : [FilterSection] = [FilterSection(filterKey : "deals_filter", filterItems: [FilterItem(displayName: "Offering a deal",         filterValue :"1")],
                                     numItemsDisplayedDefault: 1,
                                     isExpanded: true,
                                     selectedFilterIndex : [],
                                     sectionIdentifier : FilterSectionIdentifiers.Deals),
                                     
                              FilterSection(filterTitle: "Distance", filterKey : "radius",
                                     filterItems: [FilterItem(displayName: "Auto", filterValue : "4800"),
                                                     FilterItem(displayName: "0.3 miles", filterValue : "480"),
                                                     FilterItem(displayName: "1 mile", filterValue : "1600"),
                                                     FilterItem(displayName: "5 miles", filterValue : "8000"),
                                                     FilterItem(displayName: "20 miles", filterValue : "32000")],
                                     numItemsDisplayedDefault: 1,
                                     isExpanded: false,
                                     selectedFilterIndex : [0],
                                     sectionIdentifier : FilterSectionIdentifiers.Distance),
                              
                              FilterSection(filterTitle: "Sort By", filterKey : "sort_by",
                                     filterItems: [FilterItem(displayName: "Best Match", filterValue : YelpSortMode.best_match),
                                                     FilterItem(displayName: "Distance", filterValue : YelpSortMode.distance),
                                                     FilterItem(displayName: "Highest Rated", filterValue : YelpSortMode.rating)],
                                     numItemsDisplayedDefault: 1,
                                     isExpanded: false,
                                     selectedFilterIndex : [0],
                                     sectionIdentifier : FilterSectionIdentifiers.SortBy),
                              
                              FilterSection(filterTitle: "Category", filterKey : "category",
                                     filterItems: Categories.categoryArr.map{FilterItem(categoryItem : $0)},//<<===See constructor of FilterItem
                                     numItemsDisplayedDefault: 5,
                                     isExpanded: false,
                                     selectedFilterIndex : [],
                                     sectionIdentifier : FilterSectionIdentifiers.Category)
                             ]
    
    func getHasDeals()->Bool {
        return (filterSections.first?.selectedFilters?.count != 0)
    }
    
    func getSortMode()->YelpSortMode {
        let index = filterSections[2].selectedFilters?.first
        return  filterSections[2].filterItems[index!].filterValue as! YelpSortMode
    }
    
    func getDistance()->String {
        let index = filterSections[1].selectedFilters?.first
        return  filterSections[1].filterItems[index!].filterValue as! String
    }
    
    func getCategories()->[String] {
        var cats : [String] = []
        if (filterSections[3].selectedFilters?.count != 0) {
            for index in filterSections[3].selectedFilters!{
                cats.append(filterSections[3].filterItems[index].filterValue as! String)
            }
        }
        return cats
    }
    
}


