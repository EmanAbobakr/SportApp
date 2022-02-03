//
//  APIService.swift
//  SportApp
//
//  Created by EmyAbobakr on 2/1/22.
//  Copyright © 2022 EmyAbobakr. All rights reserved.
//

import Foundation
import Alamofire


class APIService : APIServiceProtocol
{
    func fetchResult(complitionHandler : @escaping (SportsResult?) -> Void)
    {
        let header : HTTPHeaders = [
               .accept("application/json")
           ]
        let strURL = "https://www.thesportsdb.com/api/v1/json/2/all_sports.php"
        _ = AF.request(strURL , headers: header)
               .responseJSON{ (response) in
                if response.value != nil
                {
                    do{
                        let sportsResult = try JSONDecoder().decode(SportsResult.self, from: response.data!)
                        //print(sportsResult.sports[0].strSport ?? "api empty ya Emy")
                        complitionHandler(sportsResult)
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
    func fetchDataFromAPI(complitionHandler : @escaping (SportsResult?, String?) -> Void, url: String) {
        
        let header : HTTPHeaders = [
               .accept("application/json")
           ]
        _ = AF.request(url , headers: header)
               .responseJSON{ (response) in
                if response.value != nil
                {
                    do{
                        let sportsResult = try JSONDecoder().decode(SportsResult.self, from: response.data!)
                        //print(sportsResult.sports[0].strSport ?? "api empty ya Emy")
                        complitionHandler(sportsResult, nil)
                    }catch let error{
                        print(error.localizedDescription)
                        complitionHandler(nil, error.localizedDescription)
                    }
                }
                else
                {
                    complitionHandler(nil, "Failed request")
                    print("Failed request")
                }
           }
    }
    

}
