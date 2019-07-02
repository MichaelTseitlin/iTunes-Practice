//
//  SearchController.swift
//  iTunes Practice
//
//  Created by Michael Tseitlin on 7/1/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UISearchResultsUpdating {
    
    var itunesMusic: ItunesMusic?
    var tableView: UITableView!
    var searchController = UISearchController(searchResultsController: nil)
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text!.lowercased()
        
        let updatingString = searchString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        
        let url = "https://itunes.apple.com/search?term=\(updatingString)"
        
        NetworkManager.fetchRequest(url: url) { itunesMusic in
            self.itunesMusic = itunesMusic
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                
                if searchString.isEmpty {
                    self.tableView.setEmptyView(title: "Choose artist for display a tracklist.", result: nil, message: nil)
                } else if self.itunesMusic == nil || self.itunesMusic?.results?.count == 0 {
                    self.tableView.setEmptyView(title: "Not found", result: "Search '\(searchString)' did not return any results.", message: "Try to enter something else.")
                } else {
                    self.tableView.restore()
                }
                
            }
        }
    }
    
    func setupSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Let's find artist!"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}
