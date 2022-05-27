//
//  KmartError.swift
//  KMART
//
//  Created by Nindi Gill on 13/12/21.
//

import Foundation

enum KmartError: Error {
    case invalidFile
    case invalidURL
    case missingKey
    case invalidStatusCode
}