//
//  APILinks.swift
//  SportApp
//
//  Created by Thoraya Hamdy on 11/14/1400 AP.
//  Copyright © 1400 EmyAbobakr. All rights reserved.
//

import Foundation

enum Links {
    case sports
    case leagues
    case teams
}

class APILinks {
    
    func getLink(linkName: Links) -> String {
        let strLink: String?
        switch linkName {
        case .sports:
            strLink = "https://www.thesportsdb.com/api/v1/json/2/all_sports.php"
        case .leagues:
            strLink = "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s="
        case .teams:
            strLink = ""
        default:
            strLink = ""
        }
        return strLink ?? ""
    }
}
