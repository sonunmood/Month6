//
//  ViewController.swift
//  Month6
//
//  Created by Sonun on 14/6/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private lazy var toDoListtableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemGray5
        tv.register(UITableViewCell.self, forCellReuseIdentifier: Constants.reuseId.tableViewCellID)
        tv.dataSource = self
        return tv
    }()
    
    var list: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        navigationItem.title = Constants.titles.mainTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    @objc
    private func didTapAdd() {
        let alert = UIAlertController(title: "New Item", message: "Enter new to do list item", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Item is ..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    
                    DispatchQueue.main.async {
                        self?.list.append(text)
                        self?.toDoListtableView.reloadData()
                        
                    }
                }
            }
        }))
        
        present(alert, animated: true)
    }
    
    private func setUpSubviews() {
        
        view.addSubview(toDoListtableView)
        
        toDoListtableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
}
