//
//  LeaguesDetailsPresenter.swift
//  SportApp
//
//  Created by EmyAbobakr on 2/5/22.
//  Copyright © 2022 EmyAbobakr. All rights reserved.
//

import Foundation

class LeaguesDetailsPresenter {
    var leagueName : String!
    var teamsAPI : APIServiceProtocol = APIService()
    var teamsResult : [Team]!
    var myView : LeaguesDetailsProtocol!
    
    func attachView(view: LeaguesDetailsProtocol)
    {
        self.myView = view
    }
    
    func getTeams()
    {
        //let preparedLeagueName = prepareLeagueName(leagueName: leagueName)
        //print(preparedLeagueName)
        //print(Links.teams.rawValue + preparedLeagueName)
        teamsAPI.fetchDataFromAPI(url: (Links.teams.rawValue), param: ["l":leagueName ?? ""], responseClass: TeamsResult.self) { [weak self](teamsResult) in
            self?.teamsResult = teamsResult?.teams
            DispatchQueue.main.async {
                self?.myView.reloadTableData()
                self?.myView.stopAnimator()
            }
        }
    }
    func prepareLeagueName(leagueName: String) -> String {
        return leagueName.replacingOccurrences(of: " ", with: "_")
    }
    func setSelectedTeam(selectedTeamIndex: Int) {
        let team = teamsResult[selectedTeamIndex]
        RouterTeamDetails.presenter.selectedTeam = team
        
    }
}
