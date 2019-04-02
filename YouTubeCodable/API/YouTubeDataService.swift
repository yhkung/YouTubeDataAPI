//
//  YouTubeDataService.swift
//  YoutubeDemo
//
//  Created by YH Kung on 2019/3/27.
//  Copyright © 2019 WaveRadio. All rights reserved.
//

import Foundation
import Moya
import Alamofire

class YouTubeDataService: APIServices {
    typealias T = YouTubeDataAPI
    private var provider: MoyaProvider<T>

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.iso8601)
        return decoder
    }()

    init(provider: MoyaProvider<T>) {
        self.provider = provider
    }

    func retrievePlaylistItems(playlistId: String, completion: @escaping ResultCompletion<[YouTube.Video]>) {
        let target = YouTubeDataAPI.playlistItems(playlistId: playlistId)
        let completion: (Result<YouTube.PlaylistItemListResponse>) -> Void = { result in
            switch result {
            case .success(let data):
                let videos = data.items.map { YouTube.Video(from: $0) }
                completion(.success(videos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        provider.retrieveData(target: target, using: decoder, completion: completion)
    }

    func search(keyword: String, pageToken: String? = nil, completion: @escaping ResultCompletion<[YouTube.Video]>) {
        let target = YouTubeDataAPI.search(keyword: keyword, nextPageToken: pageToken)
        let completion: (Result<YouTube.SearchListResponse>) -> Void = { result in
            switch result {
            case .success(let data):
                let videos = data.items.map { YouTube.Video(from: $0) }
                completion(.success(videos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        provider.retrieveData(target: target, using: decoder, completion: completion)
    }

}
