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
    var leagueID : String!
    var dataAPI : APIServiceProtocol = APIService()
    var eventsResult : [Event]!
    var upcomingResult : [Event]!
    var latest : [Event]!
    var teamsResult : [Team]!
    var myView : LeaguesDetailsProtocol!
    
    func attachView(view: LeaguesDetailsProtocol)
    {
        self.myView = view
    }
    
    func getEvents()
    {
        dataAPI.fetchDataFromAPI(url: (Links.events.rawValue + leagueID), param: nil, responseClass: EventsResult.self) { [weak self](eventsResult) in
            self?.eventsResult = eventsResult?.events
            DispatchQueue.main.async {
                self?.myView.reloadTableData()
                self?.myView.stopAnimator()
                self?.filterEventsBasedOnDate(eventsResult: self?.eventsResult)
            }
        }
//        if var er = eventsResult{
//            for i in eventsResult
//            {
//                //print("Fetched events data\(eventsResult[0].strStatus)")
//                print("Fetched events data\(i.strStatus)")
//            }
//        }
//        else{
//            print("Fetched events data (Empty)")
//        }
//
    }
    
    func getTeams()
    {
        dataAPI.fetchDataFromAPI(url: (Links.teams.rawValue), param: ["l":leagueName ?? ""], responseClass: TeamsResult.self) { [weak self](teamsResult) in
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
    
    func filterEventsBasedOnDate(eventsResult: [Event]!){
        for item in eventsResult{
            var apiDate = item.strTimestamp
            apiDate = apiDate!.replacingOccurrences(of: "T", with: " ")
            apiDate = apiDate!.replacingOccurrences(of: "+00:00", with: "+0000")

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ssZ"
            dateFormatter.timeZone = TimeZone(identifier: "GMT")
            var currentDate = dateFormatter.string(from: Date())

            if apiDate! >= currentDate{
                //print("Upcoming")
                upcomingResult.append(item)
            }
            else if apiDate! < currentDate{
                //print("Latest")
                latest.append(item)
            }
        }
        print("count of all \(eventsResult.count)")
        print("upcoming count \(upcomingResult.count)")
        print("latest count \(latest.count)")
    }
    
//    func printLeagueID(){
//        print("Hello from print league ID in leagues details presenter \(leagueID)")
//    }
    func setSelectedTeam(selectedTeamIndex: Int) {
        let team = teamsResult[selectedTeamIndex]
        RouterTeamDetails.presenter.selectedTeam = team
        
    }
}
