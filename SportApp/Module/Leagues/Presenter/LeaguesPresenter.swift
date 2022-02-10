//
//  LeaguesPresenter.swift
//  SportApp
//
//  Created by EmyAbobakr on 2/1/22.
//  Copyright © 2022 EmyAbobakr. All rights reserved.
//

import Foundation

class LeaguesPresenter
{
    var leaguesResult : [League]!
    //let leaguesAPI = APILeaguesService()
    let leaguesAPI : APIServiceProtocol = APIService()
    var myView : LeaguesProtocol!
    var leagueData : LeaguesResultView!
    var sportName : String!
    //var leagueName : String!
    
    
    func attachView(view: LeaguesProtocol)
    {
        self.myView = view
    }
    
    func getLeagues()
    {
        leaguesAPI.fetchDataFromAPI(url: (Links.leagues.rawValue + sportName), param: nil, responseClass: LeaguesResult.self) { [weak self](leaguesResult) in
            self?.leaguesResult = leaguesResult!.countrys
            DispatchQueue.main.async {
                self?.myView.reloadTableData()
                self?.myView.stopAnimator()
            }
        }
    }
//    func setLeagueName(leagueName : String){
//        RouterDetails.presenter.leagueName = leagueName
//        print("hello from set name in leagues presenter \(String(describing: RouterDetails.presenter.leagueName))")
//
//    }
//
//    func setLeagueID(leagueID : String){
//        RouterDetails.presenter.leagueID = leagueID
//        print("Hello from set ID in leagues presenter\(RouterDetails.presenter.leagueID)")
//    }
    
    func setLeagueData(leagueData : LeaguesResultView){
        RouterDetails.presenter.leagueData = leagueData
    }
    
    
}
