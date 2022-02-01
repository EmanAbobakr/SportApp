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
    var sportsAPI = APIService()
    var myView : HomeProtocol!
    
    func attachView(view: HomeProtocol)
    {
        self.myView = view
    }
    
    func getSports()
    {
        sportsAPI.fetchResult { [weak self](sportsResult) in
            self?.sportsResult = sportsResult!.sports
            DispatchQueue.main.async {
                self?.myView.reloadCollectionData()
                self?.myView.stopAnimator()
            }
        }
    }
}
