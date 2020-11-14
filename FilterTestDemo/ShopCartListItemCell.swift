//
//  ShopCartListItemCell.swift
//  XiaoJuMa
//
//  Created by 刘飞 on 2020/10/29.
//

import UIKit
/**
 *  购物车商品
 */
class ShopCartListItemCell: LFSwipedCollectionViewCell {
    
    
    var showImageView:UIImageView!
    var deleteButton:UIButton!
//    var origin:CGPoint = .zero
    var originalCenter:CGPoint = .zero //
    var isLeft:Bool = false
    var shouldRight:Bool = false
    let deleteButtonWidth:CGFloat = 100
    var distance:CGFloat = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubview()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: -- Create Subviews
    func createSubview()  {
        showImageView = UIImageView.init()
        self.addSubview(showImageView)
        showImageView.backgroundColor = UIColor.black
        showImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(showImageView.snp.height)
        }
        deleteButton = UIButton(type: .custom)
        deleteButton.backgroundColor = UIColor.red
        deleteButton.setTitle("删除", for: .normal)
        deleteButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        deleteButton.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
        self.revealView = deleteButton
        
    }
    
    
    @objc func deleteButtonClicked() {
        print("deleteButtonClicked")
    }
    
    
    
}
/**
 *  购物车无数据
 */
class ShopCartListNodataReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
