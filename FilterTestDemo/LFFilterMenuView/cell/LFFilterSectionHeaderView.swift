//
//  LFFilterSectionHeaderView.swift
//  FilterTestDemo
//
//  Created by 刘飞 on 2020/11/12.
//

import UIKit

protocol LFFilterSectionHeaderViewDelegate {
    func lfFilterSectionHeaderViewShowMoreButton(view:LFFilterSectionHeaderView)
}

class LFFilterSectionHeaderView: UICollectionReusableView {
    var viewDelegate:LFFilterSectionHeaderViewDelegate?
    var showTitleLabel:UILabel!
    var showDetailsLabel:UILabel!
    var showMoreButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func lfFilterSectionHeaderViewValueWith(item:LFFilterFilterDataModel,contenString:String?,showMore:Bool)  {
        showTitleLabel.text = item.modelName
        if checkStringIsValue(string: contenString) {
            showDetailsLabel.text = contenString!
        } else if checkArrayHasLessOneValue(arr: item.dataArray) {
            var selectedStr = ""
            var count = 0
            for sItem in item.dataArray! {
                if sItem.isTempSelected {
                    count += 1
                    selectedStr.append(sItem.modelName)
                    selectedStr.append(",")
                }
            }
            if selectedStr.count > 1 {
                selectedStr.insert(contentsOf: "已选(\(count)) ", at: selectedStr.startIndex)
                selectedStr.removeLast()
            }
            showDetailsLabel.text = selectedStr
        } else {
            showDetailsLabel.text = ""
        }
        showMoreButton.isHidden = !showMore
        // 是否显示更多按钮操作
    }
    
    
    
    @objc func showMoreButtonClicked() {
        viewDelegate?.lfFilterSectionHeaderViewShowMoreButton(view: self)
    }
    
    // MARK: -- Create Subviews
    func createSubview()  {
        showTitleLabel = UILabel(font: ThemeMainBoldTextFont(14), color: theme_color_black, alignment: .left)
        self.addSubview(showTitleLabel)
        showTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        showDetailsLabel = UILabel(font: ThemeMainTextFont(11), color: theme_color_text_red, alignment: .right)
        self.addSubview(showDetailsLabel)
        showDetailsLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-30)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(100)
        }
        
        showMoreButton = UIButton(type: .custom)
        showMoreButton.setImage(UIImage(named: "home_icon_filtrate_unfold"), for: .normal)
        showMoreButton.setImage(UIImage(named: "home_icon_filtrate_fold"), for: .selected)
        showMoreButton.addTarget(self, action: #selector(showMoreButtonClicked), for: .touchUpInside)
        self.addSubview(showMoreButton)
        showMoreButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
    }
}
