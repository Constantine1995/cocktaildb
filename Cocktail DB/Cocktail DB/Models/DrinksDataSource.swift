//
//  DrinksDataSource.swift
//  Cocktail DB
//
//  Created by Constantine Likhachov on 9/17/19.
//  Copyright © 2019 Constantine Likhachov. All rights reserved.
//

import Moya

class DrinksDataSource {

    private let drinksService = DrinkService()
    private var categories = [Category]()
    private var allCategories = [Category]()
    private var drinks = [[Drink]]()
    private let delegate: DataSourceDelegate

    // MARK: - Initialization
    
    init(delegate: DataSourceDelegate) {
        self.delegate = delegate
    }
    
    func loadCategories() {
        drinksService.fetchCategories {  [weak self] (response, error) in
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            self?.categoriesDidLoad(response: response!)
        }
    }
    
    func loadDrinksByCategories(_ categories: [Category]) {
        
        var categoriesForLoad = categories
        guard !categoriesForLoad.isEmpty else { return }
        guard let category = categoriesForLoad.first else { return}
        drinksService.fetchDrinks(categoryName: category.name ?? "") { [weak self] (response, error) in
            
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            categoriesForLoad.removeFirst()

            self?.drinksDidLoadForCategory(сategory: category, responce: response!)
            self?.loadDrinksByCategories(categoriesForLoad)
        }
    }
    
    //MARK - Helpers
    
    func numberOfSections() -> Int {
        return categories.count
    }
    
    func categoryForSection(_ section: Int) -> Category {
        return categories[section]
    }
    
    func getCategories() -> [Category] {
        return categories
    }
    
    func drinkForIndexPath(indexPath: IndexPath) -> Drink {
        guard drinks.count > indexPath.section, drinks[indexPath.section].count > indexPath.row else { return Drink()}
        return drinks[indexPath.section][indexPath.row]
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard drinks.count > section else { return 0 }
        
        return drinks[section].count
    }
    
    //MARK: - Data did load methods
    
    private func categoriesDidLoad(response: Categories) {
        categories.removeAll()
        guard let categoriesFromServes = response.list else { return }
        
        allCategories = categoriesFromServes
        categories = categoriesFromServes
        delegate.didLoadCategories()
    }
    
    
//    private func drinksDidLoadForCategory(сategory: DrinksCategory, responce: DrinksCodable) {
////        guard let section = categories.firstIndex(of: сategory),
////            let drinksForSection = responce.list else { return }
//        drinks.append(responce)
//        delegate.didLoadDrinksForSection(section: сategory)
//    }

    private func drinksDidLoadForCategory(сategory: Category, responce: Drinks) {
        guard let section = categories.firstIndex(of: сategory),
            let drinksForSection = responce.list else { return }

        drinks.append(drinksForSection)
        delegate.didLoadDrinksForSection(section: section)
    }
}
