//
//  PostsViewController.swift
//  Collabgram
//
//  Created by Dinaol Melak on 12/24/19.
//  Copyright © 2019 Dinaol Melak. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Parse

class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let custom = Customfunctions()
    var posts = [PFObject]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    DataRequest.addAcceptableImageContentTypes(["application/octet-stream"])
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20
        
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }else{
                self.custom.showAlert(title: "No Data", message: "Apologies!, but their is no data in database")
            }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let post = posts[indexPath.row]
        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        cell.usernameLabel2.text = user.username
        cell.userpostLabel.text = post["caption"] as? String
        
        
        let imageFile = post["image"] as! PFFileObject
//        let image = imageFile.url!
//        let imageURL = URL(string: image)!
        //print(imageURL)
        cell.postImageView.af_setImage(withURL: URL(string: imageFile.url!)!)
        
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
