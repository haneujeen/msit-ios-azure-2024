//
//  UIViewController+URLUtilities.swift
//  PListTest_Bundle2
//
//  Created by 한유진 on 3/27/24.
//

import UIKit

extension UIViewController {
    func urlWithFilename(_ filename: String) -> URL? {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        /*
         file:///Users/haneujeen/Library/Developer/CoreSimulator/Devices/80A56BAF-76DB-4DE6-8D97-CA6B58984D13/data/Containers/Data/Application/CA9FC0A6-B045-43B8-8A7C-9B5C04BF0F73/Documents/
         */
        let fileURL = url.appendingPathComponent(filename, conformingTo: .propertyList)
        /*
         file:///Users/haneujeen/Library/Developer/CoreSimulator/Devices/80A56BAF-76DB-4DE6-8D97-CA6B58984D13/data/Containers/Data/Application/47B1F336-C350-494F-869D-43811C3E3285/Documents/parks.plist
         */
        return fileURL
    }
}
