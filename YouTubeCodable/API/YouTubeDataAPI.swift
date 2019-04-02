//
//  YouTubeDataAPIService.swift
//  YoutubeDemo
//
//  Created by YH Kung on 2019/3/21.
//  Copyright © 2019 WaveRadio. All rights reserved.
//

import Foundation
import UIKit
import Moya

enum YouTubeDataAPI {
    case search(keyword: String, nextPageToken: String?)
    case playlistItems(playlistId: String)
}

extension YouTubeDataAPI: TargetType {

    /// 去 Google 後台申請 YouTube Data API Key 之後代入
    /// https://developers.google.com/youtube/v3/getting-started
    private var apiKey: String { return "{API_KEY}" }

    var baseURL: URL { return URL(string: "https://www.googleapis.com/youtube")! }

    var path: String {
        switch self {
        case .search(_):
            return "/v3/search"
        case .playlistItems(_):
            return "/v3/playlistItems"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        switch self {
        case .search(_, _):
            return SampleDataFile.yt_searchList
        case .playlistItems(_):
            return SampleDataFile.yt_playlistItemList        
        }
    }

    var task: Task {
        let encoding: ParameterEncoding
        switch self.method {
        case .post:
            encoding = JSONEncoding.default
        default:
            encoding = URLEncoding.default
        }
        if let requestParameters = parameters {
            return .requestParameters(parameters: requestParameters, encoding: encoding)
        }
        return .requestPlain
    }

    var parameters: [String: Any]? {
        switch self {
        case let .search(keyword, nextPageToken):
            var params = [
                "key": apiKey,
                "part": "snippet",
                "q": keyword,
                "maxResults": 50,
                "type": "video",
                "videoEmbeddable": "true"
            ] as [String: Any]
            if let pageToken = nextPageToken {
                params["pageToken"] = pageToken
            }
            return params
        case let .playlistItems(playlistId):
            let params = [
                "key": apiKey,
                "part": "snippet",
                "playlistId": playlistId,
                "maxResults": 50,
            ] as [String: Any]
            return params
        }
    }

    var headers: [String : String]? {
        return nil
    }

}
