//
//  CheckNetwork.swift
//  SportApp
//
//  Created by EmyAbobakr on 2/11/22.
//  Copyright © 2022 EmyAbobakr. All rights reserved.
//

import Foundation
import Network

//class NetworkMonitor{
//    static let shared = NetworkMonitor()
//
//    let monitor = NWPathMonitor()
//
//    func checkNet(){
//        monitor.pathUpdateHandler = { path in
//           if path.status == .satisfied {
//              print("Connected")
//           } else {
//              print("Disconnected")
//           }
//           print(path.isExpensive)
//        }
//        let queue = DispatchQueue(label: "Monitor")
//        monitor.start(queue: queue)
//
////        let queue = DispatchQueue(label: "Monitor”)
////        monitor.start(queue: queue)
//    }
//
//
//}

class NetworkMonitor {
    static let shared = NetworkMonitor()

    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    //var isReachableOnCellular: Bool = true

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            //self?.isReachableOnCellular = path.isExpensive

            if path.status == .satisfied {
                print("We're connected!")
                // post connected notification
            } else {
                print("No connection.")
                // post disconnected notification
            }
            //print(path.isExpensive)
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}

