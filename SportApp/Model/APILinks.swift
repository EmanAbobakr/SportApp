//
//  APILinks.swift
//  SportApp
//
//  Created by Thoraya Hamdy on 11/14/1400 AP.
//  Copyright © 1400 EmyAbobakr. All rights reserved.
//

import Foundation

enum Links : String{
    case sports = "https://www.thesportsdb.com/api/v1/json/2/all_sports.php"
    //case leagues = "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s="
    case leagues = "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php"
//    case events = "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id="
    case events = "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php"

    case teams = "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php"
    //Albanian_Superliga
}

