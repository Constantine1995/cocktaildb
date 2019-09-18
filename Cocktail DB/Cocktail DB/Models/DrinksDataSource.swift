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
//    private var categories = [Category]()
    private var categoriesNew = [DrinksCategory]()

//    private var allCategories = [Category]()
    private var allCategories = [DrinksCategory]()

//    private var drinks = [[Drink]]()
    private var drinksNew = [[DrinksCodable]]()

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
    
    func loadDrinksByCategories(_ categories: [DrinksCategory]) {
        
        var categoriesForLoad = categories
        guard !categoriesForLoad.isEmpty else { return }
        guard let category = categoriesForLoad.first else { return}
        drinksService.fetchDrinks(categoryName: category.strCategory ) { [weak self] (response, error) in
            
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            categoriesForLoad.removeFirst()
            self?.drinksDidLoadForCategory(сategory: category, responce: response!)
            self?.loadDrinksByCategories(categoriesForLoad)
        }
    }
//    func loadDrinksByCategories(_ categories: [Category]) {
//
//        var categoriesForLoad = categories
//        guard !categoriesForLoad.isEmpty else { return }
//        guard let category = categoriesForLoad.first else { return}
//        drinksService.fetchDrinks(categoryName: category.name ?? "") { [weak self] (response, error) in
//
//            if let error = error {
//                print("ERROR: \(error)")
//                return
//            }
//            categoriesForLoad.removeFirst()
//            self?.drinksDidLoadForCategory(сategory: category, responce: response!)
//
////            self?.drinksDidLoadForCategory(сategory: category, responce: response!)
//            self?.loadDrinksByCategories(categoriesForLoad)
//        }
//    }
    
    //MARK - Helpers
    
    func numberOfSections() -> Int {
        return categoriesNew.count
    }
    
    func categoryForSection(_ section: Int) -> DrinksCategory {
        return categoriesNew[section]
    }
    
    func getCategories() -> [DrinksCategory] {
        return categoriesNew
    }
    
    func drinkForIndexPath(indexPath: IndexPath) -> DrinksCodable {
        guard drinksNew.count > indexPath.section, drinksNew[indexPath.section].count > indexPath.row else { return DrinksCodable.init(strDrink: "", strDrinkThumb: "", idDrink: "")}
        return drinksNew[indexPath.section][indexPath.row]
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard drinksNew.count > section else { return 0 }
        
        return drinksNew[section].count
    }
    
    //MARK: - Data did load methods
    
    private func categoriesDidLoad(response: Categories) {
        categoriesNew.removeAll()
        guard let categoriesFromServes = response.drinks else { return }
        allCategories = categoriesFromServes
        categoriesNew = categoriesFromServes
        delegate.didLoadCategories()
    }
    
    
    private func drinksDidLoadForCategory(сategory: DrinksCategory, responce: DrinkList) {
        guard let section = categoriesNew.firstIndex(of: сategory),
            let drinksForSection = responce.drinks else { return }
        drinksNew.append(drinksForSection)
        delegate.didLoadDrinksForSection(section: section)
    }
    
    //    private func drinksDidLoadForCategory(сategory: Category, responce: Drinks) {
    //        guard let section = categories.firstIndex(of: сategory),
    //            let drinksForSection = responce.list else { return }
    //
    //        drinks.append(drinksForSection)
    //        delegate.didLoadDrinksForSection(section: section)
    //    }
}
