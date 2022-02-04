//
//  APILeaguesService.swift
//  SportApp
//
//  Created by EmyAbobakr on 2/1/22.
//  Copyright © 2022 EmyAbobakr. All rights reserved.
//

import Foundation
import Alamofire

class APILeaguesService
{
    func fetchResult(complitionHandler : @escaping (LeaguesResult?) -> Void , url: String)
    {
        let header : HTTPHeaders = [
               .accept("application/json")
           ]
        //let strURL = "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s=Soccer"
        _ = AF.request(url , headers: header)
               .responseJSON{ (response) in
                if response.value != nil
                {
                    do{
                        let leaguesResult = try JSONDecoder().decode(LeaguesResult.self, from: response.data!)
                        //print(leaguesResult.countrys[0].strLeague ?? "api empty ya Emy")
                        complitionHandler(leaguesResult)
                    }catch let error{
                        print(error.localizedDescription)
                        complitionHandler(nil)
                    }
                }
                else
                {
                    print("Failed request")
                }
           }
           
    }

}
