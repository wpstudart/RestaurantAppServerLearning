//
//  MenuController.swift
//  Restaurant
//
//  Created by Aluno on 23/05/2018.
//  Copyright © 2018 wpstudart. All rights reserved.
//

import Foundation
import UIKit

class MenuController {
    let baseURL = URL(string: "http://localhost:8090")!
    static let shared = MenuController()
    
    /*
     Review the list of server endpoints at the beginning of this project. For the request to
     categories, you know that there are no query parameters or additional data to send and that the
     response JSON will contain an array of strings. So the method should have one parameter: a
     completion closure that uses an array of strings.
     */
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            if let data = data,
                let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any], let categories = jsonDictionary?["categories"] as? [String] {
                completion(categories)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    /*
     The request to /menu includes a query parameter: the category string. The JSON that's returned
     contains an array of dictionaries, and you'll want to deserialize each dictionary into a MenuItem
     object. So the method that will perform the request to
     /menu should have two parameters: the category string and a completion closure that takes in an
     array of MenuItem objects:
     */
    func fetchMenuItems(categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name:"category", value: categoryName)]
        let menuURL = components.url!
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            // Proper Error Handling
            
//            if let data = data {
//
//                do {
//                    let menuItems = try jsonDecoder.decode(MenuItems.self, from: data)
//
//                    completion(menuItems.items)
//                } catch let error {
//                    print("\(error.localizedDescription)")
//                    completion(nil)
//                }
//
//            } else {
//                completion(nil)
//            }
            
            if let data = data,
                let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                completion(menuItems.items)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    /*
     The POST to /order will need to include the collection of menu item IDs, and the response will
     include an integer specifying the number of minutes the order will take to prep. The method
     that will perform this network call should have two parameters: an array of integers to hold
     the IDs and a completion closure that takes in the order prep time.
     */
    func submitOrder(menuIds: [Int],  completion: @escaping (Int?)-> Void){
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data: [String: [Int]] = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
}


