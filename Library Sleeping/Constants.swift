//
//  Constants.swift
//  Library Sleeping
//
//  Created by David Ilenwabor on 6/6/18.
//  Copyright © 2018 DJTech. All rights reserved.
//

import Foundation


struct Constants{
    
    struct Flickr {
        static let APIBASEURL = "https://api.flickr.com/services/rest"
    }
    
    struct FlickrParameterKeys {
        static let method = "method"
        static let APIKEY = "api_key"
        static let GalleryID = "gallery_id"
        static let Extras = "extras"
        static let Format = "format"
        static let NoJSONCallback = "nojsoncallback"
        
    }
    
    struct FlickrParameterValues{
        static let APIKey = "05e6ed7b2afcf63fec2acb42b3dd9b77"
        static let ResponseFormat = "json"
        static let DisableJSONCallback = "1" //means yes
        static let GalleryPhotosMethod = "flickr.galleries.getphotos"
        static let GalleryID = "5704-72157622566655097"
        static let MediumUrl = "url_m"
    }
    
}
