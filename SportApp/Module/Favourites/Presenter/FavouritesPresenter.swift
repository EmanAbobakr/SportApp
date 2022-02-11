//
//  FavouritesPresenter.swift
//  SportApp
//
//  Created by EmyAbobakr on 2/8/22.
//  Copyright © 2022 EmyAbobakr. All rights reserved.
//

import Foundation
import CoreData
import Network

class favouritesPresenter{
    var myView : FavouritesProtocol!
    var favourites : [NSManagedObject]!
    var coredataManager : CoredataManagerVSFavourites = CoredataManager()
    

    let monitor = NWPathMonitor()
    
    
    func attachView(view: FavouritesProtocol)
    {
        self.myView = view
    }
    
    func fetchFavouritesData(){
        //favourites = coredataManager.fetchFavouriteLeagues(fetchedData: &favourites)
    }
    
    func checkInternetConnection(){
        
        
    }
    
}
