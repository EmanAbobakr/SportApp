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
    
    
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    
override func viewDidLoad() {
        super.viewDidLoad()
    //title = "League's Details"
        animator()
        getData()
        setupTableView()
        setupCollectionsView()
    //for just now
    //myPresenter.getEvents()
    //myPresenter.printLeagueID()
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
    
        func setupCollectionsView() {
            teamsCollectionView.delegate = self
            teamsCollectionView.dataSource = self
            upcomingCollectionView.delegate = self
            upcomingCollectionView.dataSource = self
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
        
        //self.teamsCollectionView.reloadData()
    }
}

extension LeaguesDetailsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return resultView?.count ?? 0

        //return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCellID", for: indexPath) as! TeamsCell
        
        
        let resizingProcessor = ResizingImageProcessor(referenceSize: (cell.teamImage.frame.size), mode: .aspectFit)
        let url = URL(string: resultView[indexPath.row])
        cell.teamImage.kf.setImage(with: url, options: [.processor(resizingProcessor)])
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let teamsDetailsVC = self.storyboard?.instantiateViewController(identifier: "TeamDetailsVC") as! TeamDetailsVC
        //resultView[indexPath.row]
        teamsDetailsVC.modalPresentationStyle = .fullScreen
        myPresenter.setSelectedTeam(selectedTeamIndex: indexPath.row)
        self.present(teamsDetailsVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width/3 - 3 , height: view.frame.size.height/4 - 4 )
        
        
    }
    
    
}


