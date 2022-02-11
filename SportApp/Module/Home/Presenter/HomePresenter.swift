//
//  HomePresenter.swift
//  SportApp
//
//  Created by EmyAbobakr on 2/1/22.
//  Copyright © 2022 EmyAbobakr. All rights reserved.
//

import Foundation

class HomePresenter
{
    
    var sportsResult : [Sport]!
    //var sportsAPI = APIService()
    var sportsAPI : APIServiceProtocol = APIService()
    var myView : HomeProtocol!
    
    func attachView(view: HomeProtocol)
    {
        self.myView = view
    }
    
    func getSports()
    {
        sportsAPI.fetchDataFromAPI(url: Links.sports.rawValue, param: nil, responseClass: SportsResult.self) { [weak self](sportsResult, error) in
            self?.sportsResult = sportsResult!.sports
            DispatchQueue.main.async {
                self?.myView.reloadCollectionData()
                self?.myView.stopAnimator()
            }
        }
    }
    func setSportName(sportName : String){
        
        //_ = RouterClass()
        RouterClass.presenter.sportName = sportName
        
    }
}
