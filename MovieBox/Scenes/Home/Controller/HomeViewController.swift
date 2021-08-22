//
//  HomeViewController.swift
//  MovieBox
//
//  Created by Emrullah Hancer on 21.08.2021.
//

import UIKit

protocol SelectMovieDelegate: AnyObject {
    func selectMovie(item: MoviesResults?)
}

final class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Variables
    var refresher: UIRefreshControl?
    var headerView: HomeHeaderView?
    lazy var viewModel: HomeViewModel = {
        let viewModel = HomeViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
        initRefresh()
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let navVc = navigationController {
          return navVc.viewControllers.count > 1
        }
        return false
    }
    
    // MARK: - initView
    func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerNib("HomeMovieCell")
        
        let height = UIScreen.main.bounds.width * 0.68266666666
        let width = tableView.frame.width
        headerView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        headerView?.delegate = self
        headerView?.viewModel = viewModel
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = .init()
        tableView.tableFooterView?.frame = .zero
    }
    
    // MARK: - initViewModel
    func initViewModel() {
        viewModel.reloadDataClosure = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.refresher?.endRefreshing()
                self.headerView?.viewModel = self.viewModel
                self.headerView?.collectionView.reloadData()
                self.tableView.reloadData()
            }
        }
        
        viewModel.getNowPlaying()
        viewModel.getUpcoming()
    }
    
    // MARK: - initRefresh
    func initRefresh() {
        refresher = UIRefreshControl()
        guard let refresher = refresher else { return }
        tableView.tableFooterView?.addSubview(refresher)
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refresher
    }
    
    @objc func refresh() {
        viewModel.page = 1
        viewModel.getNowPlaying(showLoading: false)
        viewModel.getUpcoming(showLoading: false)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.upComing?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width * 0.36266666666
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeMovieCell", for: indexPath) as? HomeMovieCell {
            cell.movie = viewModel.upComing?[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectMovie(item: viewModel.upComing?[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.upComing?.count ?? 0) - 1 {
            viewModel.page += 1
            viewModel.getUpcoming()
        }
    }
}

extension HomeViewController: SelectMovieDelegate {
    func selectMovie(item: MoviesResults?) {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.item = item
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
