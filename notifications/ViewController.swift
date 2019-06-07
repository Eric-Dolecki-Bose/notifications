//
//  ViewController.swift
//  notifications
//
//  Created by Eric Dolecki on 6/7/19.
//  Copyright © 2019 Eric Dolecki. All rights reserved.
//

import UIKit

///
/// We're showing how notifications work. They are useful in 1 - many situations.
/// Many classes can listen for notifications. If you need 1 - 1 communication,
/// delegate is much preferred.
class ViewController: UIViewController {

    var imageContainer: UIImageView!
    var imageLoader: ImageLoader!
    var myButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        imageLoader = ImageLoader()
        
        imageContainer = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        imageContainer.contentMode = .scaleAspectFill
        
        myButton = UIButton(frame: CGRect(x: 0, y: 0, width: 180, height: 40))
        myButton.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.height - 100)
        myButton.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        myButton.layer.cornerRadius = 8
        myButton.setTitle("Load Image", for: .normal)
        myButton.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        myButton.setTitleColor(UIColor.white, for: .normal)
        myButton.addTarget(self, action: #selector(loadCharlotte(_:)), for: .touchUpInside)
        
        self.view.addSubview(imageContainer)
        self.view.addSubview(myButton)

        // Register for a notification - we wait for a post from the ImageLoader class.
        
        NotificationCenter.default.addObserver(self, selector: #selector(weReceivedData(_:)), name: .didLoadImage, object: nil)
        
        // If you need to unregister, you can use the syntax below.
        // NotificationCenter.default.removeObserver(self, name: .didLoadImage, object: nil)
    }
    
    @objc func loadCharlotte(_ sender:UIButton)
    {
        // Let's load an image of Charlotte de Witte. Clear out any current image (if someone presses the button again).
        
        imageContainer.image = nil
        imageLoader.loadImageFromURL(urlAsString: "https://sonar.es/system/attached_images/20517/medium/charlotte-de-witte-sonar-bcn-2018.jpg?1520868264")
    }
    
    // This gets called from the observer above.
    @objc func weReceivedData(_ notification:Notification)
    {
        if let data = notification.userInfo as? [String: UIImage]
        {
            // This needs to be called on main thread since it's UI-related.
            // The network call is on a background thread.
            DispatchQueue.main.async { [weak self] in
                
                // We have the data. Fade imageview down so after we place the image, fade it back up. Elegant-like.
                self?.imageContainer.alpha = 0
                self?.imageContainer.image = data["image"]
                
                UIView.animate(withDuration: 1.0, animations: {
                    self?.imageContainer.alpha = 1.0
                })
            }
        }
    }
}

// This makes using Notification names less verbose. Handy. Do not need to do this.

extension Notification.Name {
    static let didLoadImage = Notification.Name("didLoadImage")
}

