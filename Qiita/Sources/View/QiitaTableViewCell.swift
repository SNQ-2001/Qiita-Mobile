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

    public func setCell(profileImageURL: String, id: String, name: String, publishedAt: String, title: String, tags: [Tag], LGTM: Int) {

        // プロフィール画像を設定
        guard let url = URL(string: profileImageURL) else { return }
        profileImage.af.setImage(
            withURL: url,
            placeholderImage: UIImage(named: "default"),
            imageTransition: .crossDissolve(0.5)
        )

        // idを設定
        if name == "" {
            nameLabel.text = "@\(id)"
        } else {
            nameLabel.text = "@\(id)（\(name)）"
        }

        // 投稿日を設定
        guard let publishedData = stringToDate(string: publishedAt.match(#"[0-9]{4}-[0-9]{2}-[0-9]{2}"#)[0], format: "yyyy-MM-dd") else { return }

        guard let publishedString = dateToString(date: publishedData, format: "yyyy年MM月dd日") else { return }

        publishedAtLabel.text = "\(publishedString)"

        // タイトルを設定
        titleLabel.text = title

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

    func dateToString(date: Date, format: String) -> String? {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    func stringToDate(string: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = format
        return formatter.date(from: string)
    }
}
