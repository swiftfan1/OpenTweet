//
//  ImageManager.swift
//  OpenTweet
//
//  Created by Mike Griffin on 8/18/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

final class ImageManager {
    static let shared = ImageManager()
    var imageCache = NSCache<NSString, UIImage>()
    
    func fetchImage(_ urlString: String?, completed: ((UIImage) -> Void)?) {
        guard let urlString = urlString else {
            completed?(UIImage(named: "egg")!)
            return
        }
        if let cached = imageCache.object(forKey: NSString(string: urlString)) {
            completed?(cached)
        }
        guard let url = URL(string: urlString) else {
            completed?(UIImage(named: "egg")!)
            return
        }
        URLSession.shared.dataTask(with: url) { [self] data, response, error in
            if error != nil {
                completed?(UIImage(named: "egg")!)
            }
            if let data = data {
                if let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    completed?(image)
                } else {
                    completed?(UIImage(named: "egg")!)
                }
            } else {
                completed?(UIImage(named: "egg")!)
            }
        }.resume()
    }
}
