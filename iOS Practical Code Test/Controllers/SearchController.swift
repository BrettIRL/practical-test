//
//  SearchController.swift
//  iOS Practical Code Test
//
//  Created by Brett Cocking on 2018/10/20.
//  Copyright © 2018 Trademark Technology. All rights reserved.
//

import UIKit

class SearchController: UITableViewController {
    
    // MARK: Properties
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    let cellSpacingHeight: CGFloat = 7.0
    let cellId = "searchCell"
    
    var questions: [Question] = []
    
    // MARK: - 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        let tableTapGesture = UITapGestureRecognizer(target: self, action: #selector(tableTapHandler))
        tableTapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tableTapGesture)
        setupLayout()
    }
    
    @objc private func tableTapHandler() {
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    // MARK: - Set up UI
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupLayout() {
        view.backgroundColor = UIColor().fromHexValue(hex: "#EDEDED")
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor().fromHexValue(hex: "#4078C4")
        
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        
        if #available(iOS 11.0, *) {
            searchBar.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        }
        let cancelButtonAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
        
        navigationItem.titleView = searchBar
        setupEmptyTableView()
    }
    
    private func setupEmptyTableView() {
        let emptyTableLabel = UILabel()
        emptyTableLabel.text = "Stack Overflow Search"
        emptyTableLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        emptyTableLabel.textColor = UIColor().fromHexValue(hex: "#727272")
        emptyTableLabel.textAlignment = .center
        tableView.backgroundView = emptyTableLabel

        emptyTableLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyTableLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        emptyTableLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
    }
    
    private func showAlert(withTitle title: String, withMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true) { [weak self] in
            self?.setupEmptyTableView()
        }
    }
}

// MARK: - UITableViewDelegate

extension SearchController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        if questions.count == 0 {
            tableView.backgroundView?.isHidden = false
        } else {
            tableView.backgroundView?.isHidden = true
        }
        
        return questions.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        return headerView
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SearchTableViewCell
        cell.question = questions[indexPath.section]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionController = QuestionController()
        questionController.question = questions[indexPath.section]
        
        navigationController?.pushViewController(questionController, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension SearchController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchString = searchBar.text {
            tableView.backgroundView = loadingIndicator
            loadingIndicator.startAnimating()
            
            searchBar.endEditing(true)
            searchBar.setShowsCancelButton(false, animated: true)
            
            APIManager.shared.getQuestions(tagged: searchString, numberOfResults: 20) { [weak self] (searchResults, error) in
                guard error == nil else {
                    DispatchQueue.main.async {
                        self?.showAlert(withTitle: "Error", withMessage: "There has been a problem retrieving questions for that tag")
                    }
                    return
                }
                
                self?.questions = searchResults!.questions
                DispatchQueue.main.async {
                    self?.loadingIndicator.stopAnimating()
                    self?.setupEmptyTableView()
                    self?.tableView.reloadData()
                    self?.tableView.layoutIfNeeded()
                    self?.tableView.setContentOffset(.zero, animated: true)
                }
            }
        }
    }
}
