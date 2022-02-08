//
//  TeamsData.swift
//  SportApp
//
//  Created by Thoraya Hamdy on 11/16/1400 AP.
//  Copyright © 1400 EmyAbobakr. All rights reserved.
//

import Foundation

class Team : Decodable{
    var idTeam: String!
    var strTeam: String!
    var strTeamShort: String!
    var intFormedYear: String!
    var strSport: String!
    var strLeague: String!
    var idLeague: String!
    var strStadium: String!
    var strStadiumDescription: String!
    var strStadiumLocation: String!
    var intStadiumCapacity: String!
    var strWebsite: String!
    var strFacebook: String!
    var strTwitter: String!
    var strInstagram: String!
    var strDescriptionEN: String!
    var strGender: String!
    var strCountry: String!
    var strTeamBadge: String!
}

class TeamsResult : Decodable {
    var teams : [Team]!
}
