//
//  LFFilterSideListCell.swift
//  FilterTestDemo
//
//  Created by 刘飞 on 2020/11/12.
//

import UIKit
/**
 *  侧边筛选cell
 */
class LFFilterSideListCell: UICollectionViewCell {
    // cell height 30
    var showTitleLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func lfFilterSideCollectionCellValueWith(item:LFFilterFilterDataModel)  {
        self.showTitleLabel.text = item.modelName
        self.showTitleLabel.textColor = item.isTempSelected ? theme_color_text_red:theme_color_333333
        self.showTitleLabel.backgroundColor = item.isTempSelected ? theme_color_back_red_alpha1:theme_color_f6f6f6
    }
    
    // MARK: -- Create Subviews
    func createSubview()  {
        showTitleLabel = UILabel(font: ThemeMainTextFont(11), color: theme_color_333333, alignment: .center)
        self.addSubview(showTitleLabel)
        showTitleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        showTitleLabel.clipsToBounds = true
        showTitleLabel.layer.cornerRadius = 15
        showTitleLabel.backgroundColor = theme_color_f6f6f6
    }
}

protocol LFFilterSideInputCellDelegate {
    func lfFilterSideInputCellInputMinPrice(cell:LFFilterSideInputCell,min:String)
    func lfFilterSideInputCellInputMaxPrice(cell:LFFilterSideInputCell,max:String)
}

class LFFilterSideInputCell: UICollectionViewCell,UITextFieldDelegate {
    // cell height 30
    
    var cellDelegate:LFFilterSideInputCellDelegate?
    var minPriceTextField:UITextField!
    var maxPriceTextField:UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func lfFilterSideInputCellValueWith(item:LFFilterFilterDataModel)  {
        if checkStringIsValue(string: item.filterMinPrice) {
            minPriceTextField.text = item.filterMinPrice
        }
        if checkStringIsValue(string: item.filterMaxPrice) {
            maxPriceTextField.text = item.filterMaxPrice
        }
    }
    
    // MARK: -- UITextfield Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location > 10 {
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if checkStringIsValue(string: textField.text) {
            if textField == minPriceTextField {
                cellDelegate?.lfFilterSideInputCellInputMinPrice(cell: self, min: minPriceTextField.text!)
            } else  if textField == maxPriceTextField {
                cellDelegate?.lfFilterSideInputCellInputMaxPrice(cell: self, max: maxPriceTextField.text!)
            }
        }
        
    }
    
    // MARK: -- Create Subviews
    func createSubview()  {
        minPriceTextField = createSelfInputTextField(placeholder:"最低价")
        self.addSubview(minPriceTextField)
        minPriceTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(120)
        }
        minPriceTextField.inputAccessoryView = self.addToolBar()
        maxPriceTextField = createSelfInputTextField(placeholder: "最高价")
        self.addSubview(maxPriceTextField)
        maxPriceTextField.snp.makeConstraints { (make) in
            make.left.equalTo(minPriceTextField.snp.right).offset(20)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(120)
        }
        maxPriceTextField.inputAccessoryView = self.addToolBar()
        let lineView = UIView()
        lineView.backgroundColor = theme_color_333333
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(minPriceTextField.snp.right).offset(5)
            make.right.equalTo(maxPriceTextField.snp.left).offset(-5)
            make.height.equalTo(1)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func inputComplete()  {
        self.endEditing(true)
        
        
    }
    
    func addToolBar() ->UIToolbar {
        let toolBar = UIToolbar.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 40))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let bar = UIBarButtonItem.init(title: "完成", style: .done, target: self, action: #selector(inputComplete))
        toolBar.items = [space,bar]
        toolBar.tintColor = theme_main_foreground_color
        toolBar.backgroundColor = theme_color_f6f6f6
        return toolBar
    }
    
    func createSelfInputTextField(placeholder:String) -> UITextField {
        let tf = UITextField.init()
        tf.textAlignment = .center
        tf.textColor = theme_color_black
        tf.font = ThemeMainTextFont(12)
        tf.borderStyle = .none
        tf.clipsToBounds = true
        tf.layer.cornerRadius = 15
        tf.keyboardType = .numberPad
        tf.backgroundColor = theme_color_f6f6f6
        tf.tintColor = theme_color_333333
        tf.placeholder = placeholder
        tf.delegate = self
        return tf
    }
}
