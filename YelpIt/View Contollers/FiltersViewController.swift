//
//  FiltersViewController.swift
//  YelpIt
//
//  Created by Sudipta Bhowmik on 1/26/18.
//  Copyright © 2018 Sudipta Bhowmik. All rights reserved.
//

import UIKit


protocol FiltersViewControllerDelegate {
    //Format - the thing that calls the delegate is the name of the protocol - FiltersViewController. Parameters are the calling entity - filtersViewController & the object we are wanting to pass - didUpdateFilters is the named parameter, filters is the local variable & it is of type dictionary which has String as key
    func searchWithFilters(sort: YelpSortMode, distance: String?, hasDeals: Bool, categories: [String]? )
    
    
}
var searchFilter : SearchFilter = SearchFilter()

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate : FiltersViewControllerDelegate?
    
    
    
    
    struct CellExpansionType {
        static let ExpansionCellShowAllText = "Show All"
        static let ExpansionCellShowLessText = "Show Less"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate  = self
        tableView.estimatedRowHeight = 100
        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearchButton(_ sender: UIBarButtonItem) {
        
        delegate?.searchWithFilters(sort: searchFilter.getSortMode(), distance: searchFilter.getDistance(), hasDeals: searchFilter.getHasDeals(), categories: searchFilter.getCategories())
        
        dismiss(animated: true, completion: nil)
        
    }
    
    // MARK - TableView Delegate & DataSource Methods
    //================================================
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return self.searchFilters.filters.count
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchFilter.filterSections[section].filterTitle
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchFilter.filterSections[section].numberOfFilters
        /*if self.searchFilters.filters[section].isExpanded {
            //return all items
            return self.searchFilters.filters[section].filterItems.count
        } else {
            //return the default number of items to be displayed
            return self.searchFilters.filters[section].numItemsDisplayedDefault
        }*/
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
        if let selectedCell = tableView.cellForRow(at: indexPath) as? OptionCell {
            optionCellTapped(sender: selectedCell, indexPath: indexPath)
        } else if let selectedCell = tableView.cellForRow(at: indexPath) as? ExpansionCell {
                expansionCellTapped(sender : selectedCell, indexPath : indexPath)
        }
    }
    
    func optionCellTapped(sender : OptionCell, indexPath: IndexPath) {
        //If cell was tapped when menu was expanded, mark this cell item as selected
        //Also add it to the selected options array
        let section = indexPath.section
        let rowIndex = indexPath.row
        if (searchFilter.filterSections[section].isExpanded) {
            if !(searchFilter.filterSections[section].selectedFilters?.contains(rowIndex))! {
                searchFilter.filterSections[section].selectedFilters?[0] = rowIndex
                
            }
        }
        
        searchFilter.filterSections[section].isExpanded = !(searchFilter.filterSections[section].isExpanded)
        //tableView.reloadSections(IndexSet(indexPath), with: .automatic)
        tableView.reloadData()
        
    }
    
    func switchCellTapped(sender : ExpansionCell, indexPath: IndexPath) {
        
    }
    
    func expansionCellTapped(sender : ExpansionCell, indexPath: IndexPath) {
        searchFilter.filterSections[indexPath.section].isExpanded = !(searchFilter.filterSections[indexPath.section].isExpanded)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filterSection = searchFilter.filterSections[indexPath.section]
        let tableViewCell : UITableViewCell
        
        switch (filterSection.sectionIdentifier) {
        case .Deals:
            tableViewCell = getDequeuedSwitchCell(filterSection : filterSection, indexPath : indexPath)
        case .Distance:
            tableViewCell = getDequeuedOptionCell(filterSection : filterSection, indexPath : indexPath)
        case .SortBy:
            tableViewCell = getDequeuedOptionCell(filterSection : filterSection, indexPath : indexPath)
        case .Category:
            if (indexPath.row == filterSection.numberOfFilters - 1) {
                //The last row is of Expansion cell type
                tableViewCell = getDequeuedExpansionCell(filterSection : filterSection)
                
            } else {
                tableViewCell = getDequeuedSwitchCell(filterSection : filterSection, indexPath : indexPath)
            }
            
            //print(tableView.numberOfRows(inSection: indexPath.section)  - tableView.visibleCells.count )
            
            
        }
        
        return tableViewCell
    }
    

    
    func getDequeuedSwitchCell(filterSection : FilterSection, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchCell
        cell.switchCellDelegate = self
        cell.switchLabel.text = filterSection.filterItems[indexPath.row].displayName
        //cell.catSwitch.isOn = filterSection.filterItems[indexPath.row].isSelected
        
        cell.catSwitch.isOn = filterSection.selectedFilters!.contains(indexPath.row)
        
        return cell
    }
   
    func getDequeuedOptionCell(filterSection : FilterSection, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell") as! OptionCell
        
        let selectedItem = filterSection.selectedFilters?[0]
        if (filterSection.isExpanded) {
            cell.optionLabel.text = filterSection.filterItems[indexPath.row].displayName
            
            if (indexPath.row == selectedItem) {
                cell.cellState = OptionCell.CellState.Checked
            } else {
                cell.cellState = OptionCell.CellState.Unchecked
            }
            
        } else {
            cell.optionLabel.text = filterSection.filterItems[selectedItem!].displayName
            cell.cellState = OptionCell.CellState.Collapsed
        }
        return cell
    }
    
    func getDequeuedExpansionCell(filterSection : FilterSection) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expansionCell") as! ExpansionCell
        
            cell.expansionLabel.text = filterSection.isExpanded ? CellExpansionType.ExpansionCellShowLessText : CellExpansionType.ExpansionCellShowAllText

        
        return cell
    }
    
    // MARK - Delegate implementation
    //================================
    func switchCell(switchCell: SwitchCell, switchOn: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)
        let rowId = indexPath?.row
        let sectionId = indexPath?.section
        
        if (switchOn) {
            //Add this row index to selectedFilters array
            searchFilter.filterSections[sectionId!].selectedFilters?.append(rowId!)
            searchFilter.filterSections[sectionId!].selectedFilters?.sort()
        } else {
            //Remove this row index from selectedFilters array
            searchFilter.filterSections[sectionId!].selectedFilters = searchFilter.filterSections[sectionId!].selectedFilters?.filter{ $0 != rowId }
        }
        
        print(searchFilter.filterSections[sectionId!].selectedFilters?.count != 0)
        
        //Save the bool value for indexpath here
    }
    
    func yelpCats()->[[String:String]] {
        return [["name" : "Afghan", "code" : "afghani"],
                ["name" : "African", "code" : "african"],
                ["name" : "American, new", "code" : "newamerican"]
        ]
    }

}
