//
//  UITableView.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import UIKit

protocol CellConfigurable {
    associatedtype CellController
    var cellController: CellController? { get set }
}


final class TableViewDataSource<Model, Cell: UITableViewCell>: NSObject, UITableViewDataSource where Cell: Reusable, Cell: CellConfigurable, Model == Cell.CellController {
    
    var dataObject: Array<Model> = Array() {
        didSet {
            tableView.reloadData()
        }
    }
    fileprivate unowned var tableView: UITableView
    
    init(forTableView tableView: UITableView) {
        self.tableView = tableView
    }
    
    // MARK: TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: Cell = tableView.dequeueReusableCell(with: indexPath)
        cell.cellController = dataObject[indexPath.row]
        return cell
    }
}

