//
//  LeaguesVCTableViewController.swift
//  SportApp
//
//  Created by EmyAbobakr on 2/1/22.
//  Copyright © 2022 EmyAbobakr. All rights reserved.
//

import UIKit
import Kingfisher

protocol LeaguesProtocol {
    func stopAnimator()
    func reloadTableData()
}

struct LeaguesResultView
{
    var name: String
    var imageURL : String
    var ytURL : String
}

class LeaguesVC: UITableViewController {

    let indicator = UIActivityIndicatorView(style: .large)
    var myPresenter = RouterClass.presenter
    var resultView :[LeaguesResultView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Leagues"
        setupTableView()
        //myPresenter?.getLeagues()
        animator()
        getData()
    }
    
    
    func animator()
    {
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
            
    }
    func getData()
    {
        myPresenter.attachView(view: self)
        myPresenter.getLeagues()
        print("In Leagues VC\(myPresenter.sportName ?? "")")
        
        
    }
    
    func setupTableView()
    {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    

}

extension LeaguesVC: LeaguesProtocol
{
    func stopAnimator() {
        indicator.stopAnimating()
    }
    
    func reloadTableData() {
        
        resultView = myPresenter.leaguesResult.map({ (item) -> LeaguesResultView in
            return LeaguesResultView(name: item.strLeague ?? " ", imageURL: item.strBadge ?? " ", ytURL: item.strYoutube ?? " ")
        })
 
        self.tableView.reloadData()
    }
}

extension LeaguesVC
{
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return resultView?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCellid", for: indexPath) as! LeagueCell

        // Configure the cell...
        /*
        cell.leagueImg.image = UIImage(named: "f.jpg")
        cell.LeagueNameText.text = "Helloooo"
        */
        cell.LeagueNameText.text = resultView[indexPath.row].name
        let url = URL(string: resultView[indexPath.row].imageURL)
        cell.imageView?.kf.setImage(with: url)
        
        return cell
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
