//
//  MemoryTableViewController.swift
//  MemoryBoxApp
//
//  Created by Duncan Levings on 2019-11-14.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import FirebaseStorage
import FirebaseFirestore
import Kingfisher
import UIKit

class MemoryTableViewController: UITableViewController {
    
    private var memoryList = [Memory]()
    
    let memoryController = MemoryController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadMemories()
    }
    
    func loadMemories() {
        self.memoryController.getAllMemories() { list in
            self.memoryList = list
            self.tableView.reloadData()
        }
    }
    
    func downloadImg(imageView: UIImageView, uid: String) {
        let query = Firestore.firestore()
            .collection("imagesCollection")
            .whereField("uid", isEqualTo: uid)
        
        query.getDocuments { (snapshot, err) in
            if let err = err {
                print("\(err.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot,
                let data = snapshot.documents.first?.data(),
                let urlString = data["imageUrl"] as? String,
                let url = URL(string: urlString) else {
                print("Something went wrong with uploading image!")
                return
            }
            
            let resource = ImageResource(downloadURL: url)
            imageView.kf.setImage(with: resource, completionHandler: { (result) in
                switch result {
                case .success(_):
                    print("successfully downloaded image from database")
                case .failure(let err):
                    print("\(err.localizedDescription)")
                }
            })
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_memory", for: indexPath) as! MemoryCell
        
        if indexPath.row < memoryList.count
        {
            let memory = memoryList[indexPath.row]
            cell.memoryName.text = memory.memoryName
            cell.memoryDesc.text = memory.memoryDesc
            self.downloadImg(imageView: cell.memoryImg, uid: memory.memoryImage)
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
