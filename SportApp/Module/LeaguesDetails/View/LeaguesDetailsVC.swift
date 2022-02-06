//
//  LeaguesDetailsVC.swift
//  SportApp
//
//  Created by EmyAbobakr on 2/5/22.
//  Copyright © 2022 EmyAbobakr. All rights reserved.
//

import UIKit
import Kingfisher

protocol LeaguesDetailsProtocol {
    func stopAnimator()
    func reloadTableData()
}

class LeaguesDetailsVC: UITableViewController {

    let indicator = UIActivityIndicatorView(style: .large)
    var myPresenter = RouterDetails.presenter
    var resultView :[String]!
    

    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
override func viewDidLoad() {
        super.viewDidLoad()
        animator()
        getData()
        setupTableView()
        setupCollectionView()
        //myPresenter.printLeague()
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
           myPresenter.getTeams()
           //print("In Leagues VC\(myPresenter.leagueName ?? "")")
       }
       
       func setupTableView()
       {
           self.tableView.delegate = self
           self.tableView.dataSource = self
       }
    func setupCollectionView() {
        self.teamsCollectionView.delegate = self
        self.teamsCollectionView.dataSource = self
    }
}

extension LeaguesDetailsVC : LeaguesDetailsProtocol {
    func stopAnimator() {
        indicator.stopAnimating()
    }
       
    func reloadTableData() {
        resultView = myPresenter.teamsResult.map({ (item) -> String in
            return item.strTeamBadge
        })
        //print(resultView ?? "no data")
       self.tableView.reloadData()
        self.teamsCollectionView.reloadData()
    }
}

extension LeaguesDetailsVC {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "Hello from cell"
        return cell
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
extension LeaguesDetailsVC :UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultView.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCellID", for: indexPath) as! TeamCell
        let imageURL = URL(string: resultView[indexPath.row])
        cell.teamImage.kf.setImage(with: imageURL)
        return cell
    }
    
    
}


