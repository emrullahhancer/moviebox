//
//  HomeMovieCell.swift
//  MovieBox
//
//  Created by Emrullah Hancer on 22.08.2021.
//

import UIKit
import SDWebImage

final class HomeMovieCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var borderView: UIView!
    //MARK: - Variables
    let dateFormatter = DateFormatter()
    let dateFormatterTitle = DateFormatter()
    let dateFormatterDate = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        mainImage.layer.masksToBounds = true
        mainImage.layer.cornerRadius = 10
        borderView.backgroundColor = .lightGray
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatterTitle.dateFormat = "yyyy"
        dateFormatterDate.dateFormat = "dd.MM.yyyy"
        titleLabel.textColor = .textBlack
        descriptionLabel.textColor = .textGray
        dateLabel.textColor = .textGray
    }
    
    var movie: MoviesResults? {
        didSet {
            mainImage.sd_setImage(with: URL(string: APIManager.shared.imageUrl + (movie?.posterImage ?? "")))
            descriptionLabel.text = movie?.overview
            var dateOfTitle: String?
            var dateOfDate: String?
            if let date = dateFormatter.date(from: movie?.date ?? "") {
                dateOfTitle = dateFormatterTitle.string(from: date)
                dateOfDate = dateFormatterDate.string(from: date)
            }
            dateLabel.text = dateOfDate
            titleLabel.text = "\(movie?.title ?? "") (\(dateOfTitle ?? ""))"
        }
    }
}
