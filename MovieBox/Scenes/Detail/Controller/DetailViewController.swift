//
//  DetailViewController.swift
//  MovieBox
//
//  Created by Emrullah Hancer on 22.08.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    var item: MoviesResults?
    
    lazy var viewModel: DetailViewModel = {
        let viewModel = DetailViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    
    func initView() {
        tableView.registerNib("DetailCell")
        let height = UIScreen.main.bounds.width * 0.68266666666
        let width = tableView.frame.width
        imageView.sd_setImage(with: URL(string: APIManager.shared.imageUrl + (item?.bannerImage ?? "")))
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: width, height: height)
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
    }
    
    func initViewModel() {
        
        viewModel.reloadDataClosure = { [weak self] in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.getNowPlaying(id: item?.id ?? 0)
    }
}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as? DetailCell {
            cell.movie = viewModel.movie
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
