//
//  BaseListController.swift
//  ruby-china-swift
//
//  Created by kaka on 16/1/26.
//  Copyright © 2016年 kaka. All rights reserved.
//

import UIKit

class BaseTopicListController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    var dataSource: [Topic] = []
    let identid = "cellid"
    var refreshControl = UIRefreshControl()
    var page = 1
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell: TopicCell? = tableView.dequeueReusableCellWithIdentifier(identid) as? TopicCell
        if(cell == nil){
            cell = TopicCell(style: UITableViewCellStyle.Default, reuseIdentifier: identid)
        }
        let topic = dataSource[indexPath.row] as? Topic
        cell?.bind(topic!)
        cell?.titleLabel.numberOfLines = 0
        cell?.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(tableView.bounds)
        if(indexPath.row == dataSource.count-1){
            page += 1
            loadMore()
        }
        
        return cell!;
    }
        
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("topicDetail") as? TopicDetailController
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        controller?.topicId = cell?.tag
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    func loadMore(){
        
    }
    
    
    func loadRefreshControl(tableView: UITableView){
        refreshControl.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "松手刷新")
        tableView.addSubview(refreshControl)
    }
    
    
    func refreshData(){
        refreshControl.endRefreshing()
    }

}
