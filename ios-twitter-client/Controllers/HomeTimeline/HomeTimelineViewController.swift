//
//  HomeTimelineViewController.swift
//  ios-twitter-client
//
//  Created by OkuderaYuki on 2017/08/26.
//  Copyright © 2017年 Okudera Yuki. All rights reserved.
//

import Accounts
import UIKit
import SVProgressHUD

/// タイムライン画面
final class HomeTimelineViewController: UIViewController {
    
    // MARK: - properties
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let dataSource = HomeTimelineProvider()
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate var account: ACAccount? {
        didSet { requestHomeTimeline() }
    }
    fileprivate var alert: UIAlertController?
    
    private let homeTimelineAPI = HomeTimelineAPI()
    private let twitterAccounts = TwitterAccounts()
    
    // MARK: - view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    deinit {
        removeNotificationsObserver()
    }
    
    // MARK: - selector methods
    
    func didBecomeActive() {
        if account == nil {
            // アカウント情報を保持していない場合、アカウント情報取得から実行
            twitterAccounts.loadRegisteredAccounts()
        }
    }
    
    func pullToRefresh(sender: UIRefreshControl) {
        refreshControl.beginRefreshing()
        
        // アカウント情報を保持している場合、Timeline取得要求
        if account != nil {
            requestHomeTimeline()
        } else {
            // アカウント情報を保持していない場合、アカウント情報取得から実行
            twitterAccounts.loadRegisteredAccounts()
        }
    }
    
    // MARK: - private methods
    
    /// 初期処理
    private func setup() {
        twitterAccounts.delegate = self
        twitterAccounts.loadRegisteredAccounts()
        homeTimelineAPI.loadable = self
        registerObservers()
        setupTableView()
    }
    
    /// 通知を登録する
    private func registerObservers() {
        self.addNotificationObserver(name: .UIApplicationDidBecomeActive,
                                     selector: .didBecomeActive)
    }
    
    /// TableViewの初期処理
    private func setupTableView() {
        tableView.dataSource = dataSource
        tableView.estimatedRowHeight = HomeTimelineCell.estimatedRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: .pullToRefresh, for: .valueChanged)
    }
    
    /// ホームタイムライン取得APIリクエスト
    private func requestHomeTimeline() {
        guard let account = account else { return }
        
        if !refreshControl.isRefreshing {
            SVProgressHUD.stv.show()
        }
        homeTimelineAPI.load(account: account)
    }
}

// MARK: - fileprivate methods
private extension HomeTimelineViewController {
    
    /// アラートを表示する
    func showAlert() {
        guard let alert = alert else { return }
        present(alert, animated: true, completion: { self.alert = nil })
    }
    
    /// Twitterアカウント選択用のアクションシートを表示する
    func selectTwitter(accounts: [ACAccount]) {
        let actionSheet = UIAlertController(title: "twitter".localized(),
                                            message: "selectAccount".localized(),
                                            preferredStyle: .actionSheet)
        for account in accounts {
            
            let action = UIAlertAction(title: account.username,
                                       style: .default) { [weak self] _ in
                                        self?.account = account
            }
            actionSheet.addAction(action)
        }
        present(actionSheet, animated: true, completion: nil)
    }
}

// MARK: - TwitterAccountsDelegate
extension HomeTimelineViewController: TwitterAccountsDelegate {
    
    func didLoad(accounts: [ACAccount]) {
        
        switch accounts.count {
        case 0:
            // 設定アプリを開くアラートを表示する
            alert =  AlertHelper.alert(message: "settingTwitterAccount".localized(),
                                       rightButtonTitle: "setting".localized(),
                                       leftButtonTitle: "cancel".localized(),
                                       rightButtonAction: { _ in
                                        UrlScheme.open(with: Constants.UrlScheme.twitterSetting)
            })
            showAlert()
            
        case 1:
            account = accounts.first
        default:
            // 2件以上の場合アクションシートで選択させる
            selectTwitter(accounts: accounts)
        }
    }
    
    func didFailLoad(errorMessage: String) {
        
        switch errorMessage {
        case "notAuthorizedTwitterAccount".localized():
            
            // 設定アプリを開くアラートを表示する
            alert = AlertHelper.alert(message: errorMessage,
                                      rightButtonTitle: "setting".localized(),
                                      leftButtonTitle: "cancel".localized(),
                                      rightButtonAction: { _ in
                                        UrlScheme.open(with: Constants.UrlScheme.twitterPrivacySetting)
            })
            
        default:
            // アラートでエラーメッセージを表示する
            alert = AlertHelper.alert(message: errorMessage)
        }
        showAlert()
    }
}

// MARK: - HomeTimelineLoadable
extension HomeTimelineViewController: HomeTimelineLoadable {
    func setResult(result: HomeTimelineAPIStatus) {
        
        DispatchQueue.main.async {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            } else {
                SVProgressHUD.dismiss()
            }
        }
        
        switch result {
        case .loading: break
        case .loaded(let response):
            dataSource.set(tweets: response)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .offline:
            alert = AlertHelper.alert(message: "offline".localized())
            showAlert()
        case .timeout:
            alert = AlertHelper.alert(message: "timeout".localized())
            showAlert()
        case .error(message: let errorMessage):
            alert = AlertHelper.alert(message: errorMessage)
            showAlert()
        }
    }
}

// MARK: - Custom Selectors
private extension Selector {
    static let didBecomeActive = #selector(HomeTimelineViewController.didBecomeActive)
    static let pullToRefresh = #selector(HomeTimelineViewController.pullToRefresh(sender:))
}
