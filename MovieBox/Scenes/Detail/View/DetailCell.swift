//
//  DetailCell.swift
//  MovieBox
//
//  Created by Emrullah Hancer on 22.08.2021.
//

import UIKit

final class DetailCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var totalRateLabel: UILabel!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imdbLogo: UIImageView!
    // MARK: - Variables
    let dateFormatter = DateFormatter()
    let dateFormatterTitle = DateFormatter()
    
    var movie: MoviesResults? {
        didSet {
            rateLabel.text = "\(movie?.vote ?? 0)"
            var dateOfTitle: String?
            if let date = dateFormatter.date(from: movie?.date ?? "") {
                dateOfTitle = dateFormatterTitle.string(from: date)
            }
            dateLabel.text = dateOfTitle
            titleLabel.text = movie?.title
            descriptionLabel.text = movie?.overview
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatterTitle.dateFormat = "dd.MM.yyyy"
        rateLabel.textColor = .textBlack
        totalRateLabel.textColor = .darkGray
        dateLabel.textColor = .textBlack
        titleLabel.textColor = .textBlack
        descriptionLabel.textColor = .textBlack
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imdbOpen))
        imdbLogo.isUserInteractionEnabled = true
        imdbLogo.addGestureRecognizer(gesture)
    }
    
    @objc func imdbOpen() {
        guard let url = URL(string: "https://www.imdb.com/title/\(movie?.imdb_id ?? "")") else { return }
        UIApplication.shared.open(url)
    }
    
}
