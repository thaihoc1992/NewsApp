//
//  NewsTableViewCell.swift
//  newsApp
//
//  Created by ADMIN on 6/24/21.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleNewsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var separateView: UIView!
    var article: Article? {
        didSet {
            if let article = article {
                if article.urlToImage != "" {
                    let url = URL(string: article.urlToImage)
                    photoImageView.kf.setImage(with: url)
                } else {
                    photoImageView.image = UIImage(named: "default")
                }
                titleNewsLabel.text = article.title
                timeLabel.text = String(article.publishedAt.prefix(10))
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoImageView.contentMode = .scaleAspectFill
        titleNewsLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleNewsLabel.numberOfLines = 3
        timeLabel.font = UIFont.systemFont(ofSize: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

