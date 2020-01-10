//
//  CategoryView.swift
//  Mantra
//
//  Created by Sudhakar on 10/01/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//


import UIKit

protocol CategoryViewDelegate: class {
    func toggleSection(header: CategoryView, section: Int)
}

class CategoryView: UITableViewHeaderFooterView {

    var item: CategoryViewModelItem? {
        didSet {
            guard let item = item else {
                return
            }
            
            titleLabel?.text = item.sectionTitle.capitalized
            setCollapsed(collapsed: item.isCollapsed)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var arrowLabel: UILabel?
    var section: Int = 0
    
    weak var delegate: CategoryViewDelegate?
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
    
    @objc private func didTapHeader() {
        delegate?.toggleSection(header: self, section: section)
    }

    func setCollapsed(collapsed: Bool) {
        arrowLabel?.rotate(collapsed ? 0.0 : .pi)
    }
}


extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
}
