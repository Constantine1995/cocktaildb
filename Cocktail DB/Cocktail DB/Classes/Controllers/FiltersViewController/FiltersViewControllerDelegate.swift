//
//  FiltersViewControllerDelegate.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/18/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import UIKit

public protocol FiltersViewControllerDelegate {
    func filtersDidChange(filters: [String])
}

class FiltersViewController: UIViewController {
    
    // MARK: - Properties & IBOutlets
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var applyButton: UIButton!
    
    private static var allFilters = [String]()
    private static var previousSelectedFilters: [String]?
    private var currentSelectedFilters = [String]()
    private var delegate: FiltersViewControllerDelegate?
    private let heightForRowAt: CGFloat = 30.0
    
    // MARK: - Initialization
    
    static func create(with filters: [String], delegate: FiltersViewControllerDelegate) -> FiltersViewController {
        let vc = UIStoryboard(name: "FiltersViewController", bundle: nil).instantiateViewController(withIdentifier: "FiltersViewController") as! FiltersViewController
        
        if FiltersViewController.allFilters.isEmpty {
            FiltersViewController.allFilters = filters
        }
        vc.delegate = delegate
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurViewController()
    }
    
    private func configurViewController() {
        if FiltersViewController.previousSelectedFilters == nil {
            FiltersViewController.previousSelectedFilters = [String]()
        }
        configureApplyButton()
        registerTableViewCells()
        selectPreviousFilters()
    }
    
    private func configureApplyButton() {
        applyButton.layer.borderWidth = 1
        applyButton.layer.borderColor = UIColor.black.cgColor
        applyButton.layer.cornerRadius = 10
        applyButton.clipsToBounds = true
        applyButton.isEnabled = isFiltersChanged()
    }
    
    private func registerTableViewCells() {
        tableView.register(FilterCell.nib, forCellReuseIdentifier: FilterCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    private func updateApplyButton() {
        applyButton.isEnabled = isFiltersChanged()
    }
    
    private func isFiltersChanged() -> Bool {
        guard let previousFilters = FiltersViewController.previousSelectedFilters else { return true }
        
        return previousFilters != currentSelectedFilters
    }
    
    private func selectPreviousFilters() {
        guard let previousSelectedFilterd = FiltersViewController.previousSelectedFilters, !previousSelectedFilterd.isEmpty else { return }
        
        for filter in previousSelectedFilterd {
            let _ = FiltersViewController.allFilters.map {
                if $0 == filter, let row = FiltersViewController.allFilters.firstIndex(of: $0) {
                    self.tableView.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
                    self.tableView.delegate?.tableView?(self.tableView, didSelectRowAt: IndexPath(row: row, section: 0))
                }
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func applyButtonPressed(_ sender: Any) {
        guard isFiltersChanged() else { return }
        guard let delegate = delegate else { return }
        
        FiltersViewController.previousSelectedFilters = currentSelectedFilters
        delegate.filtersDidChange(filters: currentSelectedFilters)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource

extension FiltersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FiltersViewController.allFilters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.reuseIdentifier) as! FilterCell
        cell.filterNameLabel.text = FiltersViewController.allFilters[indexPath.row]
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FiltersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAt
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath)  {
            cell.accessoryType = .checkmark
            currentSelectedFilters.append(FiltersViewController.allFilters[indexPath.row])
            updateApplyButton()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
            currentSelectedFilters.removeAll { $0 == FiltersViewController.allFilters[indexPath.row]}
            updateApplyButton()
        }
    }
}
