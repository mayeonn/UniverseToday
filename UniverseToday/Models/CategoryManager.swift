//
//  CategoryManager.swift
//  Universe
//
//  Created by 김하연 on 11/14/23.
//

import Foundation

protocol CategoryManagerDelegate {
    func didUpdateCategory(_ categoryManager: CategoryManager)
}

class CategoryManager {
    let allCategories: [Int] = [1, 2, 3, 4, 5]
    
    static let singletonCategoryManager = CategoryManager()
    
    var delegate: CategoryManagerDelegate?
    
    func getUserCategory() -> [Int]{
        let categories: [Int] = UserDefaults.standard.value(forKey: "Category") as? [Int] ?? [1, 2, 3]
        return categories
    }
    
    func setUserCategory(userCategories: [Int]) {
        UserDefaults.standard.setValue(userCategories, forKey: "Category")
        delegate?.didUpdateCategory(self)
    }
    
    func getLeftCategory() -> [Int]{
        let userCategories: [Int] = getUserCategory()
        let leftCategories: [Int] = allCategories.filter{!userCategories.contains($0)}

        return leftCategories
    }
}
