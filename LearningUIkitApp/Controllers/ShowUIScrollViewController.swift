//
//  ShowUIScrollViewController.swift
//  LearningUIkitApp
//
//  Created by qian tao on 16/1/11.
//  Copyright © 2016年 qian tao. All rights reserved.
//

import UIKit
import SnapKit

class ShowUIScrollViewController: UIViewController {
    
    // MARK: Properties
    let validZone = UIView()
    let pageControl = UIPageControl()
    let horizontalScrollView = UIScrollView()
    let containerView = UIView()
    let contentView = UIView()
    
    // init
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // lifecircle
    override func viewDidLoad() {
        
        //set controller's default view's background color
         self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        //layout scrollview
        layoutHorizontalScrollView()
        

        
    }
    
    // MARK: Actions
    func layoutHorizontalScrollView() {
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height
        let pageNumber = 3
    
        //限定视图中元素绘制和显示的区域
        view.addSubview(validZone)
        validZone.backgroundColor = UIColor.groupTableViewBackgroundColor()
        validZone.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(statusBarHeight + navigationBarHeight!)
            make.left.right.bottom.equalTo(view)
        }
        
        //为scrollview添加containerview，也用于作为scrollview中pages的外部参考对象
        validZone.addSubview(containerView)
        containerView.layer.borderColor = UIColor.grayColor().CGColor
        containerView.layer.borderWidth = 2
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = UIColor.whiteColor()
        containerView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(validZone).inset(15)
            make.bottom.equalTo(validZone).inset(30)
        }
        
        //添加scrollview中page对应的pageControl控件
        validZone.addSubview(pageControl)
        pageControl.currentPage = 1
        pageControl.numberOfPages = pageNumber
        pageControl.currentPageIndicatorTintColor = UIColor.orangeColor()
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl.addTarget(self, action: "scrollViewDidEndDecelerating:", forControlEvents: UIControlEvents.ValueChanged)
        pageControl.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(containerView)
            make.centerY.equalTo(containerView.snp_bottom).offset(15)
        }
        
        //向containerview添加scrollview并配置scrollview（按需配置）
        containerView.addSubview(horizontalScrollView)
        horizontalScrollView.backgroundColor = UIColor.redColor()
        horizontalScrollView.pagingEnabled = true
        horizontalScrollView.bounces = false
        horizontalScrollView.showsHorizontalScrollIndicator = false
        horizontalScrollView.showsVerticalScrollIndicator = false
        horizontalScrollView.delegate = self
        horizontalScrollView.layer.cornerRadius = 10
        horizontalScrollView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(containerView)
        }
        
        //向scrollview中添加内容视图
        horizontalScrollView.addSubview(contentView)
        contentView.backgroundColor = UIColor.lightGrayColor()
        contentView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(horizontalScrollView)
        }
        
        var pages = [UIView]()
        for i in 0..<pageNumber {
            let page = UIView()
            pages.insert(page, atIndex: i)
            contentView.addSubview(page)
            
            page.backgroundColor = UIColor.whiteColor()
            page.snp_makeConstraints(closure: { (make) -> Void in
                if i == 0 {
                    make.top.bottom.width.equalTo(containerView)
                }else {
                    make.top.height.width.equalTo(pages[i - 1])
                    make.left.equalTo(pages[i - 1].snp_right)
                }
            })
            
            let pageLabel = UILabel()
            pageLabel.text = "This is page\(i)"
            pageLabel.font = UIFont(name: "San Francisco", size: 64)
            page.addSubview(pageLabel)
            pageLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.center.equalTo(page)
            })
            
        }
        contentView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(pages.first!)
            make.right.equalTo(pages.last!)
        }
    }
}

// MARK: Delegates
extension ShowUIScrollViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / (scrollView.superview?.frame.width)!)
        pageControl.currentPage = index
    }
}