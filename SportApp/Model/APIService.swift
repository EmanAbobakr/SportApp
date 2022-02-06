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
    func fetchDataFromAPI<T: Decodable>(url: String,param: Parameters?, responseClass: T.Type, complitionHandler : @escaping (T?) -> Void)
    {
        //let header : HTTPHeaders = [
            //   .accept("application/json")
          // ]
        
        /*_ = AF.request(url , method: .post, headers: nil)
                .responseJSON{ (response) in
                    print(response.request ?? "")
                    print(response.data ?? "")
                    print(response.error ?? "")
                if response.value != nil
                {
                    do{
                        let result = try JSONDecoder().decode(T.self, from: response.data!)
                        //print(sportsResult.sports[0].strSport ?? "api empty ya Emy")
                        print("Result from Api \n \(String(describing: response.data))")
                        complitionHandler(result)
                    }catch let error{
                        print(error.localizedDescription)
                        complitionHandler(nil)
                    }
                }
                    
                else
                {
                    print("Failed request")
                }
           }*/
        AF.request(url, method: Alamofire.HTTPMethod.post, parameters: param, encoding: URLEncoding(destination: .queryString), headers: nil).responseJSON { (response) in
            
            //print(response.response?.url ?? "")
            if let error = response.error {
                print(error)
            }
                  
            guard let urlResponse = response.response else {
                print("Error in guard")
                return
            }
            if !(200..<300).contains(urlResponse.statusCode) {
                print(urlResponse.statusCode)
                return
            }
            //print(response.response?.url ?? "")
            guard let data = response.data else { return }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                complitionHandler(response)
            } catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
                
            }
        }
    }
}
