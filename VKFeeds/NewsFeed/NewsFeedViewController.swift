//
//  NewsFeedViewController.swift
//  VKFeeds
//
//  Created by PavelM on 17/08/2019.
//  Copyright (c) 2019 PavelM. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: class {
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic {

  var interactor: NewsFeedBusinessLogic?
  var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
  var authService: AuthService

  // MARK: Object lifecycle
  
  init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?,authService: AuthService) {
    self.authService = authService
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  private var refreshControll: UIRefreshControl = {
    let refreshControll = UIRefreshControl()
    refreshControll.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
    return refreshControll
  }()
  
  private var feedViewModel = FeedViewModel.init(cells: [], footerTitle: nil)
   private var titleView = TitleView()
  private lazy var footerView = FooterView(frame: .init(x: 0, y: 0, width: 0, height: 100))
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = NewsFeedInteractor(authService: authService)
    let presenter             = NewsFeedPresenter()
    let router                = NewsFeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  @IBOutlet weak var tableView: UITableView!
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUPGradientLayer()
//    view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    setUPTableView()
    // Получить посты
    interactor?.makeRequest(request: .getNewsFeed)
    interactor?.makeRequest(request: .getUser)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setUPTopBar()
  }
  
  private func setUPGradientLayer() {
    let gradientView = GradientView()
    view.insertSubview(gradientView, at: 0)
    gradientView.fillSuperview()
  }
  
  private func setUPTopBar() {
    // Сделаю топ бар для статус бара
    let topBar = UIView(frame: UIApplication.shared.statusBarFrame)
    topBar.backgroundColor = .white
    topBar.layer.shadowColor = UIColor.black.cgColor
    topBar.layer.shadowOpacity = 0.3
    topBar.layer.shadowOffset = CGSize.zero
    topBar.layer.shadowRadius = 8
    
    self.view.addSubview(topBar)
    
    self.navigationController?.hidesBarsOnSwipe = true
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationItem.titleView = titleView
  }
  
  private func setUPTableView() {
    let topInsert: CGFloat = 8
    
    tableView.separatorStyle = .none
    tableView.backgroundColor = .clear
    tableView.keyboardDismissMode = .interactive
    tableView.contentInset.top = topInsert
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.addSubview(refreshControll)
    // Set FooterView
    tableView.tableFooterView = footerView
    
//    tableView.register(NewsFeedCell.loadFromNib(), forCellReuseIdentifier: NewsFeedCell.cellID)
    tableView.register(NewsFeedCodeCell.self, forCellReuseIdentifier: NewsFeedCodeCell.cellId)

  }
  
  @objc private func didRefresh() {
    interactor?.makeRequest(request: .getNewsFeed)
  }
  
  
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
    switch viewModel {

    case .displayNewsFeed(let feedViewModel):
      self.feedViewModel = feedViewModel
      tableView.reloadData()
      refreshControll.endRefreshing()
      guard let footerTitle = feedViewModel.footerTitle else {return}
      footerView.setTitle(footerTitle)
      
    case .displayTitleFeed(let titleViewModel):
      
      titleView.set(titleViewViewModel: titleViewModel)
      
    case .displayFooterLoader:
      footerView.showLoader()
    }
    
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
      interactor?.makeRequest(request: .getNextBach)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}



extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return feedViewModel.cells.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCodeCell.cellId, for: indexPath) as! NewsFeedCodeCell
    
    let cellViewModel = feedViewModel.cells[indexPath.row]
    cell.didTapMoreTextButtonCLouser = didTapMoreTextButtonInCell
    cell.set(viewModel: cellViewModel)
    
    return cell
  }
  
  private func didTapMoreTextButtonInCell(cell: NewsFeedCodeCell) {
    print("MoreTextButton")
    guard let indexPath = tableView.indexPath(for: cell) else {return}
    let cellViewModel = feedViewModel.cells[indexPath.row]
    
    interactor?.makeRequest(request: .revealPostId(postId: cellViewModel.postId))
  }
  

  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return feedViewModel.cells[indexPath.row].sizes.totalHeight
  }
  
  // Так как при изменение размера ячейки Задействуется этот метод
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return feedViewModel.cells[indexPath.row].sizes.totalHeight
  }
  
}
