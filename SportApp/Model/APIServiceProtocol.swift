//
//  APIServiceProtocol.swift
//  SportApp
//
//  Created by Thoraya Hamdy on 11/14/1400 AP.
//  Copyright © 1400 EmyAbobakr. All rights reserved.
//

import Foundation
import Alamofire
protocol APIServiceProtocol {
    func fetchDataFromAPI<T: Decodable>(url: String,param: Parameters?, responseClass: T.Type, complitionHandler : @escaping (T?,Error?) -> Void)
}
