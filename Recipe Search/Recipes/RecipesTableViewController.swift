//
//  RecipesTableViewController.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/5/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import UIKit

protocol RecipesTableView: class {
    func updateTableView()
    func makeConnectionErrorAlert()
}

class RecipesTableViewController: UITableViewController {
    
    private let mainSearchController = UISearchController(searchResultsController: nil)
    var presenter: RecipeTableViewPresenter!
    private var fetchingMore: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let configurator = RecipesConfiguratorClass()
        configurator.configure(recipesTableViewController: self)
        self.clearsSelectionOnViewWillAppear = true
        let mainSearchBar = self.mainSearchController.searchBar
        mainSearchBar.delegate = self
        settingUpSearchBar()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRecipes
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipe_cell_ID", for: indexPath) as! RecipeTableViewCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
    
    func settingUpSearchBar(){
        mainSearchController.searchResultsUpdater = self
        mainSearchController.obscuresBackgroundDuringPresentation = false
        mainSearchController.searchBar.placeholder = "Search Recipes"
        navigationItem.searchController = mainSearchController
        definesPresentationContext = true
    }
    
    func makeAnAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "try agin", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height && !fetchingMore{
            presenter.requestMoreRecipes()
            fetchingMore = true
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: nil)
    }
}


extension RecipesTableViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        
    }
    
}
extension RecipesTableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text{
            presenter.searchForRecipes(for: text)
        }
        
    }
}
extension RecipesTableViewController: RecipesTableView{
    
    func updateTableView() {
        fetchingMore = false
        self.tableView.reloadData()
    }
    
    func makeConnectionErrorAlert() {
        fetchingMore = false
        self.makeAnAlert(title: "Error", message: "Please Check Your Internet Connection")
    }
    
}
