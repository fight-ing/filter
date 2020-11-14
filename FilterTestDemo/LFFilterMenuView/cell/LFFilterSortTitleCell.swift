//
//  LFFilterSortTitleCell.swift
//  FilterTestDemo
//
//  Created by 刘飞 on 2020/11/4.
//

import UIKit
/**
 *  筛选-排序 标题item
 */
class LFFilterSortTitleCell: UICollectionViewCell {
    var showTitleLabel:UILabel!
    var showTagImageView:UIImageView!
    var sortModel:LFFilterSortDataModel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellValueWithItem(model:LFFilterSortDataModel) {
        self.sortModel = model
        showTitleLabel.text = model.modelName
        if model.modelShowIcoon {
            switch model.modelStatus {
            case .normal:
                showTagImageView.image = UIImage(named: model.modelNormalIcon)
            case .selected:
                showTagImageView.image = UIImage(named: model.modelSelectedIcon)
            case .reSelected:
                showTagImageView.image = UIImage(named: model.modelReselectedIcon)
            }
            showTagImageView.isHidden = false
        } else {
            showTagImageView.isHidden = true
        }
        showTitleLabel.textColor = model.modelStatus == LFFilterSortDataSelectedStatus.normal ? model.modelNormalColor:model.modelSelectedColor
    }
    
    func cellDidSelected(select:Bool)  {
        
    }
    
    // MARK: -- Create Subviews
    func createSubview()  {
        showTitleLabel = UILabel.init()
        self.addSubview(showTitleLabel)
        showTitleLabel.textColor = UIColor.black
        showTitleLabel.textAlignment = .center
        showTitleLabel.backgroundColor = UIColor.clear
        showTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        showTagImageView = UIImageView.init()
        self.addSubview(showTagImageView)
        showTagImageView.snp.makeConstraints { (make) in
            make.left.equalTo(showTitleLabel.snp.right).offset(3)
            make.centerY.equalTo(showTitleLabel.snp.centerY)
            make.width.height.equalTo(12)
        }
    }
}
