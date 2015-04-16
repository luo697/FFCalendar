//
//  FFExtensions.swift
//  FFCalendar
//
//  Created by Hive on 4/9/15.
//  Copyright (c) 2015 Fernanda G Geraissate. All rights reserved.
//

import UIKit

extension NSDate {
    
    func numberOfWeekInMonthCount() -> Int {
        
        let calendar = NSCalendar.currentCalendar()
        let rangeWeek: NSRange = calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitWeekOfYear, inUnit: NSCalendarUnit.CalendarUnitMonth, forDate: self)
        
        return rangeWeek.length
    }
    
    func components() -> NSDateComponents {
        
        return NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitWeekday | NSCalendarUnit.CalendarUnitWeekOfMonth | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute, fromDate: self)
    }
    
    class func componentsOfCurrentDate() -> NSDateComponents {
        
        return NSDate().components()
    }
    
    class func dateWithHour(hour: Int, min: Int) -> NSDate? {
        
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let comp = NSDate.componentsWithHour(hour, min: min)
        
        return calendar?.dateFromComponents(comp)
    }
    
    class func dateWithYear(year: Int, month: Int, day: Int) -> NSDate? {
    
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let comp = NSDate.componentsWithYear(year, month: month, day: day)
        
        return calendar?.dateFromComponents(comp)
    }
    
    class func componentsWithHour(hour: Int, min: Int) -> NSDateComponents {
        
        let comp = NSDateComponents()
        comp.hour = hour
        comp.minute = min
        
        return comp
    }
    
    class func componentsWithYear(year: Int, month: Int, day: Int)  -> NSDateComponents {
        
        let comp = NSDateComponents()
        comp.year = year
        comp.month = month
        comp.day = day
        
        return comp
    }
    
    class func isTheSameDateTheCompA(compA: NSDateComponents, andCompB compB:NSDateComponents) -> Bool {
        
        return compA.day==compB.day && compA.month==compB.month && compA.year==compB.year
    }
}

// MARK: -

extension UIColor {
    
    class func customBlue() -> UIColor {
        
        return UIColor(red: 49/255, green: 181/255, blue: 247/255, alpha: 0.5)
    }
    
    class func customGrayLight() -> UIColor {
        
        return UIColor(white: 0.9, alpha: 1)
    }
    
    class func customGrayLighter() -> UIColor {
        
        return UIColor(white: 0.95, alpha: 1)
    }
}

// MARK: -

extension UIView {
    
    func transformToCircle() {
        
        let saveCenter = self.center
        
        let width = (self.frame.size.width<self.frame.size.height) ? self.frame.size.width : self.frame.size.height;
        var newFrame = self.frame
        newFrame.size.width = width
        newFrame.size.height = width
        
        self.frame = newFrame
        self.layer.cornerRadius = width/2
        self.center = saveCenter
        self.clipsToBounds = true
    }
    
//    func mergeSubviews() -> UIImage {
//        
//        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0);
//        self.layer.renderInContext(UIGraphicsGetCurrentContext())  // para funcionar, importar na função .h: #import <QuartzCore/QuartzCore.h>
//        let image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        //    UIImage *newImage = UIImagePNGRepresentation(image);
//        
//        return image;
//    }
}

extension UILabel {
    
    func widthThatWouldFit() -> CGFloat {
    
        self.numberOfLines = 0;
        var rectText = CGRectZero
        
        if let lns_str:NSString = self.text as NSString? {
            
            rectText = lns_str.boundingRectWithSize(CGSize(width: CGFloat.max, height: self.frame.size.height), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: self.font], context: nil)
        }
        
        return rectText.size.width;
    }
}
