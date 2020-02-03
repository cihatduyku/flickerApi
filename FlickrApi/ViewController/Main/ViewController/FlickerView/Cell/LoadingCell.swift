//
//  LoadingCell.swift
//  FlickrApi
//
//  Created by Cihat Duyku on 31.01.2020.
//  Copyright © 2020 Cihat Duyku. All rights reserved.
//

import UIKit

class LoadingCell : UITableViewCell {
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    func setupSubviews() {
        activityIndicatorView.startAnimating()
    }
}
