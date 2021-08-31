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
    private let portfolioEntityName = "PortfolioEntity"
    private let optionsEntityName = "OptionsEntity"
    
    @Published var portfolioEntitySaved : [PortfolioEntity] = []
    @Published var optionsEntitySaved : [OptionsEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerNamme)
        container.loadPersistentStores { discription, error in
            if let error = error {
                print("=====> Error loading Core Data! \(error)")
            }
            self.getPortfolio()
            self.getPortfolioOptions()
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
        
        let request = NSFetchRequest<PortfolioEntity>(entityName: portfolioEntityName)
        do {
            portfolioEntitySaved = try container.viewContext.fetch(request)
        } catch let error {
            print("=====> Error fetching portfolio entities. \(error)")
        }
    }
    
    
    func updateOptions(askPrice : Double, strickPrice : Double, stockSymbol : String, optionType : String, expirationDate : String, contractSize : Double) {
        
        if let entity = optionsEntitySaved.first(where: { savedEntity -> Bool in
            return savedEntity.stockSymbol == stockSymbol
        }) {
            if askPrice > 0 {
//                update(entity: entity, amount: amount, buyingPrice: buyingPrice)
                updateOptions(entity: entity, askPrice: askPrice, strickPrice: strickPrice, stockSymbol: stockSymbol, optionType: optionType, expirationDate: expirationDate, contractSize: contractSize)
            } else {
                removeOptions(entity: entity)
            }
        }
        else {
//            add(result: stock, amount: amount, buyingPrice: buyingPrice)
            addOptions(askPrice: askPrice, strickPrice: strickPrice, stockSymbol: stockSymbol, optionType: optionType, expirationDate: expirationDate, contractSize: contractSize)
        }
        
        
    }
    
    func getPortfolioOptions() {
        
        let request = NSFetchRequest<OptionsEntity>(entityName: optionsEntityName)
        do {
            optionsEntitySaved = try container.viewContext.fetch(request)
        } catch let error {
            print("=====> Error fetching portfolio entities. \(error)")
        }
        
        
    }
    
    func addOptions(askPrice : Double, strickPrice : Double, stockSymbol : String, optionType : String, expirationDate : String, contractSize : Double) {
        
        let entity = OptionsEntity(context: container.viewContext)
        entity.askPrice = askPrice
        entity.strickPrice = strickPrice
        entity.stockSymbol = stockSymbol
        entity.optionType = optionType
        entity.expirationDate = expirationDate
        entity.contractSize = contractSize
        changesApplyOptions()
        
    }
    
    func updateOptions(entity: OptionsEntity, askPrice : Double, strickPrice : Double, stockSymbol : String, optionType : String, expirationDate : String, contractSize : Double) {
        entity.askPrice = askPrice
        entity.strickPrice = strickPrice
        entity.stockSymbol = stockSymbol
        entity.optionType = optionType
        entity.expirationDate = expirationDate
        entity.contractSize = contractSize
        changesApplyOptions()
    }
    
    private func removeOptions(entity: OptionsEntity) {
        container.viewContext.delete(entity)
        changesApply()
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
    
    private func changesApplyOptions() {
        save()
        getPortfolioOptions()
    }
    
}
