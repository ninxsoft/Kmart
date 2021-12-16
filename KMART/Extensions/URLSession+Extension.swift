//
//  URLSession+Extension.swift
//  KMART
//
//  Created by Nindi Gill on 16/12/2021.
//

import Foundation

extension URLSession {

    func synchronousData(for request: URLRequest) throws -> (Data, URLResponse) {

        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
        var possibleData: Data?
        var possibleResponse: URLResponse?

        self.dataTask(with: request) { data, response, error in

            if let _: Error = error {
                semaphore.resume()
                return
            }

            guard let data: Data = data,
                let response: URLResponse = response,
                let httpURLResponse: HTTPURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200 else {
                semaphore.resume()
                return
            }

            possibleData = data
            possibleResponse = response
            semaphore.resume()
        }

        semaphore.wait()

        guard let data: Data = possibleData,
            let response: URLResponse = possibleResponse else {
            throw KmartError.invalidData
        }

        return (data, response)
    }
}
