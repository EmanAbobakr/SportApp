//
//  SportsData.swift
//  SportApp
//
//  Created by EmyAbobakr on 2/5/22.
//  Copyright © 2022 EmyAbobakr. All rights reserved.
//

import Foundation

class Sport : Decodable
{
    var idSport: String?
    var strSport: String?
    var strFormaz: String?
    var strSportThumb: String?
    var strSportIconGreen: String?
    
}

class SportsResult : Decodable
{
    var sports : [Sport]
}
