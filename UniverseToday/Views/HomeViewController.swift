//
//  HomeViewController.swift
//  Universe
//
//  Created by 김하연 on 11/11/23.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    var categoryManager = CategoryManager.singletonCategoryManager
    var userCategories: [Int] = []
    let newsManager = NewsManager()
    let launchManager = LaunchManager()

    private lazy var tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userCategories = categoryManager.getUserCategory()
        categoryManager.delegate = self
        registerTableViewCell()
        setupTableView()
        setupManagerOfCell()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupManagerOfCell() {
        if userCategories.contains(1){
            NotificationCenter.default.addObserver(self, selector: #selector(loaded), name: NSNotification.Name(K.loaded), object: nil)
        }
        if userCategories.contains(2){
            newsManager.delegate = self
            newsManager.performRequest()
        }
        if userCategories.contains(3){
            launchManager.delegate = self
            launchManager.performRequest()
        }
    }
    
    private func registerTableViewCell() {
        tableView.register(HomeCategoryHeader.self, forHeaderFooterViewReuseIdentifier: HomeCategoryHeader.id)
        tableView.register(HomeCategoryFooter.self, forHeaderFooterViewReuseIdentifier: HomeCategoryFooter.id)
        
        tableView.register(ApodCell.self, forCellReuseIdentifier: ApodCell.id)
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.id)
        tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.id)
        tableView.register(QuotesMusicCell.self, forCellReuseIdentifier: QuotesMusicCell.id)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
}



extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: - section and header
    func numberOfSections(in tableView: UITableView) -> Int {
        userCategories = categoryManager.getUserCategory()
        return userCategories.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categoryId = userCategories[section]
        switch categoryId {
        case 2: //news
            return 5
        case 3: //launch
            return 3
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeCategoryHeader.id) as! HomeCategoryHeader
        let categoryId = userCategories[section]
        let category = Category(id: categoryId)
        header.title.text = category.title
        header.subTitle.text = category.subTitle
        return header
    }
    

    //MARK: - custom cell according to the category id
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let categoryId = userCategories[indexPath.section]
        switch categoryId {
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: ApodCell.id, for: indexPath) as! ApodCell
        case 2:
            let postCell = tableView.dequeueReusableCell(withIdentifier: NewsCell.id, for: indexPath) as! NewsCell
            guard newsManager.news.isEmpty else {
                let post = newsManager.news[indexPath.row]
                postCell.title.text = post.title
                postCell.site.text = post.news_site
                
                let clickNews = CustomTapGesture(target: self, action: #selector(pushNewsDetail(gesture:)))
                clickNews.url = post.url
                postCell.title.addGestureRecognizer(clickNews)
                
                return postCell
            }
            cell = postCell
        case 3:
            let launchCell = tableView.dequeueReusableCell(withIdentifier: LaunchCell.id, for: indexPath) as! LaunchCell
            guard launchManager.launches.isEmpty else {
                let launch: LaunchModel = launchManager.launches[indexPath.row]
                launchCell.rocketName.text = launch.rocketName
                launchCell.image.load(urlString: launch.image)
                
                return launchCell
            }
            cell = launchCell
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: QuotesMusicCell.id, for: indexPath) as! QuotesMusicCell
        }
        return cell
    }
    
    @objc func pushNewsDetail(gesture: CustomTapGesture) {
        if let url = gesture.url {
            navigationController?.pushViewController(NewsDetailViewController(newsUrl: url), animated: false)
        }
    }
    
    //MARK: - height of header and cell
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    //MARK: - footer (edit button)
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeCategoryFooter.id) as! HomeCategoryFooter
        footer.editButton.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        return footer
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section==tableView.numberOfSections-1 ? UITableView.automaticDimension : 0
    }
    @objc func editButtonPressed(sender: UIButton!) {
        navigationController?.pushViewController(EditCategoryViewController(), animated: false)
    }
}
    

extension HomeViewController: CategoryManagerDelegate {
    func didUpdateCategory(_ categoryManager: CategoryManager) {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.setupManagerOfCell()
        }
    }
}


extension HomeViewController {
    // update tableview cell's height after apod loaded
    @objc func loaded() {
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
}
extension HomeViewController: NewsManagerDelegate, LaunchManagerDelegate {
    func newsLoaded() { // reload news section
        if let newsSection = userCategories.firstIndex(of: 2) {
            reloadSection(newsSection)
        }
    }
    
    func launchLoaded() {   // reload launch section
        if let launchSection = userCategories.firstIndex(of: 3) {
            reloadSection(launchSection)
        }
    }
    
    private func reloadSection(_ section: Int){
        DispatchQueue.main.async {
            self.tableView.reloadSections(IndexSet(section...section), with: .automatic)
        }
    }
}


extension HomeViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}


//MARK: - custom UITapGestureRecognizer to send news url
class CustomTapGesture: UITapGestureRecognizer {
    var url: String?
}
