//
//  Cells + Reuse.swift
//  Technical-test
//
//  Created by Користувач on 15.06.2023.
//

import UIKit

extension UIView {
    
    class func loadViewFromNib<T>(owner: Any? = nil) -> T? where T: UIView {
        
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)
        let view = nib.instantiate(withOwner: owner, options: nil).first as? T
        
        return view
    }
}

extension UITableViewCell {
    class var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

extension UITableView {
    
    func register<T: UITableViewCell>(_ cellType: T.Type, nibName: String? = nil, customIdentifier: String? = nil) {
        let identifier = customIdentifier ?? "\(cellType)"
        let cellnibName = nibName ?? "\(cellType)"
        let nib = UINib(nibName: cellnibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func cell<T: UITableViewCell>(type: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            print("No such cell(\(T.self) for \(T.reuseIdentifier) reuseIdentifier at \(indexPath)")
            return T.loadViewFromNib() ?? T()
        }
        
        return cell
    }
}
