//
//  ListViewController.swift
//  tvmazetechtest
//
//  Created by David Martin on 15/11/21.
//

import Lottie
import UIKit

protocol ListViewControllerDelegate: AnyObject {
    func navigateToDetail(by id: Int)
}

class ListViewController: BaseViewController {
    @IBOutlet private var tableView: UITableView! {
        didSet {
            self.tableView.keyboardDismissMode = .onDrag
        }
    }

    @IBOutlet private var animationView: AnimationView! {
        didSet {
            self.animationView.layer.cornerRadius = 8
            self.animationView.contentMode = .scaleAspectFit
            self.animationView.loopMode = .loop
            self.animationView.backgroundBehavior = .pauseAndRestore
        }
    }

    @IBOutlet private var notFoundResultsLabel: UILabel! {
        didSet {
            self.notFoundResultsLabel.isHidden = true
            self.notFoundResultsLabel.textColor = .lightGray
            self.notFoundResultsLabel.font = UIFont.systemFont(ofSize: 16)
        }
    }

    @Inject
    var viewModel: ListViewModel

    @Inject
    private var wireframe: ListWireframe

    private let search = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitle()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initLottieAnimation()
        self.initRefreshControl()
        self.initSearchController()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fetch()
    }

    override func bindViewModels() {
        super.bindViewModels()
        self.viewModel.models.subscribe { [weak self] response in
            guard let self = self, let models = response else { return }

            self.refreshTableView()
            self.stopAnimation()
            self.setSearchControllerIntoNavigation()
            self.hideKeyboard()

            let hasResults = !models.isEmpty
            if hasResults {
                self.hideNotFoundResultsLabel()
            } else {
                self.showNotFoundResultsLabel(for: self.search.searchBar.text)
            }
        }
        self.viewModel.detailId.subscribe { [weak self] response in
            guard let self = self, let id = response else { return }
            self.navigate(to: id)
        }
    }

    override func unBindViewModels() {
        super.unBindViewModels()
        self.viewModel.models.unsubscribe()
        self.viewModel.detailId.unsubscribe()
    }

    @objc private func fetch() {
        guard !self.isSearched() else { return }
        self.playAnimation()
        self.viewModel.fetch()
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.models.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ShowsCell = tableView.dequeueReusableCell(withIdentifier: ShowsCell.identifier, for: indexPath) as? ShowsCell,
              let show = self.viewModel.models.value?[safe: indexPath.row] else { return UITableViewCell() }
        cell(self.view.frame.height, show)
        return cell
    }

    private func showNotFoundResultsLabel(for text: String?) {
        if let text = self.search.searchBar.text, !text.isEmpty {
            self.notFoundResultsLabel.isHidden = false
            self.notFoundResultsLabel.text = ["Not found results for", text].compactMap { $0 }.joined(separator: " ")
        }
    }

    private func hideNotFoundResultsLabel() {
        self.notFoundResultsLabel.isHidden = true
    }

    private func refreshTableView() {
        self.tableView.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }

    private func setSearchControllerIntoNavigation() {
        self.navigationItem.searchController = self.search
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = self.viewModel.models.value?[safe: indexPath.row] else { return }
        self.viewModel.didSelect(by: model.id)
    }
}

// MARK: - Presentation

extension ListViewController {
    private func initTitle() {
        self.title = NSLocalizedString("list.title", comment: "Title of the main list")
    }
}

// MARK: - Lottie animations

extension ListViewController {
    private func initLottieAnimation() {
        let animation = Animation.named("loading")
        self.animationView.animation = animation
    }

    private func playAnimation() {
        self.animationView.play()
        self.animationView.isHidden = false
    }

    private func stopAnimation() {
        self.animationView.stop()
        self.animationView.isHidden = true
    }
}

// MARK: - Refresh control

extension ListViewController {
    private func initRefreshControl() {
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.tintColor = .lightGray
        self.tableView.refreshControl?.addTarget(self, action: #selector(self.fetch), for: .valueChanged)
    }
}

// MARK: - Search controller

extension ListViewController: UISearchBarDelegate {
    private func initSearchController() {
        self.search.searchBar.delegate = self
        self.search.searchBar.placeholder = "Search"
        self.search.obscuresBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.definesPresentationContext = true

        let textFieldInsideSearchBar = self.search.searchBar.value(forKey: "searchField") as? UITextField
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = .gray

        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 16)
        ], for: .normal)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 16)
        ]
    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange _: String) {
        guard let text = searchBar.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.clearSearchBar()
            self.fetch()
            return
        }
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.enableFilter(_:)), object: searchBar)
        perform(#selector(self.enableFilter), with: searchBar, afterDelay: 0.3)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        self.clearSearchBar()
        self.fetch()
    }

    @objc func enableFilter(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text.count >= 3 else { return }
        self.search(by: text)
    }

    private func search(by text: String) {
        self.playAnimation()
        self.viewModel.search(by: text)
    }

    private func isSearched() -> Bool {
        guard let text = self.search.searchBar.text, !text.isEmpty else { return false }
        return true
    }

    private func clearSearchBar() {
        self.search.searchBar.text?.removeAll()
    }

    private func hideKeyboard() {
        self.search.searchBar.endEditing(true)
    }
}

// MARK: - Scrolling

extension ListViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        guard (offsetY > contentHeight - scrollView.frame.height * 4),
              !self.viewModel.isLoading, !self.isSearched() else { return }
        self.viewModel.fetchNext()
    }
}

// MARK: - Wireframe

extension ListViewController {
    func navigate(to id: Int) {
        self.wireframe.navigate(to: .detail(by: id), with: self.navigationController)
    }
}
