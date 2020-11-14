//
//  LFFilterDropCollectionCell.swift
//  FilterTestDemo
//
//  Created by 刘飞 on 2020/11/4.
//

import UIKit

class LFFilterDropCollectionCell: UICollectionViewCell {
    
    var showTitleLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func lfFilterDropCollectionCellValueWith(item:LFFilterFilterDataModel)  {
        self.showTitleLabel.text = item.modelName
        self.showTitleLabel.textColor = item.isTempSelected ? UIColor.red:UIColor.black
    }
    
    // MARK: -- Create Subviews
    func createSubview()  {
        showTitleLabel = UILabel()
        showTitleLabel.font = UIFont.systemFont(ofSize: 12)
        showTitleLabel.textColor = UIColor.black
        self.addSubview(showTitleLabel)
        showTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
//            make.right.equalToSuperview().offset(-5)
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
