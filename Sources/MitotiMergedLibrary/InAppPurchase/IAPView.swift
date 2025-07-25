//
//  SwiftUIView.swift
//  
//
//  Created by Simone Pistecchia on 22/01/21.
//

import SwiftUI
//import MitotiMLibrary

//@available(iOS 14.0, *)

/**
extension IAPProducts {
    static let monster = IAPProducts.sharedInstance.productsIdentifiers[0]
    static let normal = IAPProducts.sharedInstance.productsIdentifiers[1]
}
 ESEMPIO VIEW DA USARE
 e usare per alert:
 .alertLoaderView(isShowing: $inAppModel.isSwhowingMessage, isLoading: $inAppModel.isLoading, title: inAppModel.title, message: inAppModel.message)
*/
//public struct IAPView: View {
//    @State var inAppModel = IAPSwiftUIModel() //Oppure enviroment object 
//    public init() {}
//    public var body: some View {
//        VStack {
//            ///Prodotti presi da server Apple
//            Text("Prodotti presi da server Apple")
//            List(inAppModel.allProducts, id:\.self) { product in
//                Text(product.localizedTitle)
//            }
//            /// lista nomi da plist
//            Text("lista nomi da plist")
//            List(Array(IAPProducts.sharedInstance.productsIdentifiers), id:\.self) { product in
//                Text(product)
//            }
//            Text(inAppModel.isProductPurchased(productIdentifier: IAPProducts.normal) ? "normal purchased" : "normal blocked")
//                
//        }
//        .alertLoaderView(isShowing: $inAppModel.isSwhowingMessage, isLoading: $inAppModel.isLoading, title: inAppModel.title, message: inAppModel.message)
//    }
//}
//
//@available(iOS 14.0, *)
//public struct SwiftUIView_Previews: PreviewProvider {
//    public static var previews: some View {
//        IAPView()
//    }
//}
