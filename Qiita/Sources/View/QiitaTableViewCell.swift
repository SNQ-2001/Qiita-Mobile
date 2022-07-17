//
//  HomeTableViewCell.swift
//  Qiita
//
//  Created by 宮本大新 on 2022/07/12.
//

import UIKit
import AlamofireImage

class QiitaTableViewCell: UITableViewCell {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var publishedAtLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tagLabel: UILabel!
    @IBOutlet var LGTMLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func setCell(profileImageURL: String, title: String, id: String, name: String, tags: [Organization], LGTM: Int) {

        // プロフィール画像を設定
        profileImage.af.setImage(
            withURL: URL(string: profileImageURL)!,
            placeholderImage: UIImage(named: "twitter_LdZznZea_400x400"),
            imageTransition: .crossDissolve(0.5)
        )

        // タイトルを設定
        titleLabel.text = title

        // idを設定
        if name == "" {
            nameLabel.text = "@\(id)"
        } else {
            nameLabel.text = "@\(id)（\(name)）"
        }

        // タグを設定
        var allTag: String = ""
        for tag in 0..<tags.count {
            if tags.count == tag + 1 {
                allTag += "\(tags[tag].name)"
            } else {
                allTag += "\(tags[tag].name), "
            }
        }

        tagLabel.font = UIFont(name: "FontAwesome", size: 14)
        tagLabel.text = String.FontAwesome(unicode: "f02b") + " " + allTag

        LGTMLabel.text = String(LGTM)
    }
    
}
