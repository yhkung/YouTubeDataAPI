//
//  SampleDate.swift
//  YoutubeDemo
//
//  Created by YH Kung on 2019/3/27.
//  Copyright © 2019 WaveRadio. All rights reserved.
//

import Foundation

enum SampleDataFile {

    static let yt_searchList: Data = {
        return jsonFile(fileName: "YouTube_SearchList")
    }()

    static let yt_playlistItemList: Data = {
        return jsonFile(fileName: "YouTube_PlaylistItemList")
    }()

    private static func jsonFile(fileName: String) -> Data {
        return try! Data(contentsOf: Bundle.main.url(forResource: fileName, withExtension: "json")!)
    }

}
