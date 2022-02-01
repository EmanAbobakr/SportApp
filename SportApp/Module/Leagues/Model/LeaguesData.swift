//
//  LeaguesData.swift
//  SportApp
//
//  Created by EmyAbobakr on 2/1/22.
//  Copyright © 2022 EmyAbobakr. All rights reserved.
//

import Foundation

class League: Decodable
{
    var idLeague : String?
    var strSport : String?
    var strBadge : String?
    var strLeague : String?
    var strLeagueAlternate : String?
    var strYoutube : String?
    
}

class LeaguesResult: Decodable {
    var countrys : [League]
}
