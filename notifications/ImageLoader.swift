//
//  ImageLoader.swift
//  notifications
//
//  Created by Eric Dolecki on 6/7/19.
//  Copyright © 2019 Eric Dolecki. All rights reserved.
//

import UIKit

class ImageLoader: NSObject {

    override init() {
        super.init()
    }
    
    func loadImageFromURL(urlAsString s: String)
    {
        let imageURL = URL(string: s)!
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if error == nil {
                let loadedImage = UIImage(data: data!)
                // We have a loaded image derived from the URL's data. We can send that to anyone who is listening for a notification.
                let ourResponse = ["image":loadedImage]
                NotificationCenter.default.post(name: .didLoadImage, object: self, userInfo: ourResponse as! [String : UIImage])
            }
        }
        task.resume()
    }
}
