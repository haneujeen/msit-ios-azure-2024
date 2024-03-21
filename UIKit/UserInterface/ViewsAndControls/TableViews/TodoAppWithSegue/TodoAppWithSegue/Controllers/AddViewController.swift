//
//  AddViewController.swift
//  TodoAppWithSegue
//
//  Created by 한유진 on 3/21/24.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var imageSelected: String?
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var symbolView: UIView!
    @IBOutlet weak var symbolImageView: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        picker.dataSource = self
        picker.delegate = self
        
        symbolView.layer.cornerRadius = 10
        symbolView.layer.borderWidth = 0.5
        symbolView.layer.borderColor = UIColor.lightGray.cgColor
        
        symbolImageView.image = UIImage(named: symbols[0])
        
        symbolLabel.text = symbols[0]
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        guard let text = textField.text else { return }
        items.append(text)
        itemImages.append(imageSelected ?? "clock")
        textField.text = imageSelected
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        symbols.count
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.frame.width, height: 30))

        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        imageView.image = UIImage(named: symbols[row])
        view.addSubview(imageView)
        
        let label = UILabel(frame: CGRect(x: 30, y: 5, width: pickerView.frame.width - 35, height: 20))
        label.text = symbols[row]
        view.addSubview(label)
        
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        imageSelected = itemImages[row]
        symbolImageView.image = UIImage(named: itemImages[row])
        symbolLabel.text = itemImages[row]
    }
}
