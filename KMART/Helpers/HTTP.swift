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

/// Struct used to perform all **HTTP** operations.
struct HTTP {

    /// Retrieve all Jamf API endpoint results.
    ///
    /// - Parameters:
    ///   - configuration: The Jamf API endpoint URL.
    /// - Returns: An object containing all Jamf API endpoint results.
    static func retrieveObjects(using configuration: Configuration) -> Objects {

        var objects: Objects = Objects()
        let authorization: String = configuration.authorization
        let sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpMaximumConnectionsPerHost = configuration.requests
        sessionConfiguration.timeoutIntervalForRequest = configuration.timeout
        let session: URLSession = URLSession(configuration: sessionConfiguration)
        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)

        for endpoint in configuration.endpoints {
            let primaryURL: String = "\(configuration.url)/JSSResource/\(endpoint == .macDevicesHistory ? "computers" : endpoint.apiSlug)"
            let startString: String = "Retrieving \(endpoint.fullDescription)..."
            PrettyPrint.print(startString, terminator: "")

            let start: Date = Date()
            let primary: [String: Any] = requestObject(url: primaryURL, with: authorization, using: session, semaphore: semaphore)

            guard let array: [[String: Any]] = primary[endpoint.primaryKey] as? [[String: Any]] else {
                PrettyPrint.print("Unable to find '\(endpoint.primaryKey)' key in URL response", prefix: "\n  ├─ ")
                continue
            }

            let identifiers: [Int] = array.identifiers
            let group: DispatchGroup = DispatchGroup()

            for identifier in identifiers {
                group.enter()

                let secondaryURL: String = "\(configuration.url)/JSSResource/\(endpoint.apiSlug)/id/\(identifier)\(endpoint.subset)"
                let secondary: [String: Any] = requestObject(url: secondaryURL, with: authorization, using: session, semaphore: semaphore)

                guard var dictionary: [String: Any] = secondary[endpoint.secondaryKey] as? [String: Any] else {
                    PrettyPrint.print("Unable to find '\(endpoint.secondaryKey)' key in URL response", prefix: "\n  ├─ ")
                    group.leave()
                    continue
                }

                dictionary.transform(endpoint: endpoint)
                objects.insert(dictionary, for: endpoint)
                group.leave()
            }

            let end: Date = Date()
            let delta: TimeInterval = end.timeIntervalSince(start)
            let endString: String = String(format: " %.1f seconds", delta)
            PrettyPrint.print(endString, prefix: "")
        }

        return objects
    }

    /// Request a Jamf API endpoint object.
    ///
    /// - Parameters:
    ///   - url:           The Jamf API endpoint URL.
    ///   - authorization: The Jamf API HTTP basic authorization token.
    ///   - session:       The (common) URLSession.
    ///   - semaphore:     The common semaphore used to wait for operations to complete.
    /// - Returns: A Jamf API endpoint dictionary object.
    private static func requestObject(url string: String, with authorization: String, using session: URLSession, semaphore: DispatchSemaphore) -> [String: Any] {

        var object: [String: Any] = [:]

        guard let url: URL = URL(string: string) else {
            PrettyPrint.print("Invalid URL: \(string)", prefix: "\n  ├─ ")
            return [:]
        }

        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(authorization, forHTTPHeaderField: "Authorization")

        // swiftlint:disable:next closure_body_length
        let task: URLSessionDataTask = session.dataTask(with: request) { data, response, error in

            if let error: Error = error {
                PrettyPrint.print(error.localizedDescription, prefix: "\n  ├─ ")
                semaphore.signal()
                return
            }

            guard let response: URLResponse = response,
                let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else {
                PrettyPrint.print("Unable to get response from URL: \(url)", prefix: "\n  ├─ ")
                semaphore.signal()
                return
            }

            guard httpResponse.statusCode == 200 else {
                let string: String = errorMessage(httpResponse.statusCode, for: url)
                PrettyPrint.print(string, prefix: "\n  ├─ ")
                semaphore.signal()
                return
            }

            guard let data: Data = data else {
                PrettyPrint.print("Invalid data from URL response", prefix: "\n  ├─ ")
                semaphore.signal()
                return
            }

            do {
                if let dictionary: [String: Any] = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    object = dictionary
                }
            } catch {
                PrettyPrint.print(error.localizedDescription, prefix: "\n  ├─ ")
            }

            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        return object
    }

    /// Return an error message for the provided HTTP status code and URL.
    ///
    /// - Parameters:
    ///   - statusCode: The HTTP status code.
    ///   - url:        The URL where the HTTP status code was returned from.
    /// - Returns: An error message `String`.
    static func errorMessage(_ statusCode: Int, for url: URL) -> String {

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
