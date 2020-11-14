//
//  Theme.swift
//  XiaoJuMa
//
//  Created by 刘飞 on 2020/10/22.
//

import Foundation

//    约定一：颜色全部用十六进制表示，但是注释上RGB的数值和REX数值
//    约定二：所有颜色值，全部在此定义和获取，代码中不允许使用UIColor获取颜色



// MARK: --背景色
/**
 *  背景色
 */
let theme_main_background_color = UIColor(0xF6F6F6)

// MARK: --主色
/**
 *  主色调，底部
 */
let theme_main_foreground_color = UIColor(0xFF6622)
let theme_color_text_red = UIColor(0xFF6622)
let theme_color_back_red = UIColor(0xFF6622)

let theme_color_back_red_alpha1 = UIColor(0xFF6622, alpha: 0.1)

let theme_color_ffffff = UIColor(0xFFFFFF)
let theme_color_f0f0f0 = UIColor(0xF0F0F0)
let theme_color_fafafa = UIColor(0xFAFAFA)
let theme_color_cccccc = UIColor(0xCCCCCC)
let theme_color_bbbbbb = UIColor(0xBBBBBB)
let theme_color_dddddd = UIColor(0xDDDDDD)
let theme_color_eeeeee = UIColor(0xEEEEEE)
let theme_color_f6f6f6 = UIColor(0xF6F6F6)

let theme_color_FFC078 = UIColor(0xFFC078)
let theme_color_ff00000 = UIColor(0xFF0000)

let theme_color_black = UIColor(0x000000)
let theme_color_010101 = UIColor(0x010101)
let theme_color_333333 = UIColor(0x333333)
let theme_color_666666 = UIColor(0x666666)
let theme_color_999999 = UIColor(0x999999)
let theme_color_clear = UIColor.clear
let theme_color_black_alpha4 = UIColor(0x000000, alpha: 0.4)

let theme_color_login_unenable = UIColor(0xFF4622)


// MARK: -- 默认图片
/** 商品默认图/占位图 小*/
let theme_placeholder_productSmallimage = UIImage(named: "test.jpg")
/** 商品默认图/占位图 大*/
let theme_placeholder_productBigImage = UIImage(named: "brand_detail_placeholder")
/** 品牌默认图/占位图*/
let theme_placeholder_brandLogoImage = UIImage(named: "brand_logo_placeholder")
/** 品牌详情默认图/占位图*/
let theme_placeholder_brandDetailImage = UIImage(named: "brand_detail_placeholder")
/** 品类默认图/占位图*/
let theme_placeholder_categoryImage = UIImage(named: "category_placeholder_icon")


// MAKR: --尺寸
private let list_width = kScreenWidth/2 - theme_common_side_space*2
let theme_product_list_item_size = CGSize.init(width: list_width, height: list_width*23/17)
private let category_width = (kScreenWidth - theme_common_side_space*2)/4 - 6
let theme_category_list_item_size = CGSize.init(width: category_width, height: category_width*4/3)

let theme_common_cornerRadius:CGFloat = 8

let theme_common_side_space:CGFloat = 10
