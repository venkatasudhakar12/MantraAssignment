//
//  ViewController.swift
//  Mantra
//
//  Created by Sudhakar on 09/01/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    
    fileprivate let viewModel = CategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.reloadSections = { [weak self] (section: Int) in
            self?.tableView?.beginUpdates()
            self?.tableView?.reloadSections([section], with: .fade)
            self?.tableView?.endUpdates()
        }
                
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.sectionHeaderHeight = 70
        tableView?.separatorStyle = .singleLine
        tableView?.dataSource = viewModel
        tableView?.delegate = viewModel
        tableView?.register(SubCategoryCell.nib, forCellReuseIdentifier: SubCategoryCell.identifier)
        tableView?.register(CategoryView.nib, forHeaderFooterViewReuseIdentifier: CategoryView.identifier)
    }

}

