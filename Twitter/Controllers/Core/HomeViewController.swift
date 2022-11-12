//
//  HomeViewController.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 12.11.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - UI elements
    
    private let timelineTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBackground
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSuperview()
        setupTableView()
        setupSubviews()
    }
}

// MARK: - Setups

extension HomeViewController {
    private func setupSuperview() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupTableView() {
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
    }
    
    private func setupSubviews() {
        view.addSubview(divider)
        view.addSubview(timelineTableView)
        setupLayout()
    }
}

// MARK: - Table DataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello, World!"
        return cell
    }
}

// MARK: - Table Delegate

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Layout

private extension HomeViewController {
    enum Constants {
        static let dividerHeight: CGFloat = 1
        static let padding: CGFloat = 5
    }
    
    func setupLayout() {
        divider.prepareForAutoLayout()
        timelineTableView.prepareForAutoLayout()
        
        let constraints = [
            divider.heightAnchor.constraint(equalToConstant: Constants.dividerHeight),
            divider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding),
            divider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding),
            divider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            timelineTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            timelineTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            timelineTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            timelineTableView.bottomAnchor.constraint(equalTo: divider.topAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
