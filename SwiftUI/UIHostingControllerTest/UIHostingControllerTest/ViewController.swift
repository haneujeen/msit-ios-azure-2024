//
//  ViewController.swift
//  UIHostingControllerTest
//
//  Created by 한유진 on 5/14/24.
//

import UIKit
import SwiftUI

struct ImageView: View {
    var body: some View {
        VStack {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
        }
    }
}

final class HostingViewController: UIHostingController<ImageView> { }

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapped(_ sender: Any) {
        let controller = HostingViewController(rootView: ImageView())
        present(controller, animated: true)
    }
    
}

