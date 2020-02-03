//
//  PhotosDetailViewController.swift
//  FlickrApi
//
//  Created by Cihat Duyku on 1.02.2020.
//  Copyright © 2020 Cihat Duyku. All rights reserved.
//

import UIKit

class PhotosDetailViewController: UIViewController {

    @IBOutlet weak var imgDetail: UIImageView!
    
    var img = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imgDetail.image = img
    }

}
