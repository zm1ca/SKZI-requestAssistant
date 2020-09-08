//
//  UITableView+Ext.swift
//  testRequest
//
//  Created by Źmicier Fiedčanka on 4.09.20.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    
    func removeAccessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
