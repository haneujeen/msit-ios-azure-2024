//
//  UIViewController+URLUtilities.swift
//  CameraAlbumTest
//
//  Created by 한유진 on 3/28/24.
//

import UIKit
import UniformTypeIdentifiers

extension UIViewController {
    func urlWithFilename(_ filename: String, type: UTType) -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let fileURL = url.appendingPathComponent(filename, conformingTo: type)
        print(fileURL)
        
        return fileURL
    }
}
