//
//  IAPSwiftUI.swift
//  Pod Alarm
//
//  Created by Simone Pistecchia on 04/12/2020.
//

import Foundation

import StoreKit
import Combine
import SwiftUI
import SwiftKeychainWrapper


//public class MYSKPayment: SKPayment{
//    ///consumable = monete; nonConsumable=rimuovi pubblicità
//    enum ProductType {
//        case consumable, nonConsumable
//    }
//    var type:ProductType = .nonConsumable
//    convenience init (product:SKProduct, productType:ProductType) {
//        self.init(product:product)
//        self.type = productType
//    }
//}

public typealias ProductIdentifier = String

@available(iOS 14.0, *)
public class IAPSwiftUIModel: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {

    public static var sharedInstance = IAPSwiftUIModel()
    
    @Published public var allProducts = [SKProduct]()
    
    ///contiene stringhe di tutti i prodotti comprati es "it.mitotim.PodAlarm.RainNoise"
    @Published public var purchasedProducts = Set<ProductIdentifier>()
    
    @Published public var isLoading: Bool = false
    
    @Published public var isSwhowingMessage: Bool = false
    ///titolo dell'operazione in corso
    @Published public var title: String = ""
    ///messaggio dell'operazione in corso
    @Published public var message: String = ""
    
    private var productsIdentifiers: Set<String> = Set(IAPProducts.sharedInstance.productsIdentifiers)
    
    private var isPurchaseDisabled: Bool = false
    
    ///Serve per tracciare il prodotto che sto comprando
    private var productID = ""
    
    override public init() {
        super.init()
        fetchAvailableProducts()
        isPurchaseDisabled = canMakePurchases()
        setPurchasedProducts()
    }
    
    ///setto i prodotti già comprati
    private func setPurchasedProducts() {
        purchasedProducts = Set(productsIdentifiers.filter {
            (KeychainWrapper.standard.bool(forKey: $0) ?? false)
        })
    }
    
    public func getPriceProduct(productIdentifier: String) -> String {
        let prod = allProducts.filter{$0.productIdentifier==productIdentifier}
        if prod.count == 1 {
            let price = prod.first!.localizedPrice
            print("Function: \(#function), \(price)")
            return price
        }
        return ""
    }
    
    //18-10-2021
    public func getLocalPriceTitleDescription(productIdentifier: String) -> (price:String, title:String, desc:String) {
        let prod = allProducts.filter{$0.productIdentifier==productIdentifier}
        if prod.count == 1 {
            let title = prod.first!.localizedTitle
            let price = prod.first!.localizedPrice
            let desc = prod.first!.localizedDescription
            print("Function: \(#function): ", price, title, desc)
            return (price:price, title:title, desc:desc)
        }
        return (price:"???", title:"???", desc:"???")
    }
    
 
    
    ///USE THIS TO PURCHASE
    public func purchaseProduct(productIdentifier: String) {
        let prod = allProducts.filter{$0.productIdentifier==productIdentifier}
        if prod.count == 1 {
            print("Function: \(#function), \(prod.first!.localizedDescription)")
            purchaseProduct(product: prod.first!)
        }
        else {
            print("Function: \(#function), no product found")
            title = NSLocalizedString("Product error", tableName: "MTMLocalizable", bundle: .module, comment: "")
            message = NSLocalizedString("Try again later", tableName: "MTMLocalizable", bundle: .module, comment: "")
            isSwhowingMessage = true
        }
    }
    
    // MARK: - Make purchase of a product
    public func canMakePurchases() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    ///controlla i prodotti disponibili
    public func fetchAvailableProducts() {
        // Put here your IAP Products ID's
        let allProduct = productsIdentifiers
        let productIdentifiers = Set(allProduct)
        print(productIdentifiers)
       
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest.delegate = self
        productsRequest.start()
    }
    
    public func isProductPurchased(productIdentifier: String) -> Bool {
        return purchasedProducts.contains(productIdentifier)
    }
    
    public func purchaseProduct(product: SKProduct) {
        if self.canMakePurchases() {
            title = NSLocalizedString("loading", tableName: "MTMLocalizable", bundle: .module, comment: "")
            message = ""
            isSwhowingMessage = true
            isLoading = true
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
            print("Product to Purchase: \(product.productIdentifier)")
            productID = product.productIdentifier
        }
        // IAP Purchases disabled on the Device
        else {
            isPurchaseDisabled = true
            title = NSLocalizedString("Oops!", tableName: "MTMLocalizable", bundle: .module, comment: "")
            message = NSLocalizedString("Purchases are disabled in your device!", tableName: "MTMLocalizable", bundle: .module, comment: "")
        }
    }
    
    //MARK: SKProductsRequestDelegate
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count > 0 {
            DispatchQueue.main.async {
                self.allProducts = response.products
            }
            for purchasingProduct in response.products {
                // Get its price from iTunes Connect
                let numberFormatter = NumberFormatter()
                numberFormatter.formatterBehavior = .behavior10_4
                numberFormatter.numberStyle = .currency
                numberFormatter.locale = purchasingProduct.priceLocale
                if let price = numberFormatter.string(from: purchasingProduct.price) {
                    // Show "Go Pro for \(price) / year" in the Buy button
                    // and stop animating/loading the button
                   
                    //SE è GRATIS, LO METTO TRA I PURCHASED
                    
                    print(price)
                    if purchasingProduct.price == 0 {
                        let purchased = purchasingProduct.productIdentifier
                        registerProductPurchased(productIdentifier: purchased)
                    }
                    //METTI PULSANTI PER COMPRARE?
                    //purchaseProduct(product: iapProducts[0])
                    
                }
            }
        }
    }
    public func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
   
        // TODO: Product is restored and make sure the functionality/availability of purchased product
        //UserDefaults.standard.set(true, forKey: "isPurchased")
        
        title = NSLocalizedString("Restore Success", tableName: "MTMLocalizable", bundle: .module, comment: "")
        message = NSLocalizedString("You've successfully restored your purchase!", tableName: "MTMLocalizable", bundle: .module, comment: "")
        
        
        for trans in queue.transactions {
            let purchased = trans.payment.productIdentifier
            registerProductPurchased(productIdentifier: purchased)
        }
        
    }
    
    public func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        print("removed")
        title = NSLocalizedString("canceled", tableName: "MTMLocalizable", bundle: .module, comment: "")
        message = ""
        self.isLoading = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.isSwhowingMessage = false
        }
    }

    public func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("removed")
        title = NSLocalizedString("canceled", tableName: "MTMLocalizable", bundle: .module, comment: "")
        message = ""
        self.isLoading = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.isSwhowingMessage = false
        }
    }
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                case .purchased:
                    self.isLoading = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.isSwhowingMessage = false
                    }
                    
                    if let paymentTransaction = transaction as? SKPaymentTransaction {
                        SKPaymentQueue.default().finishTransaction(paymentTransaction)
                    }
                    let purchased = trans.payment.productIdentifier
                    registerProductPurchased(productIdentifier: purchased)
                    
                    title = NSLocalizedString("Purchase Success", tableName: "MTMLocalizable", bundle: .module, comment: "")
                    message = NSLocalizedString("You've successfully purchased", tableName: "MTMLocalizable", bundle: .module, comment: "")
                case .failed:
                    if trans.error != nil {
                        title = NSLocalizedString("Purchase failed!", tableName: "MTMLocalizable", bundle: .module, comment: "")
                        message = trans.error!.localizedDescription
                        print(trans.error!)
                    }
                    self.isLoading = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.isSwhowingMessage = false
                    }
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                case .restored:
                    print("restored")
                    title = NSLocalizedString("Restore Success", tableName: "MTMLocalizable", bundle: .module, comment: "")
                    message = NSLocalizedString("You've successfully restored your purchase!", tableName: "MTMLocalizable", bundle: .module, comment: "")
                    self.isLoading = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.isSwhowingMessage = false
                    }
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                default:
                    //isLoading = false
                    break
                }
            }
            print("Function: \(#function), \(title), \(message)")
        }
    }
    
    /// Storo il prodotto dentro keychainwrapper
    private func registerProductPurchased(productIdentifier: String) {
        KeychainWrapper.standard.set(true, forKey: productIdentifier)
        purchasedProducts.insert(productIdentifier)
    }
    
    // MARK: - Restore purchases
    public func restorePurchase() {
        isLoading = true
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
        
    }
    private var productsRequest = SKProductsRequest()
}

@available(iOS 11.2, *)
extension SKProductSubscriptionPeriod {

    public var periodString: String {
        let units  = self.numberOfUnits
        let period = self.unit
        
        let isUnitOne = units == 1 ? true:false
        
        switch period {
        case .day:
            return isUnitOne ? NSLocalizedString("day", tableName: "MTMLocalizable", bundle: .module, comment: ""):NSLocalizedString("days", tableName: "MTMLocalizable", bundle: .module, comment: "")
        case .week:
            return isUnitOne ? NSLocalizedString("week", tableName: "MTMLocalizable", bundle: .module, comment: ""):NSLocalizedString("weeks", tableName: "MTMLocalizable", bundle: .module, comment: "")
        case .month:
            return isUnitOne ? NSLocalizedString("month", tableName: "MTMLocalizable", bundle: .module, comment: ""):NSLocalizedString("months", tableName: "MTMLocalizable", bundle: .module, comment: "")
        case .year:
            return isUnitOne ? NSLocalizedString("year", tableName: "MTMLocalizable", bundle: .module, comment: ""):NSLocalizedString("years", tableName: "MTMLocalizable", bundle: .module, comment: "")
        @unknown default:
            return "periodString ERROR"
        }
    }
}

@available(iOS 14.0, *)
public extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)!
    }
}
