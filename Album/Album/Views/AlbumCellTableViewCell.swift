//
//  AlbumCellTableViewCell.swift
//  Album
//
//  Created by Danya on 9/15/20.
//  Copyright © 2020 Danya. All rights reserved.
//

import UIKit

class AlbumCellTableViewCell: UITableViewCell {

    var feedResult:FeedResult? {
        didSet {
            guard let albumResult = feedResult else {return}
            if let imageURL = albumResult.imageUrl {
                albumImage.downloaded(from: imageURL)
            }
            if let albumNameText = albumResult.albumName {
               albumName.text = " \(albumNameText) "
            }
           
            if let artistNameText = albumResult.artistName {
                artistName.text = "\(artistNameText)"
            }
        }
    }
    
    let albumName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let artistName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        return lbl
    }()
    
     let albumImage: UIImageView = {
         let img = UIImageView()
         img.contentMode = .scaleAspectFill
         img.translatesAutoresizingMaskIntoConstraints = false
         img.layer.cornerRadius = 35
         img.clipsToBounds = true
        return img
     }()
    
    let containerView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true
      return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(albumImage)
        self.containerView.addSubview(albumName)
        self.containerView.addSubview(artistName)
        self.contentView.addSubview(self.containerView)
        
        albumImage.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        albumImage.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        albumImage.widthAnchor.constraint(equalToConstant:70).isActive = true
        albumImage.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.albumImage.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        albumName.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        albumName.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        albumName.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        artistName.topAnchor.constraint(equalTo:self.albumName.bottomAnchor).isActive = true
        artistName.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
