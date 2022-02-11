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
import Network

protocol FavouritesProtocol {
    
}

struct FavouritesResultView {
    
}

class FavouritesVC: UITableViewController, FavouritesProtocol {
   
    
    //new
    var myPresenter = Routerfavourites.presenter
    
    //end new
    
    //old
    var favourites : [NSManagedObject]! = []
    var coredataManager : CoredataManagerVSFavourites = CoredataManager()
    //end old

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let monitor = NWPathMonitor()

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
                //return true
            } else {
                print("No connection.")
                //return false
            }

            //print(path.isExpensive)
        }

        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        //new
        
        //setupTableView()
        //getData()
        
        //end new
        
        
        title = "Favourites"
        
        //old
        favourites = coredataManager.fetchFavouriteLeagues(fetchedData: &favourites)
        //end old
        setupTableView()
        getData()

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
    
    //getData
    func getData(){
        //attachview func
        myPresenter.attachView(view: self)
        //getdata func
        myPresenter.fetchFavouritesData()
    }

}

extension FavouritesVC{
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
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            myPresenter.checkInternetConnection()
            //Alert start
            let alert1 = UIAlertController(title: "Unable to connect", message: "Please check your Internet connection ", preferredStyle: .actionSheet)
//            alert1.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
//                print("Ok is pressed")
//            }))
            alert1.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
                print("Cancel is pressed")
            }))
            //alert1.addAction(UIAlertAction(title: "what", style: .destructive, handler: nil))
            //Alert end
            
            self.present(alert1, animated: true, completion: nil)
//            //start navigate
//                let detailsVC = self.storyboard?.instantiateViewController(identifier: "LeaguesDetailsVCID") as! LeaguesDetailsVC
//                myPresenter.setLeagueData(leagueData : favourites[indexPath.row])
//                detailsVC.modalPresentationStyle = .fullScreen
//                //resultView[indexPath.row]
//                self.present(detailsVC, animated: true, completion: nil)
//            //end navigate
            }
    
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
        }
        
}
