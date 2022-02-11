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

struct UpcomingResultView{
    var name : String?
    var date : String?
    var time : String?
}

struct LatestResultView{
    var firstTeam : String?
    var secondTeam : String?
    var firstScore : String?
    var secondScore : String?
    var date : String?
    var time : String?
}


class LeaguesDetailsVC: UITableViewController {

    @IBAction func favouriteIconAction(_ sender: UIBarButtonItem) {
        
        if sender.tintColor == UIColor.red{
            myPresenter.deleteFavouriteLeague()
           
        }
        else{
             myPresenter.addFavouriteLeague()
        }
        
    }
    
    @IBOutlet weak var favouriteIcon: UIBarButtonItem!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var latestCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    let indicator = UIActivityIndicatorView(style: .large)
    var myPresenter = RouterDetails.presenter
    var upcomingResultView : [UpcomingResultView]!
    var latestResultView : [LatestResultView]!
    var teamsResultView :[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        animator()
        setupTableView()
        setupCollectionsView()
        getData()
        sleep(2)
        getEventsData()
    
    
    //for just now
    //myPresenter.getEvents()
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
        myPresenter.checkIfFavourite()
       }
    
    func getEventsData(){
        myPresenter.getEvents()
    }
       
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setupCollectionsView(){
            
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
       
    
    func reloadupComingCollectionData() {
        upcomingResultView = myPresenter.upcomingResult.map({ (item) -> UpcomingResultView in
            return UpcomingResultView(name: item.strEvent, date: item.dateEvent, time: item.strTime)
        })
        self.tableView.reloadData()
        self.upcomingCollectionView.reloadData()
    }
    
    func reloadLatestCollectionData() {
        latestResultView = myPresenter.latestResult.map({ (item) -> LatestResultView in
            return LatestResultView(firstTeam: item.strHomeTeam, secondTeam: item.strAwayTeam, firstScore: item.intHomeScore, secondScore: item.intAwayScore, date: item.dateEvent, time: item.strTime)
        })
        self.tableView.reloadData()
        self.latestCollectionView.reloadData()
    }
    
    func reloadTeamsCollectionData() {
        
        teamsResultView = myPresenter.teamsResult.map({ (item) -> String in
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
            return upcomingResultView?.count ?? 0
        }
            
        else if collectionView == self.latestCollectionView{
            print("I am a latest count")
            return latestResultView?.count ?? 0
        }
        
        else{
            print("I am a team count")
            return teamsResultView?.count ?? 0
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == upcomingCollectionView{
            print("I am an upcoming cell")
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCellID", for: indexPath) as! UpcomingCell
            cellA.eventName.text = upcomingResultView[indexPath.row].name
            cellA.eventDate.text = upcomingResultView[indexPath.row].date
            cellA.eventTime.text = upcomingResultView[indexPath.row].time
            
            return cellA
        }
            
        else if collectionView == latestCollectionView{
            print("I am a latest cell")
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestCellID", for: indexPath) as! LatestCell
            cellB.teams.text = (latestResultView[indexPath.row].firstTeam ?? "") + " vs " + (latestResultView[indexPath.row].secondTeam ?? "")
            cellB.scores.text = (latestResultView[indexPath.row].firstScore ?? "") + " : " + (latestResultView[indexPath.row].secondScore ?? "")
            cellB.date.text = latestResultView[indexPath.row].date ?? ""
            cellB.time.text = latestResultView[indexPath.row].time ?? ""

            return cellB
        }
            
            
        else{
            print("I am a team cell")

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCellID", for: indexPath) as! TeamsCell
            
            
            let resizingProcessor = ResizingImageProcessor(referenceSize: (cell.teamImage.frame.size), mode: .aspectFill)
            let url = URL(string: teamsResultView[indexPath.row])
            cell.teamImage.kf.setImage(with: url, options: [.processor(resizingProcessor)])
            
            cell.teamImage.layer.cornerRadius = 110 / 2
            
            cell.teamImage.layer.cornerRadius = 110 / 2
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamsCollectionView{
            let teamsDetailsVC = self.storyboard?.instantiateViewController(identifier: "TeamDetailsVC") as! TeamDetailsVC
            
            if collectionView == teamsCollectionView {
                teamsDetailsVC.modalPresentationStyle = .fullScreen
                myPresenter.setSelectedTeam(selectedTeamIndex: indexPath.row)
                self.present(teamsDetailsVC, animated: true, completion: nil)
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (view.frame.size.width - 30) / 2 , height: view.frame.size.width / 2 )
        
        
    }
    
    
}

//extension LeaguesDetailsVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
//
//}


