//
//  APIService.swift
//  YoutubeDemo
//
//  Created by YH Kung on 2019/3/26.
//  Copyright © 2019 WaveRadio. All rights reserved.
//

import Foundation
import Moya
import Alamofire

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

struct APIEndpoint<Target, DecodableData> where Target: Moya.TargetType, DecodableData: Decodable {
    var provider: MoyaProvider<Target>
    var target: Target
    var dataType: DecodableData.Type
}

protocol APIServiceType {
    associatedtype T: Moya.TargetType
    init(provider: MoyaProvider<T>)
}

public typealias ResultCompletion<T> = (Result<T>) -> Void

class APIServices {

    /// 使用假資料來模擬
    private static let YouTubeDataAPIProvider =
        MoyaProvider<YouTubeDataAPI>(stubClosure: MoyaProvider.delayedStub(1))

    /// 用 YouTube Data API，用下方的 provider，需要 API KEY

//    private static let YouTubeDataAPIProvider = MoyaProvider<YouTubeDataAPI>(
//        plugins: [
//            NetworkLoggerPlugin(
//                verbose: true,
//                cURL: true,
//                responseDataFormatter: JSONResponseDataFormatter
//            )
//        ]
//    )
    static let YouTubeData = YouTubeDataService(provider: YouTubeDataAPIProvider)
}

extension MoyaProvider {

    func retrieveData<D>(target: Target, using decoder: JSONDecoder = JSONDecoder(), completion: @escaping ResultCompletion<D>) where D: Decodable {
        request(target) { result in
            do {
                let response = try result.get()
                let data = try response.map(D.self, using: decoder, failsOnEmptyData: true)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }
    }

}
