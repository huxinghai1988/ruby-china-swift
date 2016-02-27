//
//  TopicDetailController.swift
//  ruby-china-swift
//
//  Created by kaka on 16/1/31.
//  Copyright © 2016年 kaka. All rights reserved.
//

import UIKit

class TopicDetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var topicId: Int!
    var topic: Topic?
    var replies: [Reply]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.title = "帖子详情"
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.footerViewForSection(0)
        
        ClientApi.topic(topicId){ (topic) -> Void in
            self.topic = topic
            ClientApi.topicReplies(self.topicId){(replies: [Reply])
                -> Void in
                self.replies = replies
                self.tableView.reloadData()
            }
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.topic != nil){
            return self.replies!.count + 1;
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            var topicCell: TopicDetailCell?
            topicCell = TopicDetailCell(style: UITableViewCellStyle.Default, reuseIdentifier: "topicHeader")
            topicCell?.bind(self.topic!)
            topicCell?.selectionStyle = UITableViewCellSelectionStyle.None
            return topicCell!
        }else{
            var replyCell: ReplyCell?
            replyCell = ReplyCell(style: UITableViewCellStyle.Default, reuseIdentifier: "replyHeader")
            replyCell?.bind(self.replies![indexPath.row-1])
            return replyCell!
        }
    }
    
}
