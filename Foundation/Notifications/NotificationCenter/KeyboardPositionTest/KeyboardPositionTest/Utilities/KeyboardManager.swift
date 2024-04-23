//
//  KeyboardManager.swift
//  KeyboardPositionTest
//
//  Created by 한유진 on 4/18/24.
//

import UIKit

struct KeyboardManager {
    static func keyboardWillShow(notification: Notification, textField: UITextField?, origin: CGPoint?,originalSize: CGSize?) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let textField,
              let origin,
              let originalSize
        else { return }
                
        textField.frame = CGRect(x: origin.x,
                                 y: UIScreen.main.bounds.height - keyboardFrame.height - originalSize.height - 70,
                                 width: originalSize.width,
                                 height: originalSize.height)
    }
    
    static func keyboardWillHide(textField: UITextField?, origin: CGPoint?, originalSize: CGSize?) {
        guard let textField, let origin, let originalSize else { return }
        textField.frame = CGRect(origin: origin, size: originalSize)
    }
}
