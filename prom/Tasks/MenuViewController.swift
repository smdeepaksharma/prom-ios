//
//  MenuViewController.swift
//  prom
//
//  Created by Deepak Sharma S M on 4/15/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit
import InitialsImageView

class MenuViewController: UITableViewController {
    

    @IBOutlet weak var addMemberButton: UIButton!
    
    @IBOutlet weak var avatarsView: UICollectionView!
    let members = ["Deepak Sharma", "Harish Kithane", "Raghav Kishan", "Rakshit Ramesh", "Pradeep Ma"]
    
    let colors = [UIColor.blue, UIColor.black, UIColor.red,UIColor.green, UIColor.blue,]

    override func viewDidLoad() {
        self.avatarsView.delegate = self
        self.avatarsView.dataSource = self
        
        addMemberButton.backgroundColor = .clear
        addMemberButton.layer.cornerRadius = 6
        addMemberButton.layer.borderWidth = 1
        addMemberButton.layer.borderColor = UIColor.gray.cgColor
    }

    
}


extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell",for: indexPath) as! AvatarCellCollectionViewCell
    
        cell.imageView.setImageForName(string: members[indexPath.row], backgroundColor: UIColor.gray, circular: true, textAttributes: nil)
        return cell
     
    }
}
