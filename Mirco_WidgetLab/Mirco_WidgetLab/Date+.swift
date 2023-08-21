//
//  Date+.swift
//  Mirco_WidgetLab
//
//  Created by Liangyz on 2023/8/21.
//

import Foundation

extension Date {
    
    //当日零点
    public func zeroClock() -> Date {
        let c = Calendar.current
        return c.date(bySettingHour: 0, minute: 0, second: 0, of: self) ?? self
    }
    
    //当时零秒点
    public func zeroSeconds() -> Date {
        let c = Calendar.current
        let components = c.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        return c.date(from: components) ?? self
    }
    
    
}
