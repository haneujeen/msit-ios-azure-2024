//
//  MyTableView.swift
//  UIViewRepresentableTest
//
//  Created by 한유진 on 5/14/24.
//

import SwiftUI
import UIKit

struct MyTableView: UIViewRepresentable {
    func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = context.coordinator
        
        return tableView
    }
    
    func updateUIView(_ uiView: UITableView, context: Context) {
//        // context.coordinator = makeCoordinator()
//        uiView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        uiView.dataSource = context.coordinator
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
        func numberOfSections(in tableView: UITableView) -> Int {
            1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            10
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            var config = cell.defaultContentConfiguration()
            config.text = "\(indexPath.row) 번째 행"
            cell.contentConfiguration = config
            
            return cell
        }
    }
}

#Preview {
    MyTableView()
}
