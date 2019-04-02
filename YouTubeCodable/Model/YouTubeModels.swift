//
//  YouTubeModels.swift
//  YoutubeDemo
//
//  Created by YH Kung on 2019/3/26.
//  Copyright © 2019 WaveRadio. All rights reserved.
//

import Foundation
import UIKit

enum YouTube {

    struct Video {
        let id: String
        let title: String
        let description: String
        let thumbnails: Thumbnail
        let publishedAt: Date

        init(from item: SearchListResponse.Item) {
            id = item.id.videoId
            title = item.snippet.title
            description = item.snippet.description
            thumbnails = item.snippet.thumbnails
            publishedAt = item.snippet.publishedAt
        }

        init(from item: PlaylistItemListResponse.Item) {
            id = item.snippet.resourceId.videoId
            title = item.snippet.title
            description = item.snippet.description
            thumbnails = item.snippet.thumbnails
            publishedAt = item.snippet.publishedAt
        }
    }

    struct Thumbnail: Decodable {
        let `default`: Image
        let medium: Image
        let high: Image

        struct Image: Decodable {
            let url: URL
            private let width: CGFloat
            private let height: CGFloat
            var size: CGSize {
                return CGSize(width: width, height: height)
            }
        }
    }
}

extension YouTube {

    struct PlaylistItemListResponse: Decodable {
        let kind: String
        let nextPageToken: String?
        let pageInfo: PageInfo
        let items: [Item]        

        struct PageInfo: Decodable {
            let totalResults: Int
            let resultsPerPage: Int
        }

        struct Item: Decodable {
            let kind: String
            let id: String
            let snippet: Snippet
        }

        struct Snippet: Decodable {
            let title: String
            let description: String
            let thumbnails: Thumbnail
            let publishedAt: Date
            let resourceId: ResourceId

            struct ResourceId: Decodable {
                let kind: String
                let videoId: String
            }
        }
    }

    struct SearchListResponse: Decodable {
        let kind: String
        let nextPageToken: String?
        let pageInfo: PageInfo
        let items: [Item]

        struct PageInfo: Decodable {
            let totalResults: Int
            let resultsPerPage: Int
        }

        struct Item: Decodable {
            let kind: String
            let id: ID
            let snippet: Snippet

            struct ID: Decodable {
                let kind: String
                let videoId: String
            }

            struct Snippet: Decodable {
                let title: String
                let description: String
                let thumbnails: Thumbnail
                let publishedAt: Date
            }
        }
    }

}
