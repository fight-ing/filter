//
//  LFFilterFilterTitleCell.swift
//  FilterTestDemo
//
//  Created by 刘飞 on 2020/11/4.
//

import UIKit

class LFFilterFilterTitleCell: UICollectionViewCell {
    var showTitleLabel:UILabel!
    var showTagImageView:UIImageView!
    var shadowBackImageView:UIImageView!
    var showItemsBackView:UIView!
    
    var placeLabel:UILabel! //占位 不显示
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func lfFilterFilterTitleCellValueWith(item:LFFilterFilterDataModel)  {
        self.showTitleLabel.text = item.modelName
        print(item.modelName)
        if !item.modelShowIcon {
            showTagImageView.image = nil
            placeLabel.text = ""
            self.shadowBackImageView.isHidden = true
            if item.isTempSelected {
                self.showItemsBackView.isHidden = false
            } else {
                self.showItemsBackView.isHidden = true
            }
        } else {
            if item.isUnFold { //展开
                if item.isTempSelected {
                    self.showTagImageView.image = UIImage(named: item.modelUnFoldSelectedIcon)
                    self.showItemsBackView.isHidden = false
                } else {
                    self.showTagImageView.image = UIImage(named: item.modelUnfoldUnSelectedIcon)
                    self.showItemsBackView.isHidden = true
                }
                self.shadowBackImageView.isHidden = false
            } else {
                if item.isTempSelected {
                    self.showTagImageView.image = UIImage(named: item.modelFoldSelectedIcon)
                    self.showItemsBackView.isHidden = false
                } else {
                    self.showTagImageView.image = UIImage(named: item.modelFoldUnselectedIcon)
                    self.showItemsBackView.isHidden = true
                }
                self.shadowBackImageView.isHidden = true
            }
            placeLabel.text = "  "
        }
        
        
    }
    
    // MARK: -- Create Subviews
    func createSubview()  {
        
        shadowBackImageView = UIImageView()
        self.addSubview(shadowBackImageView)
        shadowBackImageView.backgroundColor = UIColor.lightGray
        shadowBackImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        let backView = UIView()
        self.addSubview(backView)
        
        showItemsBackView = UIView()
        backView.addSubview(showItemsBackView)
        
        showTagImageView = UIImageView.init()
        backView.addSubview(showTagImageView)
        showTitleLabel = UILabel.init()
        backView.addSubview(showTitleLabel)
        placeLabel = UILabel.init()
        backView.addSubview(placeLabel)
        backView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            
            make.right.equalTo(placeLabel.snp.right).offset(15)
//            make.left.equalTo(showTitleLabel.snp.left).offset(-15)
            
            make.centerX.equalToSuperview().priority(.medium)
//            make.width.lessThanOrEqualTo(self.snp.width).multipliedBy(0.9)
        }
        
        showTagImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(10)
            make.left.equalTo(showTitleLabel.snp.right)
        }
        
        placeLabel.font = UIFont.systemFont(ofSize: 15)
        placeLabel.isHidden = true
        placeLabel.snp.makeConstraints { (make) in
            
            make.centerY.equalToSuperview()
        }
        
        showTitleLabel.font = UIFont.systemFont(ofSize: 14)
        showTitleLabel.textColor = UIColor.black
        showTitleLabel.textAlignment = .center
        showTitleLabel.backgroundColor = UIColor.clear
        showTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(placeLabel.snp.left).offset(0)
        }
        
        
        showItemsBackView.snp.makeConstraints { (make) in
            make.height.equalTo(28)
            make.width.equalToSuperview()
            make.center.equalToSuperview()
        }
        showItemsBackView.layer.cornerRadius = 14
        showItemsBackView.layer.borderWidth = 1
        showItemsBackView.layer.borderColor = UIColor.red.cgColor
        showItemsBackView.backgroundColor = UIColor.purple
//        showItemsBackView.isHidden = true
        
        
        
        
        
        
        
        
    }
}
