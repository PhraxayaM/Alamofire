//
//  ViewController.swift
//  Lesson10
//
//  Created by Thomas Vandegriff on 2/26/19.
//  Copyright © 2019 Make School. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var urlSessionPostBtn: UIButton!
    @IBOutlet weak var alamofirePostBtn: UIButton!
    
    var urlSessionApiService = URLSessionApiService()
    
    // TODO: Create var for AlamoFireApiService
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    @IBAction func urlSessionPostBtnClicked(_ sender: Any) {
        
        let endpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        Alamofire.request(endpoint).responseJSON { response in
            guard response.result.error == nil else {
                print(response.result.error!)
                return
            }
            guard let json = response.result.value as? [String: Any] else {
                print("Error: \(response.result.error)")
                return
            }
            guard let title = json["title"] as? String else {
                print("Could not find title")
                return
            }
            print("The title is: " + title)
        }
        
        guard let url = URL(string: endpoint) else {
            print("error creating the URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        // creating the URLSession
        let session = URLSession(configuration: .default)
        // creating the data task
        let task = session.dataTask(with: urlRequest) {(data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling the endpoint")
                print(error!)
                return
            }
            // validate data
            guard let responseData = data else {
                print("error receiving data")
                return
            }
            // parse the result as JSON
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error converting data to JSON")
                        return
                }
                // if everything is fine, we get a JSON object. We want to print the title of the todo object.
                guard let title = todo["title"] as? String else {
                    print("couldn't find title")
                    return
                }
                print("The title is: " + title)
            } catch  {
                print("error converting data to JSON")
                return
            }
        }
        task.resume()
    }
    
    @IBAction func alamofirePostBtnClicked(_ sender: Any) {
        
        // TODO: Call HTTP Post function on AlamoFireApiService instance
        
        let url = "https://jsonplaceholder.typicode.com/todos"
        
        let parameters: Parameters = ["title": "Super Cool Post", "completed": 0, "userId": 8]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                guard response.result.error == nil else {
                    print(response.result.error!)
                    return
                }
                guard let json = response.result.value as? [String: Any] else {
                    print("Error: \(response.result.error)")
                    return
                }
                guard let title = json["title"] as? String else {
                    print("Could not find title")
                    return
                }
                print(json)
        }
        
        

    }
    
    
    
}

