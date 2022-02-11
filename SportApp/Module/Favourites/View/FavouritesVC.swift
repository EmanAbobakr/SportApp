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
    var netWorkFlag : Bool?
    //end old

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let monitor = NWPathMonitor()
        

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.netWorkFlag = true
                print("We're connected!")
                //return true
            } else {
                self.netWorkFlag = false
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
            
            let resizingProcessor = ResizingImageProcessor(referenceSize: (cell.leagueImg.frame.size), mode: .aspectFit)
            
            cell.leagueImg.kf.setImage(with: url, options: [.processor(resizingProcessor)])
            
            cell.viewCell.layer.cornerRadius = cell.viewCell.frame.height / 2
            
            cell.leagueImg.layer.cornerRadius = 110 / 2
            cell.vcDelegation = self
            
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
            if netWorkFlag!{
                
                var tempLeagueData = LeaguesResultView(id: (favourites[indexPath.row].value(forKey: "leagueId") as? String) ?? "", name: (favourites[indexPath.row].value(forKey: "leagueName") as? String) ?? "", imageURL: (favourites[indexPath.row].value(forKey: "leagueImgURL") as? String) ?? "", ytURL: (favourites[indexPath.row].value(forKey: "leagueYtuURL") as? String) ?? "")
                
                    let detailsVC = self.storyboard?.instantiateViewController(identifier: "LeaguesDetailsVCID") as! LeaguesDetailsVC
                    myPresenter.setLeagueData(leagueData : tempLeagueData)
                    detailsVC.modalPresentationStyle = .fullScreen
                    self.present(detailsVC, animated: true, completion: nil)
                
            }
            else{
                let alert1 = UIAlertController(title: "Unable to connect", message: "Please check your Internet connection ", preferredStyle: .actionSheet)

                alert1.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
                    print("Cancel is pressed")
                    
                }))
                self.present(alert1, animated: true, completion: nil)
            }
            

            }
    
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 130
        }

}

extension FavouritesVC : customCellProtocol
{
    func cell(cell: LeagueCell, didTapBtn: UIButton) {
        let rowIndex = self.tableView.indexPath(for: cell)
        //print(rowIndex)
        var yt = favourites[rowIndex![1]].value(forKey: "leagueYtuURL") as! String
        let youtubeURL = URL(string:  "https://"+yt)
        UIApplication.shared.open(youtubeURL!)
    }
}
