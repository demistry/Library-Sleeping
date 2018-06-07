//
//  ViewController.swift
//  Library Sleeping
//
//  Created by David Ilenwabor on 6/6/18.
//  Copyright © 2018 DJTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var newImageButton: UIButton!
    @IBOutlet weak var imageTitle: UILabel!
    @IBAction func getsNewImage(_ sender: UIButton) {
        setUIEnabled(false)
        getImageFromFlickr()
    }
    
    private func setUIEnabled(_ isEnabled : Bool){
        newImageButton.isEnabled = isEnabled
        
        if isEnabled{
            newImageButton.alpha = 1.0
        }
        else {
            newImageButton.alpha = 0.5
        }
    }
    
    private func getImageFromFlickr(){
        let methodParameters = [Constants.FlickrParameterKeys.method : Constants.FlickrParameterValues.GalleryPhotosMethod,
            Constants.FlickrParameterKeys.APIKEY : Constants.FlickrParameterValues.APIKey,
            Constants.FlickrParameterKeys.GalleryID : Constants.FlickrParameterValues.GalleryID,
            Constants.FlickrParameterKeys.Extras : Constants.FlickrParameterValues.MediumUrl,
            Constants.FlickrParameterKeys.Format : Constants.FlickrParameterValues.ResponseFormat,
            Constants.FlickrParameterKeys.NoJSONCallback : Constants.FlickrParameterValues.DisableJSONCallback
        ]
        /*let url = URL(string: "\(Constants.Flickr.APIBASEURL)?\(Constants.FlickrParameterKeys.method)=\(Constants.FlickrParameterValues.GalleryPhotosMethod)&\(Constants.FlickrParameterKeys.APIKEY)=\(Constants.FlickrParameterValues.APIKey)&\(Constants.FlickrParameterKeys.GalleryID)=\(Constants.FlickrParameterValues.GalleryID)&\(Constants.FlickrParameterKeys.Extras)=\(Constants.FlickrParameterValues.MediumUrl)&\(Constants.FlickrParameterKeys.Format)=\(Constants.FlickrParameterValues.ResponseFormat)&\(Constants.FlickrParameterKeys.NoJSONCallback)=\(Constants.FlickrParameterValues.DisableJSONCallback)")!*/
        let urlString = Constants.Flickr.APIBASEURL + escapedParameters(parameters: methodParameters)
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            if error == nil{
                if let data = data{
                    let parsedResult : AnyObject!
                    do{
                        //setUIEnabled(true)
                        parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
                        //self.imageView.image = UIImage(data: data!)
                        
                    } catch{
                        print("Error encountered")
                        return
                    }
                    let photosDictionary = parsedResult["photos"] as! [String : AnyObject]
                    let photoArray = photosDictionary["photo"] as! [[String : AnyObject]]
                    //
                    //let url = photo1["url_m"]
                    
                    if (parsedResult["photos"] as? [String : AnyObject]) != nil{
                        let randomIndex = Int(arc4random_uniform(UInt32(photoArray.count)))
                        let photoDictionary = photoArray[randomIndex]
                        guard let imageUrlString = photoDictionary["url_m"] as? String,let imageTitle = photoDictionary["title"] as? String
                            else{
                                return
                        }
                        
                        let imageURL = URL(string: imageUrlString)!
                        do{
                            if let imageData = NSData(contentsOf: imageURL){
                                DispatchQueue.main.async{
                                    self.imageView.image = UIImage(data: imageData as Data)
                                    self.imageTitle.text = imageTitle
                                    self.setUIEnabled(true)
                                }
                            }
                        }
                        
                    }
                    //print(parsedResult)
                }
            
                
            }
        })
        task.resume()
        
    }
    
    private func escapedParameters(parameters : [String:Any])->String{
        if parameters.isEmpty{
            return ""
        }
        else{
            var keyValuePairs = [String]() //array of strings
            
            for (key, value) in parameters{
                let stringValue = "\(value)"
                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
                
                keyValuePairs.append(key + "=" + "\(escapedValue!)")
            }
            return "?\(keyValuePairs.joined(separator: "&" ))"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

