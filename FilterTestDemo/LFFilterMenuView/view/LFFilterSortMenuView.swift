//
//  LFFilterSortMenuView.swift
//  TestDemo
//
//  Created by 刘飞 on 2020/11/4.
//

import UIKit


protocol LFFilterSortMenuViewDelegate {
    func lfFilterSortMenuView(view:LFFilterSortMenuView ,didSelect item:LFFilterSortDataModel)

    
    func lfFilterSortMenuViewFilterClicked(view:LFFilterSortMenuView)
    
}
/**
 *  筛选-排序view
 *
 */
class LFFilterSortMenuView: UIView ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var viewDelegate:LFFilterSortMenuViewDelegate?
    var showCollectionView:UICollectionView!
    var sortDataArray = [LFFilterSortDataModel]()
    var sortCount = 4
    let sortViewHeight = 40
    override init(frame: CGRect) {
        super.init(frame: frame)
        createDatas()
        createSubview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createDatas()  {

        self.sortDataArray.append(self.createSortItem(name: "综合排序", key: "zonghe", showIcon: false, hasRes: false))
        self.sortDataArray.append(self.createSortItem(
                                    name: "价格",
                                    key: "price",
                                    showIcon: true, hasRes: true,
                                    normalIcon: "home_icon_sequence_default",
                                    selectIcon: "home_icon_sequence_jiangxu",
                                    reSelectIcon: "home_icon_sequence_shengxu"))
        self.sortDataArray.append(self.createSortItem(
                                    name: "最新上架",
                                    key: "date", showIcon: true, hasRes: true,
                                    normalIcon: "home_icon_sequence_default",
                                    selectIcon: "home_icon_sequence_jiangxu",
                                    reSelectIcon: "home_icon_sequence_shengxu"))
        self.sortDataArray.append(self.createSortItem(name: "筛选", key: "filter", showIcon: true, hasRes: false, normalIcon: "home_icon_filtrate", selectIcon: "home_icon_filtrate"))
        
    }
    
    private func createSortItem(name:String,key:String,showIcon:Bool,hasRes:Bool,normalIcon:String = "",selectIcon:String = "",reSelectIcon:String = "") -> LFFilterSortDataModel{
        let model = LFFilterSortDataModel()
        model.modelName = name
        model.modelKey = name
        model.modelShowIcoon = showIcon
        model.modelHasReSelected = hasRes
        model.modelNormalIcon = normalIcon
        model.modelSelectedIcon = selectIcon
        model.modelReselectedIcon = reSelectIcon
        return model
    }
    
    // MARK: -- Create Subviews
    func createSubview()  {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        showCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.addSubview(showCollectionView)
        
        showCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        showCollectionView.dataSource = self
        showCollectionView.delegate = self
        showCollectionView.showsHorizontalScrollIndicator = false
        showCollectionView.isScrollEnabled = false
        showCollectionView.backgroundColor = UIColor.white
        showCollectionView.register(LFFilterSortTitleCell.self, forCellWithReuseIdentifier: "LFFilterSortTitleCell")
    }
    
}

extension LFFilterSortMenuView {
    // MARK: -- UICollectionView DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(sortCount, sortDataArray.count)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if sortDataArray.count > 0 {
            return CGSize(width: Int(collectionView.frame.size.width)/min(sortCount, sortDataArray.count), height: 40)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LFFilterSortTitleCell", for: indexPath) as! LFFilterSortTitleCell
        if sortDataArray.count > indexPath.row {
            let item = sortDataArray[indexPath.row]
            cell.cellValueWithItem(model: item)
        }
        return cell
    }
    
    // MARK: -- UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == self.sortDataArray.count - 1 { // 筛选弹出筛选框，不改变排序状态
            viewDelegate?.lfFilterSortMenuViewFilterClicked(view: self)
            return
        }
        for index in 0..<self.sortDataArray.count {
            let item = self.sortDataArray[index]
            
            if index == indexPath.row {
                switch item.modelStatus {
                case .normal:
                    item.modelStatus = .selected
                case .selected:
                    item.modelStatus = item.modelHasReSelected ? .reSelected:.selected
                case .reSelected:
                    item.modelStatus = .selected
                }
                viewDelegate?.lfFilterSortMenuView(view: self, didSelect: item)
            } else {
                item.modelStatus = .normal
            }
        }
        collectionView.reloadData()
    }
}
