//
//  NetworkMonitor.swift
//  Rick and Morty
//
//  Created by Евгений Глоба on 1/26/25.
//

import UIKit
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()

    private let queue = DispatchQueue(label: "NetworkConnectivityMonitor")
    private let monitor: NWPathMonitor

    private(set) var isConnected = false
    private(set) var isExpensive = false

    private init() { monitor = NWPathMonitor() }

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }

            self.isConnected = path.status == .satisfied
            self.isExpensive = path.isExpensive

            print("Network status changed:")
            print("Connected: \(self.isConnected)")
            print("Expensive: \(self.isExpensive)")

            NotificationCenter.default.post(name: .connectivityStatus, object: nil)
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() { monitor.cancel() }
}

extension Notification.Name { static let connectivityStatus = Notification.Name("connectivityStatus") }


