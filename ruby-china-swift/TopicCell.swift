//
//  TopicCell.swift
//  ruby-china-swift
//
//  Created by kaka on 16/1/28.
//  Copyright © 2016年 kaka. All rights reserved.
//
import UIKit
import SnapKit

class TopicCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var avatar = UIImageView()
    var author = UILabel()
    var create_at = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.avatar)
        self.contentView.addSubview(self.author)
        self.contentView.addSubview(self.create_at)
        
        self.titleLabel.numberOfLines = 0
        self.titleLabel.lineBreakMode =  NSLineBreakMode.ByCharWrapping
        self.titleLabel.font = UIFont.systemFontOfSize(15)
        
        self.avatar.multipleTouchEnabled = true
        self.avatar.userInteractionEnabled = true
        self.avatar.layer.masksToBounds = true
        self.avatar.layer.cornerRadius = 5

        self.author.font = UIFont.boldSystemFontOfSize(15)
        self.create_at.textColor = UIColor.grayColor()
        self.create_at.font = UIFont.systemFontOfSize(12)
        
        let padding: UIEdgeInsets = UIEdgeInsetsMake(5, 8, 5, 8)
        
        self.avatar.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(padding.top)
            make.left.equalTo(padding.left)
            make.width.equalTo(45)
            make.height.equalTo(45)
        }

        self.author.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(padding.top)
            make.left.equalTo(self.avatar.snp_right).inset(-8)
        }
        
        self.titleLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.author.snp_bottom).offset(8)
            make.left.equalTo(self.avatar.snp_right).inset(-8)
            make.right.equalTo(-padding.right)
        }
        
        self.create_at.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(-padding.right)
            make.centerY.equalTo(self.author)
        }
        self.contentView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
            make.bottom.equalTo(self.titleLabel.snp_bottom).inset(-padding.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(data: Topic) {
        self.titleLabel.text = data.title
        self.author.text = data.user!.login
        self.create_at.text = data.createdAtAgo()
        self.avatar.sd_setImageWithURL(NSURL(string: data.user!.avatar_url!))
        self.setNeedsLayout()
        self.tag = data.id!
    }
    
}
