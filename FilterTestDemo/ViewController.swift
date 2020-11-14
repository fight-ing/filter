//
//  ViewController.swift
//  FilterTestDemo
//
//  Created by 刘飞 on 2020/11/4.
//

import UIKit

@_exported import SnapKit

class ViewController: UIViewController,LFFilterSortMenuViewDelegate,LFFilterFilterMenuViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    var cartProductListCollectionView:UICollectionView!
    var sortView:LFFilterSortMenuView!
    var filterView:LFFilterFilterMenuView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSubview()
    }

    // MARK: -- Create Subviews
    func createSubview()  {
        self.view.backgroundColor = UIColor.lightGray
        sortView = LFFilterSortMenuView()
        sortView.viewDelegate = self
        sortView.sortCount = 4
        self.view.addSubview(sortView)
        sortView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(80)
            make.height.equalTo(sortView.sortViewHeight)
        }
        
        filterView = LFFilterFilterMenuView()
        self.view.addSubview(filterView)
        filterView.viewDelegate = self
        
        filterView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(sortView.snp.bottom).offset(10)
            make.height.equalTo(filterView.filterViewHeight)
        }
        
        
        
        
        let layout = UICollectionViewFlowLayout.init()
        cartProductListCollectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        cartProductListCollectionView.dataSource = self
        cartProductListCollectionView.delegate = self
        cartProductListCollectionView.register(ShopCartListItemCell.self, forCellWithReuseIdentifier: "ShopCartListItemCell")
        cartProductListCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(cartProductListCollectionView)
        cartProductListCollectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(filterView.snp.bottom)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        if #available(iOS 13.0, *) {
            cartProductListCollectionView.automaticallyAdjustsScrollIndicatorInsets = false
            
        } else {
            // Fallback on earlier versions
        }
    }
    
    // MARK: -- LFFilterFilterMeneViewDelegate
    func lfFilterFilterMenuViewDidSaveSelectedRequestParam(view: LFFilterFilterMenuView, dict: [String : Any]) {
        print(dict)
    }
    
    // MARK: -- LFFilterSortMenuViewDelegate
    func lfFilterSortMenuView(view: LFFilterSortMenuView, didSelect item: LFFilterSortDataModel) {
        print("\(item.modelName)   \(item.modelStatus)")
    }
    func lfFilterSortMenuViewFilterClicked(view: LFFilterSortMenuView) {
        print("点击筛选")
        filterView.showSideFilterCollection()
    }
    
}

extension ViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
    
    // MARK: -- UICollectionView DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: collectionView.frame.size.width, height: 130)
        
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCartListItemCell", for: indexPath) as! ShopCartListItemCell
            
        return cell
        
        
    }
    
    // MARK: -- UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filterView.showSideFilterCollection()
    }
}

