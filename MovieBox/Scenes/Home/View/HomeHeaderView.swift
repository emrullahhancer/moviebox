//
//  HomeHeaderView.swift
//  MovieBox
//
//  Created by Emrullah Hancer on 22.08.2021.
//

import UIKit

@IBDesignable final class HomeHeaderView: UIView {
    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    //MARK: - Variables
    weak var delegate: SelectMovieDelegate?
    var viewModel: HomeViewModel? {
        didSet {
            collectionView.reloadData()
            pageControl.numberOfPages = viewModel?.nowPlaying?.count ?? 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let view = loadNib()
        view.frame = self.bounds
        addSubview(view)

        let width = UIScreen.main.bounds.width
        let height = width * 0.68266666666
        var flowLayout: UICollectionViewFlowLayout {
            let _flowLayout = UICollectionViewFlowLayout()
            _flowLayout.itemSize = CGSize(width: width, height: height)
            _flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            _flowLayout.scrollDirection = .horizontal
            _flowLayout.minimumLineSpacing = 0.0
            _flowLayout.minimumInteritemSpacing = 0.0
            return _flowLayout
        }
        collectionView.registerNib("HomeHeaderCell")
        collectionView.collectionViewLayout = flowLayout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        pageControl.currentPage = indexPath.row
    }
    
    @IBAction func pageControlAction(_ sender: UIPageControl) {
        var frame = self.collectionView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        self.collectionView.scrollRectToVisible(frame, animated: true)
    }
}


extension HomeHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.nowPlaying?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHeaderCell", for: indexPath) as? HomeHeaderCell {
            cell.movie = viewModel?.nowPlaying?[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectMovie(item: viewModel?.nowPlaying?[indexPath.row])
    }
}
