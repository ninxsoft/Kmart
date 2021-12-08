//
//  MacDeviceHistory.swift
//  KMART
//
//  Created by Nindi Gill on 19/2/21.
//

import Foundation

struct MacDeviceHistory: Codable {
    var id: Int = -1
    var macPolicyLogs: [MacPolicyLog] = []
}
