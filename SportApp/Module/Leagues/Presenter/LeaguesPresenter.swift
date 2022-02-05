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
    var sportName : String!
    
    
    func attachView(view: LeaguesProtocol)
    {
        self.myView = view
    }
    
    func getLeagues()
    {
        leaguesAPI.fetchDataFromAPI(url: (Links.leagues.rawValue + sportName), responseClass: LeaguesResult.self) { [weak self](leaguesResult) in
            self?.leaguesResult = leaguesResult!.countrys
            DispatchQueue.main.async {
                self?.myView.reloadTableData()
                self?.myView.stopAnimator()
            }
        }
        
        
    }
}
