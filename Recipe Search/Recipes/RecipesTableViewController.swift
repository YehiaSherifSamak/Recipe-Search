//
//  RecipesTableViewController.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/5/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import UIKit

protocol RecipesTableView: class {
    var isFiltering: Bool {get}
    func updateTableView()
    func makeConnectionErrorAlert()
    func thereIsNoRecipesErrorAlert()
}

class RecipesTableViewController: UITableViewController {
    
    private let mainSearchController = UISearchController(searchResultsController: nil)
    
    var presenter: RecipeTableViewPresenter!
    private var fetchingMore: Bool = false
    private var startEditing: Bool = true
    
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
        return presenter.numberOfCells
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell()
        if(presenter.isSearching){
            cell = tableView.dequeueReusableCell(withIdentifier: "search_history_cell_ID", for: indexPath)
            presenter.configure(cell: cell as! SearchHistoryTableViewCell, forRow: indexPath.row)
            
        }else{
             cell = tableView.dequeueReusableCell(withIdentifier: "recipe_cell_ID", for: indexPath)
            presenter.configure(cell: cell as! RecipeTableViewCell, forRow: indexPath.row)

        }
        return cell
    }
    
    // MARK: - Setting Up UI Elements
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
    
    
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if presenter.isSearching{
            self.showSpinner()
        }
        presenter.didSelect(row: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: nil)
    }
}

extension RecipesTableViewController: UISearchResultsUpdating{
    
    var isSearchBarEmpty: Bool {
        return mainSearchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return mainSearchController.isActive && !isSearchBarEmpty
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if(startEditing){
            presenter.whileSearching(text: searchController.searchBar.text)
        }
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        startEditing = true
    }
    
}
extension RecipesTableViewController: UISearchBarDelegate{

    //MARK: - Serching and Adding elements
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
       
        if let text = searchBar.text{
            self.showSpinner()
            presenter.searchForRecipes(for: text)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        startEditing = false
        presenter.cancelButtonClicked()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let offsetY = scrollView.contentOffset.y
           let contentHeight = scrollView.contentSize.height
           if offsetY > contentHeight - scrollView.frame.height && !fetchingMore{
               presenter.requestMoreRecipes()
               fetchingMore = true
           }
       }
}
extension RecipesTableViewController: RecipesTableView{
    
    func backToNormalState(){
        self.removeSpinner()
        fetchingMore = false
    }
    
    func updateTableView() {
        backToNormalState()
        self.tableView.reloadData()
    }
    
    func makeConnectionErrorAlert() {
        backToNormalState()
        self.makeAnAlert(title: "Error", message: "Please Check Your Internet Connection")
    }
    
    func thereIsNoRecipesErrorAlert(){
        backToNormalState()
        self.makeAnAlert(title: "No Recipes", message: "There is No Recipes with this keyword")
    }
    
    
}
