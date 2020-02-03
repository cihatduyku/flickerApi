//
//  TableViewCell.swift
//  FlickrApi
//
//  Created by Cihat Duyku on 31.01.2020.
//  Copyright © 2020 Cihat Duyku. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var imgPhoto: UIImageView!
    
    private let loadImage = LoadImage()
    
    var photo: Photo? {
        didSet {
            configureView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func configureView(){
        guard let photo = photo else { return }
         txtTitle.text = photo.title
        
        loadImage.load(from: photo.getImagePath() ?? "" ,completion: { (image) -> Void in
            self.imgPhoto.image = image
        })
        
    }

}
