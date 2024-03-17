//
//  TableViewController.swift
//  TodoApp
//
//  Created by 한유진 on 3/17/24.
//

import UIKit

class TableViewController: UITableViewController, UITextFieldDelegate {
    // MARK: - Properties
    var items = [TodoItem]()
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        configureGestureRecognizers()
        loadItemsFromJSON()
    }
    
    // MARK: - Configuration
    private func configureGestureRecognizers() {
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        tableView.addGestureRecognizer(doubleTapRecognizer)
    }
    
    private func loadItemsFromJSON() {
        let filename = "landmarkData"
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            items = try JSONDecoder().decode([TodoItem].self, from: data)
            tableView.reloadData()
        } catch {
            fatalError("Couldn't parse \(filename) as \(TodoItem.self):\n\(error)")
        }
    }
    
    // MARK: - Gesture Handling
    @objc func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: tableView)
        if let indexPath = tableView.indexPathForRow(at: location) {
            items[indexPath.row].isCompleted.toggle()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        var config = cell.defaultContentConfiguration()
        config.text = item.title
        
        if item.isCompleted {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.contentConfiguration = config

        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Actions
    @IBAction func editingDidEnd(_ sender: Any) {
        guard let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else {
            return
        }
        
        items.append(TodoItem(id: Int.random(in: 1..<1000), title: text, isCompleted: false))
        
        textField.text = ""
        tableView.reloadData()
    }
}

