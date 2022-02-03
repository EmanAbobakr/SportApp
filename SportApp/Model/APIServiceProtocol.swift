//
//  APIServiceProtocol.swift
//  SportApp
//
//  Created by Thoraya Hamdy on 11/14/1400 AP.
//  Copyright © 1400 EmyAbobakr. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    func fetchDataFromAPI(complitionHandler : @escaping (SportsResult?, String?) -> Void, url: String)
}
