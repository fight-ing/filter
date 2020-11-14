//
//  FilterSortDataModel.swift
//  TestDemo
//
//  Created by 刘飞 on 2020/11/4.
//

import UIKit
enum LFFilterSortDataSelectedStatus {
    case normal // 正常状态
    case selected // 选中状态
    case reSelected // 再次选中状态
}

class LFFilterSortDataModel: NSObject {

    var modelStatus:LFFilterSortDataSelectedStatus = .normal
    var modelName:String = "" // 排序名称
    var modelKey:String = "" // 标签
    var modelShowIcoon:Bool = false
    var modelHasReSelected:Bool = false
    var modelNormalIcon:String = ""
    var modelSelectedIcon:String = ""
    var modelReselectedIcon:String = ""
    var modelNormalColor:UIColor = UIColor.black //默认标题颜色
    var modelSelectedColor:UIColor = UIColor.red //选中/再次选中标题颜色
    override init() {
        super.init()
    }
}
