//
//  LFFilterFilterMenuView.swift
//  TestDemo
//
//  Created by 刘飞 on 2020/11/4.
//

import UIKit
protocol LFFilterFilterMenuViewDelegate {
    /**
     *  确认 保存选项
     *  @ dict 请求参数样式-根据接口确定
     */
    func lfFilterFilterMenuViewDidSaveSelectedRequestParam(view:LFFilterFilterMenuView, dict:[String:Any])
}

/**
 *  筛选-筛选view
 */
class LFFilterFilterMenuView: UIView ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LFFilterSideInputCellDelegate {
    
    
    var viewDelegate:LFFilterFilterMenuViewDelegate?
    /** 标题菜单栏**/
    var showTitleCollectionView:UICollectionView!
    /** 下拉筛选view* */
    var dropCollectionView:UICollectionView!
    /** 下拉筛选cover**/
    var filterCoverControl:UIControl!
    var sureButton:UIButton!
    var resetButton:UIButton!
    
    /** 侧拉筛选view */
    var sideFilterCollectionView:UICollectionView!
    /** 侧拉筛选cover**/
    var sideFilterCoverControl:UIControl!
    var sideFilterSectionCount:Int = 0
    var sideSureButton:UIButton!
    var sideResetButton:UIButton!
    
    var filterTitleDataArray = [LFFilterFilterDataModel]()
//    var filterDataModel:LFFilterFilterDataModel?
    /** 当前下拉显示的index**/
    var currentIndex = 0
    let filterViewHeight = 44
    
    let bottomButtonHeight:CGFloat = 50
    
    var filterAllBrandListArray = [LFFilterFilterDataModel]()
    var filterAllCategoryListArray = [LFFilterFilterDataModel]()
    var selectedBrandIdsSet = Set<String>() //缓存选中的brandid --
    var selectedCategoryIdsSet = Set<String>() // 缓存选中的categoryid --
    var selectedMinPrice:String?
    var selectedMaxPrice:String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createFilterDataModel()
        createSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // MARK: -- Create Subviews
    func createSubview()  {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        showTitleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.addSubview(showTitleCollectionView)
        
        showTitleCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        showTitleCollectionView.dataSource = self
        showTitleCollectionView.delegate = self
        showTitleCollectionView.showsHorizontalScrollIndicator = false
        showTitleCollectionView.isScrollEnabled = false
        showTitleCollectionView.backgroundColor = UIColor.white
        if #available(iOS 13.0, *) {
            showTitleCollectionView.automaticallyAdjustsScrollIndicatorInsets = false
            
        } else {
            // Fallback on earlier versions
        }
        showTitleCollectionView.register(LFFilterFilterTitleCell.self, forCellWithReuseIdentifier: "LFFilterFilterTitleCell")
        
        filterCoverControl = UIControl()
        filterCoverControl.addTarget(self, action: #selector(filterControlGesture), for: .touchUpInside)
        
        let layout1 = UICollectionViewFlowLayout()
        dropCollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout1)
        dropCollectionView.dataSource = self
        dropCollectionView.backgroundColor = UIColor.white
        dropCollectionView.delegate = self
        dropCollectionView.register(LFFilterDropCollectionCell.self, forCellWithReuseIdentifier: "LFFilterDropCollectionCell")
        filterCoverControl.addSubview(dropCollectionView)
        filterCoverControl.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        resetButton = createButton(title: "重置", titleColor: theme_color_black, backColor: theme_color_ffffff)
        resetButton.addTarget(self, action: #selector(resetButtonClicked), for: .touchUpInside)
        filterCoverControl.addSubview(resetButton)
        
        sureButton = createButton(title: "确认", titleColor: UIColor.white, backColor: theme_color_back_red)
        sureButton.addTarget(self, action: #selector(sureButtonClicked), for: .touchUpInside)
        filterCoverControl.addSubview(sureButton)
        
        // MARK: -- 侧拉筛选
        
        // 侧拉筛选
        let layout2 = UICollectionViewFlowLayout()
        sideFilterCollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout2)
        sideFilterCollectionView.dataSource = self
        sideFilterCollectionView.backgroundColor = UIColor.white
        sideFilterCollectionView.delegate = self
        sideFilterCollectionView.register(LFFilterSideListCell.self, forCellWithReuseIdentifier: "LFFilterSideListCell")
        sideFilterCollectionView.register(LFFilterSideInputCell.self, forCellWithReuseIdentifier: "LFFilterSideInputCell")
        sideFilterCollectionView.register(LFFilterSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "LFFilterSectionHeaderView")
        sideFilterCollectionView.alwaysBounceVertical = true
        sideFilterCollectionView.showsVerticalScrollIndicator = false
        sideFilterCoverControl = UIControl()
        sideFilterCoverControl.addTarget(self, action: #selector(sideFilterTapGesuter), for: .touchUpInside)
        sideFilterCoverControl.addSubview(sideFilterCollectionView)
        sideFilterCoverControl.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        sideResetButton = createButton(title: "重置", titleColor: theme_color_333333, backColor: theme_color_f0f0f0)
        sideResetButton.addTarget(self, action: #selector(resetButtonClicked), for: .touchUpInside)
        sideFilterCoverControl.addSubview(sideResetButton)
        
        sideSureButton = createButton(title: "确认", titleColor: UIColor.white, backColor: theme_color_back_red)
        sideSureButton.addTarget(self, action: #selector(sureButtonClicked), for: .touchUpInside)
        sideFilterCoverControl.addSubview(sideSureButton)
        
        
        
    }
    
    func createButton(title:String,titleColor:UIColor,backColor:UIColor) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backColor
        button.titleLabel?.font = ThemeMainTextFont(17)
        return button
    }
    
    @objc func resetButtonClicked() { // 重置
        for item in self.filterTitleDataArray {
            item.isSelected = false
            item.isTempSelected = false
            item.isUnFold = false
            if item.dataArray != nil {
                for sItem in item.dataArray! {
                    sItem.isSelected = false
                    sItem.isTempSelected = false
                }
            }
            if item.modelRequestParmType == .price {
                item.filterMinPrice = ""
                item.filterMaxPrice = ""
                self.selectedMinPrice = ""
                self.selectedMaxPrice = ""
            }
        }
        
        self.dismissDropFilterCollection()
        self.dismissSideFilterCollection()
    }
    
    @objc func sureButtonClicked() { // 确认 保存所有值
        var dict = [String:Any]()
        var requestDict = [String:Any]()
        for item in self.filterTitleDataArray {
            if item.isTempSelected {
                
                if item.modelShowIcon && item.dataArray != nil {
                    var select = false
                    for sItem in item.dataArray! {
                        sItem.isSelected =  sItem.isTempSelected
                        if sItem.isSelected == true {
                            select = true
                        }
                    }
                    item.isSelected = select
                    item.isTempSelected = item.isSelected
                } else {
                    
                }
            }
            if item.modelRequestParmType == .price {
                if checkStringIsValue(string: self.selectedMinPrice) {
                    item.filterMinPrice = self.selectedMinPrice!
                    requestDict.updateValue(item.filterMinPrice, forKey: "minPrice")
                    
                }
                if checkStringIsValue(string: self.selectedMaxPrice) {
                    item.filterMaxPrice = self.selectedMaxPrice!
                    requestDict.updateValue(item.filterMaxPrice, forKey: "maxPrice")
                }
            }
            switch item.modelRequestParmType {
            case .sellStatus:
                requestDict.updateValue(item.isSelected ? "1":"0", forKey: item.modelKey) //只看在售
            case .brand:
//                    dict.updateValue("", forKey: item.modelKey)
                break
            case .category:
                
//                    dict.updateValue("", forKey: item.modelKey)
                break
            case .filter:
                if item.isSelected {
                    var subDictArr = [String]()
                    for sItem in item.dataArray! {
                        if sItem.isSelected == true {
                            subDictArr.append(sItem.modelValue)
                        }
                    }
                    dict.updateValue(subDictArr, forKey: item.modelKey)
                }
                
            case .price:
                break
            }
            
            item.isUnFold = false
        }
        // 品牌
        var brandSubDictArr = [String]()
        for item in self.filterAllBrandListArray {
            if item.isTempSelected {
                if item.dataArray != nil {
                    var select = false
                    for sItem in item.dataArray! {
                        sItem.isSelected =  sItem.isTempSelected
                        if sItem.isSelected == true {
                            select = true
                        }
                    }
                    item.isSelected = select
                    item.isTempSelected = item.isSelected
                } else {
                    
                }
            }
            
            for sItem in item.dataArray! {
                if sItem.isSelected == true {
                    brandSubDictArr.append(sItem.modelValue)
                }
            }
        }
        
        // 品类
        var categorySubDictArr = [String]()
        for item in self.filterAllCategoryListArray {
            if item.isTempSelected {
                if item.dataArray != nil {
                    var select = false
                    for sItem in item.dataArray! {
                        sItem.isSelected =  sItem.isTempSelected
                        if sItem.isSelected == true {
                            select = true
                        }
                    }
                    item.isSelected = select
                    item.isTempSelected = item.isSelected
                } else {
                    
                }
            }
            
            for sItem in item.dataArray! {
                if sItem.isSelected == true {
                    categorySubDictArr.append(sItem.modelValue)
                }
            }
        }

        
        
        if dict.count > 0 {
            requestDict.updateValue(dict, forKey: "filter")
        }
        if brandSubDictArr.count > 0 {
            requestDict.updateValue(brandSubDictArr, forKey: "brandId")
        }
        if categorySubDictArr.count > 0 {
            requestDict.updateValue(categorySubDictArr, forKey: "groupId")
        }
        
        
        viewDelegate?.lfFilterFilterMenuViewDidSaveSelectedRequestParam(view: self, dict: requestDict)
        self.dismissDropFilterCollection()
        self.dismissSideFilterCollection()
    }
    
    @objc func filterControlGesture() {
        // 重置临时选项，保留已确认选项
        // 重置菜单栏 展开状态
        for item in self.filterTitleDataArray {
            item.isUnFold = false
        }
        lfFilterMenuClearAllTempSelectedStatus()
        self.dismissDropFilterCollection()
    }
    /**
     *  清空所有临时选项
     */
    func lfFilterMenuClearAllTempSelectedStatus() {
        for item in self.filterTitleDataArray {
            
            if item.modelShowIcon && item.dataArray != nil {
                for sItem in item.dataArray! {
//                        sItem.isSelected = sItem.isTempSelected ? true:sItem.isSelected
                    sItem.isTempSelected = sItem.isSelected
                }
            }
            item.isTempSelected = item.isSelected
        }
        
        // 清空所有品牌临时选项
        selectedBrandIdsSet.removeAll()
        for item in self.filterAllBrandListArray {
            if checkArrayHasLessOneValue(arr: item.dataArray) {
                for sItem in item.dataArray! {
                    sItem.isTempSelected = sItem.isSelected
                    if sItem.isSelected && checkStringIsValue(string: sItem.modelValue) {
                        selectedBrandIdsSet.insert(sItem.modelValue)
                    }
                }
            }
        }
        
        // 清空所有品类临时选项
        selectedBrandIdsSet.removeAll()
        for item in self.filterAllCategoryListArray {
            if checkArrayHasLessOneValue(arr: item.dataArray) {
                for sItem in item.dataArray! {
                    sItem.isTempSelected = sItem.isSelected
                    if sItem.isSelected && checkStringIsValue(string: sItem.modelValue) {
                        selectedCategoryIdsSet.insert(sItem.modelValue)
                    }
                }
            }
        }
    }
    
}

// MARK: -- 下拉筛选
extension LFFilterFilterMenuView {
    /**
     *  显示可选项
     */
    func showDropFilterCollection()  {
        lfFilterMenuClearAllTempSelectedStatus() //清空其它选项的临时可选项
        self.dropCollectionView.reloadData()
        self.showTitleCollectionView.reloadData()
        if self.filterTitleDataArray.count > currentIndex {
            let model = self.filterTitleDataArray[currentIndex]
            if model.modelShowIcon {
                if model.dataArray != nil && model.dataArray!.count > 0 {
                    var cHeight:CGFloat = CGFloat((model.dataArray!.count/model.filterSectionCount + (model.dataArray!.count % model.filterSectionCount == 0 ? 0:1)))*model.filterItemHeight
                    cHeight = min(cHeight, UIScreen.main.bounds.size.height/2)
                    
                    self.filterCoverControl.frame = CGRect.init(x: 0, y: self.frame.maxY, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    
                    UIApplication.shared.keyWindow?.addSubview(filterCoverControl)
                    UIView.animate(withDuration: 0.5) {
                        self.filterCoverControl.frame = CGRect.init(x: 0, y: self.frame.maxY, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                        self.dropCollectionView.frame = CGRect.init(x: 0, y: 0, width: self.filterCoverControl.frame.size.width, height: cHeight)
                        self.sureButton.frame = CGRect.init(x: model.filterMenuWidth/2, y: cHeight, width: model.filterMenuWidth/2, height: self.bottomButtonHeight)
                        self.resetButton.frame = CGRect.init(x: 0, y: cHeight, width: model.filterMenuWidth/2, height: self.bottomButtonHeight)
                        self.filterCoverControl.alpha = 1
                    } completion: { (finished) in
                        
                    }
                }
                

            }
        }
    }
    
    /**
     *  关闭可选项
     */
    func dismissDropFilterCollection()  {
        self.showTitleCollectionView.reloadData()
        self.dropCollectionView.reloadData()
        UIView.animate(withDuration: 0.3) {
            self.filterCoverControl.alpha = 0
        }
    }
}

// MARK: -- 侧拉筛选
extension LFFilterFilterMenuView {
    /**
     *  侧拉筛选 点击手势
     */
    @objc func sideFilterTapGesuter()  {
        for item in self.filterTitleDataArray {
            item.isUnFold = false
        }
        lfFilterMenuClearAllTempSelectedStatus()
        self.dismissSideFilterCollection()
    }
    
    /**
     *  显示侧拉筛选
     */
    func showSideFilterCollection()  {
        self.dismissDropFilterCollection()
        self.sideFilterCoverControl.frame = CGRect.init(x: kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight)
        let viewWidth = kScreenWidth-50
        
        self.sideFilterCollectionView.frame = CGRect.init(x: 50, y: 0, width: kScreenWidth-50, height: kScreenHeight)
        
        self.sideResetButton.frame = CGRect.init(x: 50, y: kScreenHeight-50, width: viewWidth/2, height: 50)
        self.sideSureButton.frame = CGRect.init(x: self.sideResetButton.frame.maxX, y: self.sideResetButton.y, width: self.sideResetButton.width, height: self.sideResetButton.height)
        
        UIApplication.shared.keyWindow?.addSubview(sideFilterCoverControl)
        sideFilterCollectionView.reloadData()
        UIView.animate(withDuration: 0.5) {
            self.sideFilterCoverControl.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.sideFilterCollectionView.frame = CGRect.init(x: 50, y: 0, width: kScreenWidth-50, height: kScreenHeight)
            
            self.sideResetButton.frame = CGRect.init(x: 50, y: kScreenHeight-50, width: viewWidth/2, height: 50)
            self.sideSureButton.frame = CGRect.init(x: self.sideResetButton.frame.maxX, y: self.sideResetButton.y, width: self.sideResetButton.width, height: self.sideResetButton.height)
            self.sideFilterCoverControl.alpha = 1
        } completion: { (finished) in
            
        }
    }
    
    /**
     *  关闭侧拉筛选
     */
    func dismissSideFilterCollection()  {
        sideFilterCollectionView.endEditing(true)
        UIView.animate(withDuration: 0.5) {
            self.sideFilterCoverControl.frame = CGRect.init(x:kScreenWidth, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
            self.sideFilterCoverControl.alpha = 0
        } completion: { (finished) in
            
        }
    }
}


extension LFFilterFilterMenuView {
    // MARK: -- UICollectionView DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == showTitleCollectionView || collectionView == dropCollectionView { // 顶部菜单 、下拉筛选
            return 1
        } else if collectionView == sideFilterCollectionView { // 侧拉
            return filterTitleDataArray.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.showTitleCollectionView { // 顶部菜单栏
            return min(4, filterTitleDataArray.count-1)
        } else if collectionView == dropCollectionView { // 下拉筛选
            if self.filterTitleDataArray.count > currentIndex {
                let model = self.filterTitleDataArray[currentIndex]
                return model.dataArray?.count ?? 0
            }
        } else if collectionView == sideFilterCollectionView { // 侧边筛选
            if self.filterTitleDataArray.count > section {
                let model = self.filterTitleDataArray[section]
                if model.modelRequestParmType == .price {
                    return 1
                }
                return model.modelSideFilterShow ? (model.dataArray?.count ?? 0):0
            }
        }
        
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == sideFilterCollectionView  ? 10:0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == sideFilterCollectionView ? 10:0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.showTitleCollectionView && filterTitleDataArray.count > 0 {
            return CGSize(width: Int(collectionView.frame.size.width)/min(filterTitleDataArray.count-1, 4) , height: 40) //最多四个
        } else if collectionView == dropCollectionView {
            return CGSize(width: (UIScreen.main.bounds.size.width-30)/2-10, height: 40)
        } else if collectionView == sideFilterCollectionView {
            if self.filterTitleDataArray.count > indexPath.section {
                let model = self.filterTitleDataArray[indexPath.section]
                
                if model.modelRequestParmType == .price {
                    return CGSize.init(width: collectionView.width-100, height: 30)
                } else {
                    return model.modelSideFilterShow ? CGSize(width: (kScreenWidth-70)/3-10, height: 30):.zero
                }
            }
        }
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == showTitleCollectionView { // 顶部菜单栏
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LFFilterFilterTitleCell", for: indexPath) as! LFFilterFilterTitleCell
            if filterTitleDataArray.count > indexPath.row+1  {
                let item = filterTitleDataArray[indexPath.row+1]
                cell.lfFilterFilterTitleCellValueWith(item: item)
            }
            return cell
        } else if collectionView == dropCollectionView { // 下拉筛选项
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LFFilterDropCollectionCell", for: indexPath) as! LFFilterDropCollectionCell
            if self.filterTitleDataArray.count > currentIndex {
                let model = self.filterTitleDataArray[currentIndex]
                if model.dataArray != nil && model.dataArray!.count > indexPath.row {
                    let sModel = model.dataArray![indexPath.row]
                    cell.lfFilterDropCollectionCellValueWith(item: sModel)
                }
            }
            return cell
        } else if collectionView == sideFilterCollectionView { // 侧边筛选
            if self.filterTitleDataArray.count > indexPath.section {
                
                let model = self.filterTitleDataArray[indexPath.section]
                if model.modelRequestParmType == .price {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LFFilterSideInputCell", for: indexPath) as! LFFilterSideInputCell
                    cell.lfFilterSideInputCellValueWith(item: model)
                    cell.cellDelegate = self
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LFFilterSideListCell", for: indexPath) as! LFFilterSideListCell
                    if checkArrayHasLessOneValue(arr: model.dataArray) && model.dataArray!.count > indexPath.row {
                        let sItem = model.dataArray![indexPath.row]
                        cell.lfFilterSideCollectionCellValueWith(item: sItem)
                        
                    }
                    return cell
                }

            }
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LFFilterFilterTitleCell", for: indexPath) as! LFFilterFilterTitleCell
        return cell
    }
    
    // MARK: -- UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.showTitleCollectionView { //顶部菜单选项 选择
            for index in 0..<self.filterTitleDataArray.count {
                let model = self.filterTitleDataArray[index]
                if index == indexPath.row+1 { // 点击当前cell 处理选中与展开状态
                    model.isUnFold = !model.isUnFold
                    if !model.modelShowIcon {
                        print(">>>> \(model.isTempSelected)")
                        model.isTempSelected = !model.isTempSelected
                        model.isSelected = model.isTempSelected
                        print("#### \(model.isTempSelected)")
                        print("#### \(model.isSelected)")
                        self.filterControlGesture()
                        self.sureButtonClicked()
                    } else {
                        if model.isUnFold {
                            currentIndex = indexPath.row+1
                            self.showDropFilterCollection()
                        } else { //收起
                            self.filterControlGesture()
                        }
                    }
                } else {
                    
                    model.isUnFold = false
                }
            }
            collectionView.reloadData()
        } else if collectionView == self.dropCollectionView { //选中筛选项
            if self.filterTitleDataArray.count > currentIndex {
                let model = self.filterTitleDataArray[currentIndex]
                if model.dataArray != nil && model.dataArray!.count > indexPath.row {
                    let sModel = model.dataArray![indexPath.row]
                    sModel.isTempSelected = !sModel.isTempSelected
                    self.selectedBrandIdsSet.removeAll()
                    self.selectedCategoryIdsSet.removeAll()
                    for sItem in model.dataArray! {
                        if sItem.isTempSelected && checkStringIsValue(string: sItem.modelValue) {
                            model.isTempSelected = true
                            if model.modelRequestParmType == .brand {
                                self.selectedBrandIdsSet.insert(sItem.modelValue)
                            } else if model.modelRequestParmType == .category {
                                self.selectedCategoryIdsSet.insert(sItem.modelValue)
                            }
                        }
                    }
                }
                if model.modelRequestParmType == .brand {
                    refreshAllBrandDataStatus()
                } else if model.modelRequestParmType == .category {
                    refreshAllCategoryDataStatus()
                }
            }
            
            collectionView.reloadData()
        } else if collectionView == self.sideFilterCollectionView { //侧边筛选
            if self.filterTitleDataArray.count > indexPath.section {
                let model = self.filterTitleDataArray[indexPath.section]
                if checkArrayHasLessOneValue(arr: model.dataArray) && model.dataArray!.count > indexPath.row {
                    
                    let sModel = model.dataArray![indexPath.row]
                    sModel.isTempSelected = !sModel.isTempSelected
                    self.selectedBrandIdsSet.removeAll()
                    self.selectedCategoryIdsSet.removeAll()
                    for sItem in model.dataArray! {
                        if sItem.isTempSelected && checkStringIsValue(string: sItem.modelValue) {
                            model.isTempSelected = true
                            if model.modelRequestParmType == .brand {
                                self.selectedBrandIdsSet.insert(sItem.modelValue)
                            } else if model.modelRequestParmType == .category {
                                self.selectedCategoryIdsSet.insert(sItem.modelValue)
                            }
                        }
                    }
                    if model.modelRequestParmType == .brand {
                        refreshAllBrandDataStatus()
                    } else if model.modelRequestParmType == .category {
                        refreshAllCategoryDataStatus()
                    }
                }
                collectionView.reloadData()
            }
        }
    }
    
    // MARK: -- 刷新所有品牌 状态
    func refreshAllBrandDataStatus()  {
        for item in self.filterAllBrandListArray {
            if checkArrayHasLessOneValue(arr: item.dataArray) {
                for sItem in item.dataArray! {
                    if checkStringIsValue(string: sItem.modelValue) && self.selectedBrandIdsSet.firstIndex(of: sItem.modelValue) != nil {
                        sItem.isTempSelected = true
                    } else {
                        sItem.isTempSelected = false
                    }
                    
                }
            }
        }
    }
    // MARK: -- 刷新所有品类 状态
    func refreshAllCategoryDataStatus()  {
        for item in self.filterAllCategoryListArray {
            if checkArrayHasLessOneValue(arr: item.dataArray) {
                for sItem in item.dataArray! {
                    if checkStringIsValue(string: sItem.modelValue) && self.selectedCategoryIdsSet.firstIndex(of: sItem.modelValue) != nil {
                        sItem.isTempSelected = true
                    } else {
                        sItem.isTempSelected = false
                    }
                }
            }
        }
    }
    
}
// MARK: --  UICollectionView HeaderView
extension LFFilterFilterMenuView {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        var size = CGSize.zero
        if collectionView == sideFilterCollectionView {
            if self.filterTitleDataArray.count > section {
                let model = self.filterTitleDataArray[section]
                size = model.modelSideFilterShow ? CGSize.init(width: collectionView.width, height: 40):.zero
            }
            
        }
        return size
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = UICollectionReusableView()
        if collectionView == sideFilterCollectionView && kind == UICollectionView.elementKindSectionHeader {
            let view = sideFilterCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LFFilterSectionHeaderView", for: indexPath) as! LFFilterSectionHeaderView
            if self.filterTitleDataArray.count > indexPath.section {
                let model = self.filterTitleDataArray[indexPath.section]
                var string:String?
                var showMore:Bool = false
                if model.modelRequestParmType == .brand {
                    string = filterAllSelectedBrandNames()
                    showMore = checkArrayHasLessOneValue(arr: model.dataArray)
                } else if model.modelRequestParmType == .category {
                    string = filterAllSelectedCategoryNames()
                    showMore = checkArrayHasLessOneValue(arr: model.dataArray)
                }
                view.lfFilterSectionHeaderViewValueWith(item: model,contenString: string,showMore: showMore)
            }
            return view
        }
        return view
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return collectionView == showTitleCollectionView ? UIEdgeInsets.zero:UIEdgeInsets.init(top: 5, left: 15, bottom: 5, right: 15)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.sideFilterCollectionView.endEditing(true)
    }
    
    func filterAllSelectedBrandNames() -> String? {
        var string:String?
        var count = 0
        for item in self.filterAllBrandListArray {
            if checkArrayHasLessOneValue(arr: item.dataArray) {
                for sItem in item.dataArray! {
                    if sItem.isTempSelected && checkStringIsValue(string: sItem.modelValue) {
                        count += 1
                        string?.append(sItem.modelValue)
                        string?.append(",")
                    }
                    if checkStringIsValue(string: string) {
                        string!.insert(contentsOf: "已选(\(count)) ", at: string!.startIndex)
                        string?.removeLast()
                    }
                }
            }
        }
        return string
    }
    func filterAllSelectedCategoryNames() -> String? {
        var string:String?
        var count = 0
        for item in self.filterAllCategoryListArray {
            if checkArrayHasLessOneValue(arr: item.dataArray) {
                for sItem in item.dataArray! {
                    if sItem.isTempSelected && checkStringIsValue(string: sItem.modelValue) {
                        count += 1
                        string?.append(sItem.modelValue)
                        string?.append(",")
                    }
                    if checkStringIsValue(string: string) {
                        string!.insert(contentsOf: "已选(\(count)) ", at: string!.startIndex)
                        string?.removeLast()
                    }
                }
            }
        }
        return string
    }
}


extension LFFilterFilterMenuView {
    // MARK: -- LFFilterSideInputCell Delegate
    
    func lfFilterSideInputCellInputMinPrice(cell: LFFilterSideInputCell, min: String) {
        self.selectedMinPrice = min
    }
    
    func lfFilterSideInputCellInputMaxPrice(cell: LFFilterSideInputCell, max: String) {
        self.selectedMaxPrice = max
    }
}

/*
 数据结构
 [
     {
         name:"1", // 菜单标题
         items:[
             {
                 name:"11", // 筛选项
                 items:[ // 特殊筛选项多一层子类，品牌，品类
                     {
                         name:""

                     }
                 ]
             }
         ]
     },
     {
         name:"2",
         items:[
             {
                 name:"22",
                 items:[]
             }
         ]
     },
]
*/


extension LFFilterFilterMenuView {
    func createFilterDataModel()  {
        let arrItem1 = ["包袋","单肩包","复古包","男包","女包","双肩包","挎包","包袋","单肩包","复古包","男包","女包","双肩包","挎包",]
        var arr1 = [LFFilterFilterDataModel]()
        for index in 0..<arrItem1.count {
            let model = LFFilterFilterDataModel.init()
            model.modelName = arrItem1[index]
            model.modelValue = "\(index)"
            
            arr1.append(model)
        }
        
        let cateModel = LFFilterFilterDataModel()
        cateModel.dataArray = arr1
        self.filterAllCategoryListArray.append(cateModel)
        
        let arrItem2 = ["全新","99新","95新","80新","60新"]
        var arr2 = [LFFilterFilterDataModel]()
        for index in 0..<arrItem2.count {
            let model = LFFilterFilterDataModel.init()
            model.modelName = arrItem2[index]
            model.modelValue = "\(index)"
            arr2.append(model)
        }
        
        let arrItem3 = ["98折","95折","9折","8折","7折"]
        var arr3 = [LFFilterFilterDataModel]()
        for index in 0..<arrItem3.count {
            let model = LFFilterFilterDataModel.init()
            model.modelName = arrItem3[index]
            model.modelValue = "\(index)"
            arr3.append(model)
        }
        
        let model = LFFilterFilterDataModel.init()
        model.modelName = "只看在售"
        model.modelSideFilterShow = false
        let arr4 = [model]
        
        let arrItem5 = ["女性","男性","中性"]
        var arr5 = [LFFilterFilterDataModel]()
        for index in 0..<arrItem5.count {
            let model = LFFilterFilterDataModel.init()
            model.modelName = arrItem5[index]
            model.modelValue = "\(index)"
            arr5.append(model)
        }
        
        
        // 菜单标题
        let tArr = ["价格","分类","成色","折扣","只看在售","适用人群"]
        let typeArr = [LFFilterFitlerMenuType.menuTypeCollection,LFFilterFitlerMenuType.menuTypeCollection,LFFilterFitlerMenuType.menuTypeOnlyTitle,LFFilterFitlerMenuType.menuTypeCollection,LFFilterFitlerMenuType.menuTypeCollection,LFFilterFitlerMenuType.menuTypeCollection]
        for index in 0..<tArr.count {
            let model = LFFilterFilterDataModel()
            model.modelName = tArr[index]
            model.modelFilterMenuType = typeArr[index]
            
            if index == 1 {
                model.modelKey = "group"
                
                model.dataArray = arr1
                model.modelRequestParmType = .category
                model.modelShowIcon = true
            } else if index == 2 {
                model.modelKey = "chengSe"
                model.dataArray = arr2
                model.modelRequestParmType = .filter
                model.modelShowIcon = true
            } else  if index == 3 {
                model.modelKey = "zheKou"
                model.dataArray = arr3
                model.modelRequestParmType = .filter
                model.modelShowIcon = true
            } else if index == 4 {
                model.modelKey = "active"
                model.dataArray = arr4
                model.modelRequestParmType = .sellStatus
                model.modelShowIcon = false
                model.modelSideFilterShow = false
            } else if index == 5 {
                model.modelKey = "people"
                model.dataArray = arr5
                model.modelRequestParmType = .filter
                model.modelSideFilterShow = true
            } else if index == 0 {
                model.modelKey = "price"
                model.modelRequestParmType = .price
                model.modelSideFilterShow = true
                model.modelShowIcon = false
            }
            if model.modelSideFilterShow {
                sideFilterSectionCount += 1
            }
            self.filterTitleDataArray.append(model)
        }
    }
}
