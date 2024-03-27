//
//  MainTableViewController.swift
//  PListTest_Bundle2
//
//  Created by 한유진 on 3/26/24.
//

import UIKit

class MainTableViewController: UITableViewController {
    var parks: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        guard let destination = urlWithFilename("parks.plist"),
              let source = Bundle.main.url(forResource: "parks.plist", withExtension: nil)
        else { fatalError() }
        
        try? FileManager.default.copyItem(at: source, to: destination)
        
        parks = try? NSMutableArray(contentsOf: destination, error: ())
    }
    
    @IBAction func unwindFromAddViewController(seque: UIStoryboardSegue) {
        guard let parks else { return }
        let indexPath = IndexPath(row: parks.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .fade)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return parks?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let imageView = cell.viewWithTag(1) as? UIImageView
        let label1 = cell.viewWithTag(2) as? UILabel
        let label2 = cell.viewWithTag(3) as? UILabel
        let label3 = cell.viewWithTag(4) as? UILabel
        
        // Configure the cell...
        let park = parks?[indexPath.row] as? [String:String]
        imageView?.image = UIImage(named: park?["imageName"] ?? "default")
        label1?.text = park?["name"]
        label2?.text = park?["category"]
        label3?.text = park?["city"]
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == 0 {
            return .insert
        }
        return .delete
        
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            parks?.removeObject(at: indexPath.row)
            if let url = urlWithFilename("parks.plist") {
                try? parks?.write(to: url)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            let newPark = ["name": "Lake Umbagog",
                           "category": "Lakes",
                           "city": "Errol",
                           "imageName": "umbagog"]
            parks?.insert(newPark, at: indexPath.row)
            tableView.insertRows(at: [indexPath], with: .fade)
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        if let park = parks?[fromIndexPath.row], let url = urlWithFilename("parks.plist") {
            parks?.removeObject(at: fromIndexPath.row)
            parks?.insert(park, at: to.row)
            try? parks?.write(to: url)
        }
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detail" {
            guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
            let detailView = segue.destination as? DetailViewController
            guard let park = parks?[indexPath.row] as? [String:String] else {
                return
            }
            detailView?.park = park
        } else {
            let addView = segue.destination as? AddViewController
            addView?.parks = self.parks
        }
    }
}
