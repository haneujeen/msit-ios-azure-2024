//
//  UIViewController+Alert.swift
//  Twitter
//
//  Created by 한유진 on 5/8/24.
//

import UIKit

extension UIViewController {
    func showAlertWithSingleAction(title: String? = nil, message: String?, handler: ((UIAlertAction)->Void)? = nil) {
        let action = UIAlertAction(title: "Close", style: .default, handler: handler)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
