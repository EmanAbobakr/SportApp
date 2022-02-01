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
    let leaguesAPI = APILeaguesService()
    var myView : LeaguesProtocol!
    
    func attachView(view: LeaguesProtocol)
    {
        self.myView = view
    }
    
    func getLeagues()
    {
        leaguesAPI.fetchResult { [weak self](leaguesResult) in
            self?.leaguesResult = leaguesResult!.countrys
            //print(self?.leaguesResult[0].strSport)
            DispatchQueue.main.async {
                self?.myView.reloadTableData()
                self?.myView.stopAnimator()
            }
        }
    }
}
