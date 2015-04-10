//
//  FFDayCalendarView.swift
//  FFCalendar
//
//  Created by Hive on 4/10/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

protocol FFDayCalendarViewDelegate {
    
    func setNewDictionary(dict: Dictionary<NSDate, Array<FFEvent>>)
}

// MARK: -

class FFDayCalendarView: UIView, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    
    var delegate: FFDayCalendarViewDelegate?
    var dictEvents: Dictionary<NSDate, Array<FFEvent>>?
    
    private var collectionViewHeaderDay: FFDayHeaderCollectionView!
    private var dayContainerScroll: FFDayScrollView!
    private var viewDetail: FFEventDetailView!
    private var viewEdit: FFEditEventView!
    
    private var boolAnimate: Bool?
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubviews()
        
        self.backgroundColor = UIColor.whiteColor()
        boolAnimate = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("dateChanged:"), name: k_DATE_MANAGER_DATE_CHANGED, object: nil)
        
        let gesture = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        gesture.delegate = self
        self.addGestureRecognizer(gesture)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - 
    
    func invalidateLayout() {
        
        
    }
    
    // MARK: - Add Subviews
    
    private func addSubviews() {

        collectionViewHeaderDay = FFDayHeaderCollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionViewHeaderDay.setTranslatesAutoresizingMaskIntoConstraints(false)
        collectionViewHeaderDay.backgroundColor = UIColor.redColor()
        self.addSubview(collectionViewHeaderDay)
        
        let k_HEADER = "header"
        let k_HEADER_HEIGHT = "headerHeight"
        var dictViews:[String: UIView] = [k_HEADER: collectionViewHeaderDay]
        var dictMetrics:[String: Int] = [k_HEADER_HEIGHT: k_HEADER_HEIGHT_SCROLL]
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(String(format:"H:|-0-[%@]-0-|", k_HEADER), options: NSLayoutFormatOptions(0), metrics: dictMetrics, views: dictViews))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(String(format:"V:|-0-[%@(%@)]", k_HEADER, k_HEADER_HEIGHT), options: NSLayoutFormatOptions(0), metrics: dictMetrics, views: dictViews))
        
        dayContainerScroll = FFDayScrollView(frame: CGRectZero)
        dayContainerScroll.setTranslatesAutoresizingMaskIntoConstraints(false)
        dayContainerScroll.backgroundColor = UIColor.orangeColor()
        self.addSubview(dayContainerScroll)

        let k_CONTAINER = "container"
        dictViews[k_CONTAINER] = dayContainerScroll
        
        self.addConstraint(NSLayoutConstraint(item: dayContainerScroll, attribute: .Top, relatedBy: .Equal, toItem: collectionViewHeaderDay, attribute: .Bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: dayContainerScroll, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(String(format:"H:|-0-[%@]", k_CONTAINER), options: NSLayoutFormatOptions(0), metrics: dictMetrics, views: dictViews))
        self.addConstraint(NSLayoutConstraint(item: dayContainerScroll, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.5, constant: 0))
        
    }
    
}
