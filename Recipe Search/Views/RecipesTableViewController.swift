//
//  RecipesTableViewController.swift
//  Recipe Search
//
//  Created by Yehia Samak on 3/5/20.
//  Copyright © 2020 Yehia Samak. All rights reserved.
//

import UIKit



class RecipesTableViewController: UITableViewController {
    
    let mainSearchController = UISearchController(searchResultsController: nil)
    var presenter: RecipeTableViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RecipeTableViewPresenterClass(view: self)
        self.clearsSelectionOnViewWillAppear = true
        let mainSearchBar = self.mainSearchController.searchBar
        mainSearchBar.delegate = self
        settingUpSearchBar()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRecipes()
    }
    
   

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipe_cell_ID", for: indexPath) as! RecipeTableViewCell
        cell.fillCellData(recipe: presenter.getRecipe(at: indexPath.row))
        return cell
    }
    
    func settingUpSearchBar(){
        mainSearchController.searchResultsUpdater = self
        mainSearchController.obscuresBackgroundDuringPresentation = false
        mainSearchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = mainSearchController
        definesPresentationContext = true
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RecipesTableViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
       // let searchBar: UISearchBar = searchController.searchBar
        //print("")
      
    }
  
}
extension RecipesTableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text{
            presenter.searchForRecipes(query: text) {[weak self] (success) in
                if(success){
                    self?.tableView.reloadData()
                }
            }
        }
        //RecipeTableViewPresenter.searchForRecipes(query: searchBar.text!)
        
    }
}
