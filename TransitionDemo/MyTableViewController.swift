//
//  MyTableViewController.swift
//  TransitionDemo
//
//  Created by Allen long on 2018/9/17.
//  Copyright © 2018年 Allen long. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let style = LFTransitionStyle(rawValue: indexPath.row) else { return }
        let vc = TestViewController(transitionStyle: style)
        present(vc, animated: true, completion: nil)
    }
}
