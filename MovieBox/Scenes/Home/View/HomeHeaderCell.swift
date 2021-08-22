//
//  HomeHeaderCell.swift
//  MovieBox
//
//  Created by Emrullah Hancer on 22.08.2021.
//

import UIKit

final class HomeHeaderCell: UICollectionViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var graidentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    //MARK: - Variables
    let dateFormatter = DateFormatter()
    let dateFormatterTitle = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatterTitle.dateFormat = "yyyy"
        graidentView.alpha = 0.4
    }
    
    override func layoutSubviews() {
        let colorTop =  UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 67.0/255.0, green: 67.0/255.0, blue: 67.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = graidentView.bounds
                
        graidentView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    var movie: MoviesResults? {
        didSet {
            mainImage.sd_setImage(with: URL(string: APIManager.shared.imageUrl + (movie?.bannerImage ?? "")))
            descriptionLabel.text = movie?.overview
            var dateOfTitle: String?
            if let date = dateFormatter.date(from: movie?.date ?? "") {
                dateOfTitle = dateFormatterTitle.string(from: date)
            }
            titleLabel.text = "\(movie?.title ?? "") (\(dateOfTitle ?? ""))"
        }
    }
}
