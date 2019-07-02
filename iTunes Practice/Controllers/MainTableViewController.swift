//
//  MainTableViewController.swift
//  iTunes Practice
//
//  Created by Michael Tseitlin on 6/29/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var itunesMusic: ItunesMusic?    
    private var searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - UIMethods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.setEmptyView(title: "There will be a list of music.", result: nil, message: nil)
        setupSearchController()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itunesMusic?.results?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        guard let result = itunesMusic?.results?[indexPath.row] else { return cell}
        guard let imageUrl = result.artworkUrl100 else { return cell}
        
        cell.config(imageUrl: imageUrl, music: result)
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let result = itunesMusic?.results?[indexPath.row] else { return }
        
        guard let destination = segue.destination as? DetailViewController else { return }
        destination.music = result
        destination.title = result.artistName
    }
}

// MARK: - Work with Search Controller

extension MainTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchString = searchController.searchBar.text else { return }
        
        let updatingString = searchString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil).lowercased()
        
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
    
    private func setupSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Let's find artist!"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

