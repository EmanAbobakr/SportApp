//
//  FavouritesVC.swift
//  SportApp
//
//  Created by EmyAbobakr on 1/28/22.
//  Copyright © 2022 EmyAbobakr. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class FavouritesVC: UITableViewController {
    
    var favourites : [NSManagedObject]! = []
    var coredataManager : CoredataManagerVSFavourites = CoredataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        favourites = coredataManager.fetchFavouriteLeagues(fetchedData: &favourites)
        setupTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        favourites = coredataManager.fetchFavouriteLeagues(fetchedData: &favourites)

        tableView.reloadData()
    }
    
    func setupTableView()
    {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favourites?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCellID", for: indexPath) as! LeagueCell

        // Configure the cell...
        //cell.myLabel1.text = myArr?[indexPath.row].value(forKey: "title") as? String
        cell.leagueNameText.text = favourites[indexPath.row].value(forKey: "leagueName") as? String
        let url = URL(string: (favourites[indexPath.row].value(forKey: "leagueImgURL") as? String)!)
        cell.leagueImg.kf.setImage(with: url)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete)
        {
            coredataManager.deleteFavouriteLeague(deletedData: favourites[indexPath.row])
            favourites.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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
