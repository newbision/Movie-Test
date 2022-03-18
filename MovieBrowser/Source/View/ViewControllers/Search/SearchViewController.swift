//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loaderWrapperView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var searchStatus: SearchStatus = .none
    
    var viewModel = SearchViewModel(movieService: AppService.shared.movieService)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        self.registerNibsForTableViewCell()
        self.loaderWrapperView.layer.cornerRadius = 5
    }
    
    // MARK: - Actions
    
    func search(showLoader: Bool = true) {
        let keyword = self.searchTextField.text ?? ""
        if keyword.isEmpty {
            self.viewModel.clearSearch()
            self.refreshTableView()
            self.searchStatus = .none
            return
        }
        
        self.searchStatus = .searching
        
        if showLoader {
            self.showLoading()
        }
        
        self.viewModel.requestGetMovies(newKeyword: keyword) { [weak self] success, message in
            if showLoader {
                self?.hideLoading()
            }
            self?.refreshTableView()
            self?.searchStatus = .none
        }
    }
    
    func loadMore() {
        if !self.viewModel.canLoadMore() {
            return
        }
        
        self.showLoading()
        self.viewModel.requestGetMovies(newKeyword: nil) { [weak self] success, message in
            self?.hideLoading()
            self?.refreshTableView()
            
            if !success {
                self?.showAlert("Error!", Message: message, OkButtonTitle: "Ok", OkCompletionBlock: nil)
            }
        }
    }
    
    // MARK: - Navigations
    
    func showLoading() {
        DispatchQueue.main.async {
            self.loadingView.layer.removeAllAnimations()
            self.loadingView.isHidden = false
            self.loadingView.alpha = 0
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
                self.loadingView.alpha = 1
            } completion: { completed in
            }
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingView.layer.removeAllAnimations()
            self.loadingView.isHidden = false
            self.loadingView.alpha = 1
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
                self.loadingView.alpha = 0
            } completion: { completed in
                self.loadingView.isHidden = true
            }
        }
    }
    
    func gotoDetailsVC(at index: Int) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: UIConfig.StoryboardName.main.rawValue, bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: UIConfig.StoryboardID.mainDetails.rawValue) as? MovieDetailViewController {
                vc.viewModel = self.viewModel.movies[index]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    // MARK: - UI Events
    
    @IBAction func onSearchButtonClick(_ sender: Any) {
        self.view.endEditing(true)
        self.search()
    }

    @IBAction func onSearchTextFieldChanged(_ sender: Any) {
        self.searchStatus = .none
        self.search(showLoader: false)
    }
    
    @IBAction func onSearchTextFieldBeginEditing(_ sender: Any) {
        self.searchStatus = .editing
        self.refreshTableView()
    }
    
    @IBAction func onSearchTextFieldEndEditing(_ sender: Any) {
        self.searchStatus = .none
        self.refreshTableView()
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func registerNibsForTableViewCell() {
        self.tableView.register(UINib(nibName: UIConfig.TableViewCellNibName.movieItem.rawValue, bundle: nil), forCellReuseIdentifier: UIConfig.TableViewCellID.movieItem.rawValue)
        self.tableView.tableFooterView = UIView.init()
    }
    
    func refreshTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func configureMovieCell(cell: MovieItemTableViewCell, index: Int) {
        cell.setupView(viewModel: self.viewModel.movies[index])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.resultsCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIConfig.TableViewCellID.movieItem.rawValue) as! MovieItemTableViewCell
        self.configureMovieCell(cell: cell, index: indexPath.row)
        return cell
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.searchStatus != .editing {
            let currentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

            if maximumOffset - currentOffset <= 10.0 {
                self.loadMore()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        self.gotoDetailsVC(at: indexPath.row)
    }
    
}

fileprivate enum SearchStatus {
    
    case none
    case editing
    case searching
    
}
