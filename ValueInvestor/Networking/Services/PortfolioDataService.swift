//
//  PortfolioDataService.swift
//  ValueInvestor
//
//  Created by Amith Narayan on 16/08/2021.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container : NSPersistentContainer
    private let containerNamme : String = "PortfolioContainer"
    private let postfolioEntityName = "PortfolioEntity"
    
    @Published var portfolioEntitySaved : [PortfolioEntity] = []
    
    
    init() {
        container = NSPersistentContainer(name: containerNamme)
        container.loadPersistentStores { discription, error in
            if let error = error {
                print("=====> Error loading Core Data! \(error)")
            }
            self.getPortfolio()
        }
        
    }
    
    func updatePortfolio(stock:Result, amount: Double, buyingPrice : Double) {
        
        if let entity = portfolioEntitySaved.first(where: { savedEntity -> Bool in
            return savedEntity.stockSymbol == stock.symbol
        }) {
            if amount > 0 {
                update(entity: entity, amount: amount, buyingPrice: buyingPrice)
            } else {
                removePortfolio(entity: entity)
            }
        }
        else {
            add(result: stock, amount: amount, buyingPrice: buyingPrice)
        }
        
        
    }
    
    
    
    func getPortfolio() {
        
        let request = NSFetchRequest<PortfolioEntity>(entityName: postfolioEntityName)
        do {
            portfolioEntitySaved = try container.viewContext.fetch(request)
        } catch let error {
            print("=====> Error fetching portfolio entities. \(error)")
        }
        
        
        
    }
    
    
    private func add(result : Result, amount : Double, buyingPrice : Double) {
        
        let entity = PortfolioEntity(context: container.viewContext)
        entity.stockSymbol = result.symbol
        entity.currentHoldings = amount
        entity.buyingStockPrice = buyingPrice
        changesApply()
        
    }
    
    private func removePortfolio(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        changesApply()
    }
    
    func update(entity: PortfolioEntity, amount: Double, buyingPrice : Double) {
        entity.currentHoldings = amount
        entity.buyingStockPrice = buyingPrice
        changesApply()
    }
    
    private func save() {
        
        do {
            try container.viewContext.save()
        } catch let error {
            print("=====> Error saving to Core Data. \(error)")
        }
        
    }
    
    
    private func changesApply() {
        save()
        getPortfolio()
    }
    
    
}
