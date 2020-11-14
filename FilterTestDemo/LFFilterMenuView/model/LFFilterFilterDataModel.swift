//
//  LFFilterFilterDataModel.swift
//  FilterTestDemo
//
//  Created by 刘飞 on 2020/11/4.
//

import UIKit
// 筛选菜单cell类型
enum LFFilterFilterCellType {
    /** 分栏标签 **/
    case cellTypeTagCollection
    /** 单输入框**/
    case cellTypeSingleInput
    /**  区间输入，两个输入框**/
    case cellTypeSectionInput
}
/** 筛选菜单类型**/
enum LFFilterFitlerMenuType {
    
    /** 侧滑筛选**/
    case menuTypeFilter
    /** 下拉选项**/
    case menuTypeCollection
    /** 只有标题**/
    case menuTypeOnlyTitle
}
/**
 *  数据类型 -- 针对不同类型处理请求体
 */
enum LFFilterItemRequestParamType {
    case filter // 其它筛选项 filter
    case brand // 品牌 brandId
    case category // 品类 groupId
    case sellStatus // 出售状态 active
    case price //价格  minPrice - maxPrice
}

/*
/**
 *  选中状态处理
 *  标题标签 4种
 *  选项标签 2种 --
 */
enum LFFilterFilterItemStatus {
    /** 收起未选中**/
    case foldUnselected
    /** 收起选中**/
    case foldSelected
    /** 展开未选中*/
    case unfoldUnselected
    /** 展开选中*/
    case unfoldSelected
}
 */

/**
 *  筛选数据
 */
class LFFilterFilterDataModel: NSObject {
    
    /** 标题**/
    var modelName:String = "" // 排序名称
    var modelKey:String = "" // 标签
    var modelValue:String = "" //value
    /** 是否显示icon 、是否需要展开**/
    var modelShowIcon:Bool = false
    /** 侧边筛选 是否显示 **/
    var modelSideFilterShow:Bool = true
    /** 请求类型 处理对应的请求参数**/
    var modelRequestParmType:LFFilterItemRequestParamType = .filter
    /** 收起未选中icon**/
    var modelFoldUnselectedIcon:String = "home_icon_filtrate_fold"
    /** 展开未选中icon**/
    var modelUnfoldUnSelectedIcon:String = "home_icon_filtrate_unfold"
    /** 收起选中icon**/
    var modelFoldSelectedIcon:String = "home_icon_filtrate_fold"
    /** 展开选中icon**/
    var modelUnFoldSelectedIcon:String = "home_icon_filtrate_unfold"
    /** 默认文本颜色**/
    var modelNormalColor:UIColor = UIColor.black
    /** 选中文本颜色**/
    var modelSelectedColor:UIColor = UIColor.red
    /** 标记选中状态 true-选中，false-未选中**/
    var isSelected:Bool = false
    /** 标记临时选中状态 -- 未保存**/
    var isTempSelected:Bool = false
    /** 标记是否展开，true-展开 false-收起*/
    var isUnFold:Bool = false
    /** 菜单类型 下拉可选，仅显示标题**/
    var modelFilterMenuType:LFFilterFitlerMenuType = .menuTypeCollection
    /** 数据源**/
    var dataArray:[LFFilterFilterDataModel]?
    /** 最大宽度**/
    var filterMenuWidth:CGFloat = UIScreen.main.bounds.size.width
    /** 每行个数**/
    var filterSectionCount = 2
    var filterItemHeight:CGFloat = 40
    
    
    // MARK: --
    var filterMinPrice = ""
    var filterMaxPrice = ""
    
}
