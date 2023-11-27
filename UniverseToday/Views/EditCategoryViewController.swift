//
//  EditCategoryViewController.swift
//  Universe
//
//  Created by 김하연 on 11/13/23.
//

import UIKit

class EditCategoryViewController: UIViewController {
    var categoryManager = CategoryManager.singletonCategoryManager
    
    var userCategories: [Int] = []
    var leftCategories: [Int] = []
    private lazy var tableView: UITableView = UITableView()
    
    
    private lazy var rightBarItem: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePressed))
        return btn
    }()
    
    @objc func savePressed(){
        categoryManager.setUserCategory(userCategories: userCategories)
        navigationController?.popViewController(animated: false)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = rightBarItem
        
        userCategories = categoryManager.getUserCategory()
        leftCategories = categoryManager.getLeftCategory()
        
        setupTableView()
    }
    
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
        tableView.register(EditCategoryCell.self, forCellReuseIdentifier: EditCategoryCell.id)
        tableView.dataSource = self
        tableView.delegate = self
    }
}



extension EditCategoryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.isEditing = true
        tableView.allowsSelection = false
        return section == 0 ? userCategories.count : leftCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditCategoryCell.id, for: indexPath) as! EditCategoryCell
        let category = indexPath.section == 0 ? Category(id: userCategories[indexPath.row]) : Category(id: leftCategories[indexPath.row])
        cell.categoryId = category.id
        cell.title.text = category.title
        cell.setSection(indexPath.section)
        cell.cellDelegate = self
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        indexPath.section == 0
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section == 0 {
            let removed = userCategories.remove(at: sourceIndexPath.row)
            userCategories.insert(removed, at: destinationIndexPath.row)
        }
    }
}


extension EditCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    
    // Prevent move cell from its own cell
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section != proposedDestinationIndexPath.section {
            return sourceIndexPath
        } else {
            return proposedDestinationIndexPath
        }
    }
}

extension EditCategoryViewController: EditCategoryCellDelegate {
    func addCategory(_ id: Int) {
        userCategories.append(id)
        leftCategories.removeAll(where: {$0 == id})
        tableView.reloadData()
    }
    
    func deleteCategory(_ id: Int) {
        userCategories.removeAll(where: {$0 == id})
        leftCategories.append(id)
        tableView.reloadData()
    }
    
    
}
