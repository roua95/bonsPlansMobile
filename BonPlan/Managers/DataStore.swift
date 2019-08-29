//
//  DataStore.swift
//  BonPlan
//
//  Created by DEVLOPER on 28/03/2019.
//  Copyright © 2019 DEVLOPER. All rights reserved.
//

import Foundation
import UIKit

final class DataStore {
    
    static let sharedInstance = DataStore()
    fileprivate init() {}
    
    var categories: [Categorie] = []
    var images: [UIImage] = []
    
    func getCategories(completion: @escaping () -> Void) {
        
        /*WebServiceBP.getCategories { (json) in
            let feed = json?["feed"] as? AudiobookJSON
            if let results = feed?["results"] as? [AudiobookJSON] {
                for dict in results {
                    let newAudiobook = Audiobook(dictionary: dict)
                    self.audiobooks.append(newAudiobook)
                }
                completion()
            }
        }*/
    }
    
    func getCategoriesImages(completion: @escaping () -> Void) {
        /*getCategories {
            for categorie in self.categories {
                let url = URL(string: categorie.image)
                let data = try? Data(contentsOf: url!)
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self.images.append(image!)
                }
            }
            OperationQueue.main.addOperation {
                completion()
            }*/
        }
}

