//
//  DataStore.swift
//  ios_app
//
//  Created by Jack Hu on 2020-11-23.
//

import Foundation
import UIKit

// this will store our uploaded pictures and documents of covid exposure
struct DataStore {
    
    // initialize data structures
    var imageExposureResults = [UIImage]()
    var documentExposureResults = [UIDocument]()
    
    // adding images and documents to our arrays
    mutating func addExposureResultsImages(_ imageView:UIImage) {
        self.imageExposureResults.append(imageView)
    }
    
    // adding images and documents to our arrays
    mutating func addExposureResultsDocs(_ document:UIDocument) {
        self.documentExposureResults.append(document)
    }
    
    
    // clear the data structures
    mutating func clearExposureResults() {
        self.imageExposureResults.removeAll()
        self.documentExposureResults.removeAll()
    }
}
