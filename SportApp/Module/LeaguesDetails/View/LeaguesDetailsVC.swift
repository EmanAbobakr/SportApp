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
    func reloadLatestCollectionData()
    func reloadupComingCollectionData()
    func reloadTeamsCollectionData()
    func setupHeartIcon(flag: Bool)
}

class LeaguesDetailsVC: UITableViewController {

    let indicator = UIActivityIndicatorView(style: .large)
    var myPresenter = RouterDetails.presenter
    var resultView :[String]!
    
    
    
    
    @IBAction func favouriteIconAction(_ sender: UIBarButtonItem) {
        
        if sender.tintColor == UIColor.red{
//            print("convert red to gray")
//            sender.tintColor = UIColor.lightGray
            print("sandra1")
            myPresenter.deleteFavouriteLeague()
           
        }
        else{
//            print("convert red to red")
//            sender.tintColor = UIColor.red
             print("1-leagues details vc call the add func from presenter")
             myPresenter.addFavouriteLeague()
        }
        //coredataManager.storeFavouriteLeague(data: myPresenter.leagueData)
        
    }
    
    @IBOutlet weak var favouriteIcon: UIBarButtonItem!
    
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var latestCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("league's id from vc \(myPresenter.leagueData.id)")
        setupTableView()
        setupCollectionsView()
        animator()
        getData()
    
    
    //for just now
    myPresenter.getEvents()
    //myPresenter.printLeagueID()
        //myPresenter.printLeague()
    }
    
    func animator(){
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
        
    }
       
       func getData(){
           myPresenter.attachView(view: self)
           myPresenter.getTeams()
           //print("In Leagues VC\(myPresenter.leagueName ?? "")")
        print("now i will check if this leagues favourite-call the fn from presenter")
        myPresenter.checkIfFavourite()
       }
       
       func setupTableView()
       {
           self.tableView.delegate = self
           self.tableView.dataSource = self
       }
    
        func setupCollectionsView() {
            
            upcomingCollectionView.delegate = self
            upcomingCollectionView.dataSource = self
            
            latestCollectionView.delegate = self
            latestCollectionView.dataSource = self
            
            teamsCollectionView.delegate = self
            teamsCollectionView.dataSource = self
                                  
        }
    
    
}

extension LeaguesDetailsVC : LeaguesDetailsProtocol {
    
    func stopAnimator() {
        indicator.stopAnimating()
    }
       
    func reloadLatestCollectionData() {
        
    }
    
    func reloadupComingCollectionData() {
        
    }
    
    
    func reloadTeamsCollectionData() {
        
        resultView = myPresenter.teamsResult.map({ (item) -> String in
            return item.strTeamBadge
        })
        //print(resultView ?? "no data")
        self.tableView.reloadData()
        self.teamsCollectionView.reloadData()
        
        //self.teamsCollectionView.reloadData()
    }
    
    func setupHeartIcon(flag: Bool){
        if flag{
            
            favouriteIcon.tintColor = UIColor.red
        }
        else{
            favouriteIcon.tintColor = UIColor.lightGray
        }
    }
    
    
}

extension LeaguesDetailsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.upcomingCollectionView{
            print("I am an upcoming count")
            return 10
        }
            
        else if collectionView == self.latestCollectionView{
            print("I am a latest count")
            return 7
        }
        
        else{
            print("I am a team count")
            return resultView?.count ?? 0
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == upcomingCollectionView{
            print("I am an upcoming cell")
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCellID", for: indexPath) as! UpcomingCell
            
            return cellA
        }
            
        else if collectionView == self.latestCollectionView{
            print("I am a latest cell")
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestCellID", for: indexPath) as! LatestCell
            
            return cellB
        }
            
            
        else{
            print("I am a team cell")

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCellID", for: indexPath) as! TeamsCell
            
            
            let resizingProcessor = ResizingImageProcessor(referenceSize: (cell.teamImage.frame.size), mode: .aspectFit)
            let url = URL(string: resultView[indexPath.row])
            cell.teamImage.kf.setImage(with: url, options: [.processor(resizingProcessor)])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let teamsDetailsVC = self.storyboard?.instantiateViewController(identifier: "TeamDetailsVC") as! TeamDetailsVC
        
        if collectionView == teamsCollectionView {
            teamsDetailsVC.modalPresentationStyle = .fullScreen
            myPresenter.setSelectedTeam(selectedTeamIndex: indexPath.row)
            self.present(teamsDetailsVC, animated: true, completion: nil)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width/3 - 3 , height: view.frame.size.height/4 - 4 )
        
        
    }
    
    
}

//extension LeaguesDetailsVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
//
//}


