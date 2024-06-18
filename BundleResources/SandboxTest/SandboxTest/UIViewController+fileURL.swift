//
//  UIViewController+fileURL.swift
//  SandboxTest
//
//  Created by 한유진 on 6/18/24.
//

import UIKit
import UniformTypeIdentifiers

extension UIViewController {
    func fileURL(_ filename: String, type: UTType = .png) -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent(filename, conformingTo: type)
    }
}
