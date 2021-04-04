//
//  HTTP.swift
//  KMART
//
//  Created by Nindi Gill on 14/2/21.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct HTTP {

    static func retrieveObjects(using configuration: Configuration) -> Objects {

        var objects: Objects = Objects()
        let authorization: String = configuration.authorization
        let sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpMaximumConnectionsPerHost = configuration.requests
        let session: URLSession = URLSession(configuration: sessionConfiguration)

        for endpoint in configuration.endpoints {
            let primaryURL: String = "\(configuration.url)/JSSResource/\(endpoint == .macDevicesHistory ? "computers" : endpoint.apiSlug)"
            PrettyPrint.print(.info, string: "Performing lookups for \(endpoint.fullDescription):", newLine: false)

            let start: Date = Date()

            guard let primary: [String: Any] = requestObject(url: primaryURL, with: authorization, using: session) else {
                continue
            }

            guard let array: [[String: Any]] = primary[endpoint.primaryKey] as? [[String: Any]] else {
                PrettyPrint.print(.error, string: "Unable to find '\(endpoint.primaryKey)' key in URL response")
                continue
            }

            let identifiers: [Int] = array.identifiers
            let group: DispatchGroup = DispatchGroup()

            for identifier in identifiers {
                group.enter()

                let secondaryURL: String = "\(configuration.url)/JSSResource/\(endpoint.apiSlug)/id/\(identifier)\(endpoint.subset)"

                guard let secondary: [String: Any] = requestObject(url: secondaryURL, with: authorization, using: session) else {
                    group.leave()
                    continue
                }

                guard var dictionary: [String: Any] = secondary[endpoint.secondaryKey] as? [String: Any] else {
                    PrettyPrint.print(.error, string: "Unable to find '\(endpoint.secondaryKey)' key in URL response")
                    group.leave()
                    continue
                }

                dictionary.transform(endpoint: endpoint)
                objects.insert(dictionary, for: endpoint)
                group.leave()
            }

            let end: Date = Date()
            let delta: TimeInterval = end.timeIntervalSince(start)
            PrettyPrint.print(.info, prefix: false, string: String(format: " %.1f seconds", delta))
        }

        return objects
    }

    private static func requestObject(url string: String, with authorization: String, using session: URLSession) -> [String: Any]? {

        var object: [String: Any]?

        guard let url: URL = URL(string: string) else {
            PrettyPrint.print(.error, string: "Invalid URL: \(string)")
            return nil
        }

        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(authorization, forHTTPHeaderField: "Authorization")
        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)

        let task: URLSessionDataTask = session.dataTask(with: request) { data, response, error in

            if let error: Error = error {
                PrettyPrint.print(.error, string: "\(error.localizedDescription)")
                semaphore.signal()
                return
            }

            guard let response: URLResponse = response,
                let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else {
                PrettyPrint.print(.error, string: "Unable to get response from URL: \(url)")
                semaphore.signal()
                return
            }

            guard httpResponse.statusCode == 200 else {
                let string: String = errorMessage(httpResponse.statusCode, url: url)
                PrettyPrint.print(.error, string: string)
                semaphore.signal()
                return
            }

            guard let data: Data = data else {
                PrettyPrint.print(.error, string: "Invalid data from URL response")
                semaphore.signal()
                return
            }

            do {
                if let dictionary: [String: Any] = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    object = dictionary
                }
            } catch {
                PrettyPrint.print(.error, string: "\(error.localizedDescription)")
            }

            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        return object
    }

    private static func errorMessage(_ statusCode: Int, url: URL) -> String {

        switch statusCode {
        case 400:
            return "HTTP \(statusCode): Bad Request: \(url)"
        case 401, 403:
            return "HTTP \(statusCode): \(statusCode == 401 ? "Unauthorized" : "Forbidden"): \(url)\nCheck your API credentials have read permissions and try again."
        case 404:
            return "HTTP \(statusCode): Not Found: \(url)\nCheck your Jamf Pro URL and try again."
        case 408:
            return "HTTP \(statusCode): Request Timeout: \(url)"
        case 429:
            return "HTTP \(statusCode): Too Many Requests: \(url)"
        case 500:
            return "HTTP \(statusCode): Internal Server Error: \(url)"
        case 502:
            return "HTTP \(statusCode): Bad Gateway: \(url)"
        case 503:
            return "HTTP \(statusCode): Service Unavailable: \(url)"
        case 504:
            return "HTTP \(statusCode): Gateway Timeout: \(url)"
        default:
            return "HTTP \(statusCode): \(url)"
        }
    }
}
