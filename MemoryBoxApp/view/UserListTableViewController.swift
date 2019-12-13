//
//  UserListTableViewController.swift
//  MemoryBoxApp
//
//  Created by Duncan Levings on 2019-12-10.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import UIKit

class UserListTableViewController: UITableViewController {
    
    var memoryUID: String = ""
    
    private var userList = [User]()
    let userController = UserController()
    let memoryController = MemoryController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadUsers()
    }
    
    func loadUsers() {
        self.userController.getAllUser() { list in
            self.userList = list
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_user", for: indexPath) as! UserCell
        
        if indexPath.row < userList.count
        {
            let user = userList[indexPath.row]
            cell.userName.text = user.firstName + " " + user.lastName
            if (user.userMemory.contains(self.memoryUID)) {
                cell.isUserInteractionEnabled = false
                cell.backgroundColor = UIColor.green
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_user", for: indexPath) as! UserCell
        
        if indexPath.row < userList.count
        {
            let user = userList[indexPath.row]
            self.memoryController.updateUserMemory(userUID: user.userUID, memoryUID: self.memoryUID)
            user.userMemory.append(self.memoryUID)
            
            self.tableView.reloadData()
        }
//        let memory = memoryList[indexPath.row]
//        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let detailsVC = mainSB.instantiateViewController(withIdentifier: "DetailsScene") as! MemoryDetailViewController
//        detailsVC.memory = memory
//        navigationController?.pushViewController(detailsVC, animated: true)
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
