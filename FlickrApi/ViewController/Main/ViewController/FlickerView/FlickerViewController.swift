//
//  FlickerViewController.swift
//  FlickrApi
//
//  Created by Cihat Duyku on 28.01.2020.
//  Copyright © 2020 Cihat Duyku. All rights reserved.
//

import UIKit

class FlickerViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView! {
        didSet {
            mainTableView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
        }
    }
    private var isLoadingDone = false;
    private let photoDetailSegueIdentifier = "photoDetail"
    private let loadImage = LoadImage()
    
    lazy var viewModel: FlickerViewModel = {
        let vm = FlickerViewModel()
        vm.delegate = self
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getValues()
        
    }
}

extension FlickerViewController:  UITableViewDelegate, UITableViewDataSource ,UIScrollViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.viewModel.allPhotos.count
        return count + 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = UIStoryboard(name: "Main", bundle: nil)
        let vc = str.instantiateViewController(withIdentifier: "photosDetail") as! PhotosDetailViewController
        loadImage.load(from: self.viewModel.allPhotos[indexPath.row].getImagePath()! ,completion: { (image) -> Void in
            vc.img=image
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == self.viewModel.allPhotos.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
            cell.setupSubviews()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
            let photo = self.viewModel.allPhotos[indexPath.row]
            cell.photo = photo
            
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mainTableView{
            if ((scrollView.contentOffset.y + scrollView.frame.size.height ) >= (scrollView.contentSize.height + 200)){
                if(isLoadingDone)
                {
                    isLoadingDone = false
                    self.viewModel.getValues()
                }
            }
        }
    }
}

extension FlickerViewController: FlickerViewModelDelegate {
    func requestCompleted() {
        isLoadingDone = true
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
}

