//
//  CategoryViewModel.swift
//  Mantra
//
//  Created by Sudhakar on 10/01/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import Foundation
import UIKit

enum SubCategoryViewModelItemType {
    case subCategory
}
protocol CategoryViewModelItem {
    var type: SubCategoryViewModelItemType { get }
    var sectionTitle: String { get set }
    var rowCount: Int { get }
    var isCollapsible: Bool { get }
    var isCollapsed: Bool { get set }
}

extension CategoryViewModelItem {
    var rowCount: Int {
        return 1
    }
    
    var isCollapsible: Bool {
        return true
    }
}

class CategoryViewModel: NSObject {
    var items = [CategoryViewModelItem]()
    
    var reloadSections: ((_ section: Int) -> Void)?
    
    override init() {
        super.init()
        var categories = [Category]()
        if let path = Bundle.main.path(forResource: "AllMenu", ofType: "json") {
                 do {
                     let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                     do {
                        categories = try JSONDecoder().decode([Category].self, from: data)
                         
                     }catch{
                         debugPrint(error.localizedDescription)
                     }
                 } catch {
                     debugPrint(error.localizedDescription)
                 }
             }
        
        for category in categories{
            let attributesItem = ProfileViewModeSubCategoryItem(sectionTitle: category.name, subCategories: category.subCategory)
            items.append(attributesItem)
        }
    }
}

extension CategoryViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = items[section]
        guard item.isCollapsible else {
            return item.rowCount
        }
        
        if item.isCollapsed {
            return 0
        } else {
            return item.rowCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
         if let item = item as? ProfileViewModeSubCategoryItem,let cell = tableView.dequeueReusableCell(withIdentifier: SubCategoryCell.identifier, for: indexPath) as? SubCategoryCell {
            cell.item = item.subCategories[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

extension CategoryViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CategoryView.identifier) as? CategoryView {
            let item = items[section]
            
             headerView.item = item
             headerView.section = section
             headerView.delegate = self
             headerView.contentView.backgroundColor = .white
            
            return headerView
        }
        return UIView()
    }
}

extension CategoryViewModel: CategoryViewDelegate {
    func toggleSection(header: CategoryView, section: Int) {
        var item = items[section]
        if item.isCollapsible {
            
            // Toggle collapse
            let collapsed = !item.isCollapsed
            item.isCollapsed = collapsed
            header.setCollapsed(collapsed: collapsed)
            
            // Adjust the number of the rows inside the section
            reloadSections?(section)
        }
    }
}


class ProfileViewModeSubCategoryItem: CategoryViewModelItem {

    var type: SubCategoryViewModelItemType {
        return .subCategory
    }
    
    var rowCount: Int {
        return subCategories.count
    }
    
    var isCollapsed = true
    
    var subCategories: [SubCategory]
    var sectionTitle: String
    init(sectionTitle: String, subCategories: [SubCategory]) {
        self.sectionTitle = sectionTitle
        self.subCategories = subCategories
    }
}



