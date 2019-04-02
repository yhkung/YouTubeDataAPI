//
//  ViewController.swift
//  YouTubeCodable
//
//  Created by YH Kung on 2019/4/2.
//  Copyright © 2019 yH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        search(q: "leetcode")
    }

    func search(q: String) {
        APIServices.YouTubeData.search(keyword: q) { result in
            switch result {
            case .success(let videos):
                for video in videos {
                    print("[\(video.title)]")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}

