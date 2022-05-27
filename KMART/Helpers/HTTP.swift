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
    ///   - configuration: The Jamf API configuration object.
    /// - Returns: An object containing all Jamf API endpoint results.
    static func retrieveObjects(using configuration: Configuration) async -> Objects {

        var objects: Objects = Objects()
        let session: URLSession = urlSession(requests: configuration.requests, timeout: configuration.timeout)
        var token: (value: String, expiration: Date) = (value: "", expiration: Date())

        for endpoint in configuration.endpoints {

            guard let url: URL = endpoint.primaryURL(url: configuration.url) else {
                PrettyPrint.print("Invalid URL for \(endpoint.fullDescription)...", prefixColor: .red)
                continue
            }

            let start: Date = Date()

            do {
                if tokenHasExpired(token) {
                    token = try await refreshToken(using: configuration)
                }

                let request: URLRequest = urlRequest(for: url, with: "Bearer \(token.value)")
                let (data, urlResponse): (Data, URLResponse) = try await session.data(for: request)

                guard let httpURLResponse: HTTPURLResponse = urlResponse as? HTTPURLResponse,
                    let dictionary: [String: Any] = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let array: [[String: Any]] = dictionary[endpoint.primaryKey] as? [[String: Any]] else {
                    PrettyPrint.print("Unable to find '\(endpoint.primaryKey)' key in URL response", prefixColor: .red)
                    continue
                }

                guard httpURLResponse.statusCode == 200 else {
                    PrettyPrint.print(errorMessage(httpURLResponse.statusCode, for: url), prefixColor: .red)
                    continue
                }

                var current: Int = 0
                let total: Int = array.identifiers.count
                PrettyPrint.print(formattedString(for: endpoint, current: 0, total: total))

                for identifier in array.identifiers {

                    do {
                        let dictionary: [String: Any] = try await retrieveObject(for: identifier, endpoint: endpoint, configuration: configuration, session: session, token: token)
                        objects.insert(dictionary, for: endpoint)
                        current += 1
                        PrettyPrint.print(formattedString(for: endpoint, current: current, total: total), replacing: true)
                    } catch {
                        current += 1
                        PrettyPrint.print(error.localizedDescription, prefixColor: .red)
                    }
                }

                let time: String = String(format: "%.1f seconds ", Date().timeIntervalSince(start))
                PrettyPrint.print(formattedString(for: endpoint, current: total, total: total, time: time), replacing: true)
            } catch {
                PrettyPrint.print(error.localizedDescription, prefixColor: .red)
            }
        }

        return objects
    }

    /// Retrieve a single Jamf API endpoint result.
    ///
    /// - Parameters:
    ///   - identifier:    The Jamf API endpoint unique identifier.
    ///   - endpoint:      The Jamf API endpoint type.
    ///   - configuration: The Jamf API configuration object.
    ///   - session:       The common URLSession object.
    ///   - token:         The Jamf API bearer token.
    /// - Returns: A dictionary containing a Jamf API endpoint result.
    private static func retrieveObject(
        for identifier: Int,
        endpoint: Endpoint,
        configuration: Configuration,
        session: URLSession,
        token: (value: String, expiration: Date)
    ) async throws -> [String: Any] {

        var token: (value: String, expiration: Date) = token

        guard let url: URL = endpoint.secondaryURL(url: configuration.url, identifier: identifier) else {
            PrettyPrint.print("Invalid URL for \(endpoint.fullDescription)...", prefixColor: .red)
            throw KmartError.invalidURL
        }

        if tokenHasExpired(token) {
            token = try await refreshToken(using: configuration)
        }

        let request: URLRequest = urlRequest(for: url, with: "Bearer \(token.value)")
        let (data, urlResponse): (Data, URLResponse) = try await session.data(for: request)

        guard let httpURLResponse: HTTPURLResponse = urlResponse as? HTTPURLResponse,
            let parentDictionary: [String: Any] = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            var dictionary: [String: Any] = parentDictionary[endpoint.secondaryKey] as? [String: Any] else {
            PrettyPrint.print("Unable to find '\(endpoint.secondaryKey)' key in URL response", prefixColor: .red)
            throw KmartError.missingKey
        }

        guard httpURLResponse.statusCode == 200 else {
            PrettyPrint.print(errorMessage(httpURLResponse.statusCode, for: url), prefixColor: .red)
            throw KmartError.invalidStatusCode
        }

        dictionary.transform(endpoint: endpoint)
        return dictionary
    }

    /// Returns a URLSession object configured with the concurrent requests and timeout values.
    ///
    /// - Parameters:
    ///   - requests: The number of concurrent requests.
    ///   - timeout:  The timeout interval.
    /// - Returns: An object containing all Jamf API endpoint results.
    private static func urlSession(requests: Int, timeout: Double) -> URLSession {
        let sessionConfiguration: URLSessionConfiguration = .default
        sessionConfiguration.httpMaximumConnectionsPerHost = requests
        sessionConfiguration.timeoutIntervalForRequest = timeout
        let urlSession: URLSession = URLSession(configuration: sessionConfiguration)
        return urlSession
    }

    /// Returns a URLRequest object configured with the requested URL and HTTP header fields.
    ///
    /// - Parameters:
    ///   - url:           The requested URL.
    ///   - authorization: The Jamf API bearer token.
    /// - Returns: The configured `URLRequest` object.
    private static func urlRequest(for url: URL, with authorization: String) -> URLRequest {
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(authorization, forHTTPHeaderField: "Authorization")
        return request
    }

    /// Returns a formatted String based on the current status of the HTTP retrieval process.
    ///
    /// - Parameters:
    ///   - endpoint: The Endpoint that is being requested.
    ///   - current: The index of the current HTTP request being performed.
    ///   - total: The total HTTP requests to be performed.
    ///   - time: Optional time string indicating how the time interval of the Endpoint retrieval.
    /// - Returns: A formatted `String`.
    private static func formattedString(for endpoint: Endpoint, current: Int, total: Int, time: String? = nil) -> String {
        let prefixString: String = endpoint.fullDescription

        let formattedCurrent: String = "\(current)".leftPadding(toLength: 5, withPad: " ")
        let formattedTotal: String = "\(total)".padding(toLength: 5, withPad: " ", startingAt: 0)
        let percentage: Double = total > 0 ? Double(current) / Double(total) * 100 : 0
        let formattedPercentage: String = String(format: percentage == 100 ? "%05.1f%%" : "%05.2f%%", percentage)
        let suffixString: String = "[ \(formattedCurrent) / \(formattedTotal) (\(formattedPercentage)) ]"

        let paddingSize: Int = PrettyPrint.maximumWidth - PrettyPrint.Prefix.default.rawValue.count - prefixString.count - (time?.count ?? 0) - suffixString.count - 1
        let paddingString: String = String(repeating: ".", count: paddingSize)

        let string: String = "\(prefixString)\(paddingString) \(time ?? "")\(suffixString)"
        return string
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

    /// Determines if the Jamf API bearer token has expired and needs to be refreshed.
    ///
    /// - Parameters:
    ///   - token: The Jamf API bearer token.
    /// - Returns: True if the token has expired, otherwise False.
    private static func tokenHasExpired(_ token: (value: String, expiration: Date)) -> Bool {
        token.value.isEmpty || token.expiration < Date.now
    }

    /// Refreshes the Jamf API bearer token used for authentication
    ///
    /// - Parameters:
    ///   - configuration: The Jamf API configuration object.
    /// - Returns: A valid Jamf API bearer token.
    private static func refreshToken(using configuration: Configuration) async throws -> (value: String, expiration: Date) {

        guard let url: URL = URL(string: "\(configuration.url)/api/v1/auth/token") else {
            throw KmartError.invalidURL
        }

        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Basic \(configuration.credentials)", forHTTPHeaderField: "Authorization")

        let (data, urlResponse): (Data, URLResponse) = try await URLSession.shared.data(for: request)

        guard let httpURLResponse: HTTPURLResponse = urlResponse as? HTTPURLResponse,
            let dictionary: [String: Any] = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let value: String = dictionary["token"] as? String,
            let expires: String = dictionary["expires"] as? String else {
            PrettyPrint.print("Unable to find 'token' and 'expires' keys in URL response", prefixColor: .red)
            throw KmartError.missingKey
        }

        guard httpURLResponse.statusCode == 200 else {
            PrettyPrint.print(HTTP.errorMessage(httpURLResponse.statusCode, for: url), prefixColor: .red)
            throw KmartError.invalidStatusCode
        }

        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"

        guard let expiration: Date = dateFormatter.date(from: expires) else {
            PrettyPrint.print("Invalid token expiry: '\(expires)'", prefixColor: .red)
            throw KmartError.invalidTokenExpiry
        }

        return (value: value, expiration: expiration)
    }
}
