//
//  MitotiMView.swift
//  Pod Alarm
//
//  Created by Simone Pistecchia on 31/12/20.
//

import SwiftUI



public struct MitotiMView: View {
    
    public init (boxColor: Color, iconColor: Color) {
        self.boxColor = boxColor
        self.iconColor = iconColor
    }
    
    
    public var boxColor: Color
    public var iconColor: Color
    @State private var isShowingMail = false
    
    public var body: some View {
                    
        VStack {
            HStack {
                Image(systemName: "star.fill")
                    .frame(width: 14, height: 14)
                    .modifier(fillButtonSquare(foregroundColor: iconColor, backgroundColor: boxColor, dimension: 8))
                Button(action: {AppleStore.openRateMe()}) {
                    HStack {
                        Text(AppStoreReview.titleRateUs)
                        Spacer()
                        Text(AppStoreReview.messageRateUs)
                            .foregroundColor(.gray)
                            .font(.caption)
                        Image(systemName: "chevron.right")
                    }
                    
                }
                .contentShape(Rectangle())                
            }
            .padding(.top, 6)
            HStack {
                Image(systemName: "envelope.fill")
                    .frame(width: 14, height: 14)
                    .modifier(fillButtonSquare(foregroundColor: iconColor, backgroundColor:boxColor, dimension: 8))
                Button(action: {
                        self.isShowingMail.toggle()
                    
                }) {
                    HStack {
                        Text(NSLocalizedString("Contact us", tableName: "MTMLocalizable", bundle: .module, comment: "settings - MitotiM: contattai"))
                        Spacer()
                        Text(NSLocalizedString("tips or issues", tableName: "MTMLocalizable", bundle: .module, comment: "settings - MitotiM: contattai"))
                            .foregroundColor(.gray)
                            .font(.caption)
                        Image(systemName: "chevron.right")
                    }
                }
                .contentShape(Rectangle())
                
            }
            .padding(.top, 6)
            HStack {
                Image(systemName: "apps.iphone")
                    .frame(width: 14, height: 14)
                    .modifier(fillButtonSquare(foregroundColor: iconColor, backgroundColor:boxColor, dimension: 8))
                Button(action: {
                    AppleStore.openiTunesLink()
                }) {
                    HStack {
                        Text("App in Apple Store")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
                .contentShape(Rectangle())
//                if #available(iOS 14.0, *) {
//                    Link("MitotiM app", destination: AppleStore.URLotherAppMitotiM!)
//                        .contentShape(Rectangle())
//                } else {
//                    // Fallback on earlier versions
//                }
               
            }           
            .padding(.top, 6)
        }
        .padding()
        .foregroundColor(boxColor)
        .sheet(isPresented: self.$isShowingMail, content: {
            MailViewRepresentable(setToRecipients: [MitotiMLibraryNew.mailTo], setSubject: MitotiMLibraryNew.appName, setMessageBody: MitotiMLibraryNew.messageBody, result: .constant(.none))
        })
//        .sheet(isPresented: self.$isShowingMail) {
//            MailViewRepresentable(setToRecipients: [AppConfiguration.mail.mailTo], setSubject: AppConfiguration.mail.subject, setMessageBody: AppConfiguration.mail.messageBody, result: .constant(.none))
//        }
    }
}

//struct MitotiMView_Previews: PreviewProvider {
//    static var previews: some View {
//        MitotiMView()
//    }
//}

public struct MitotiMViewBig: View {
    
    public init (textColor: Color) {
        self.textColor = textColor
    }
    
    
    public var textColor: Color = .black
    @State private var isShowingMail = false
    
    public var body: some View {
                    
        VStack {
            Text("MitotiM")
                .font(.largeTitle)
            HStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .modifier(fillButtonSquare(foregroundColor: .white, backgroundColor: textColor, dimension: 12))
                Button(action: {AppleStore.openRateMe()}) {
                    HStack {
                        Text(AppStoreReview.titleRateUs)
                        Spacer()
                        Text(AppStoreReview.messageRateUs)
                            .foregroundColor(.gray)
                            .font(.caption)
                        Image(systemName: "chevron.right")
                    }
                    
                }
                .contentShape(Rectangle())
            }
            .padding(.top, 6)
            Spacer()
                .frame(height: 20)
            HStack {
                Image(systemName: "envelope.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .modifier(fillButtonSquare(foregroundColor: .white, backgroundColor:textColor, dimension: 12))
                Button(action: {
                        self.isShowingMail.toggle()
                    
                }) {
                    HStack {
                        Text(NSLocalizedString("Contact us", tableName: "MTMLocalizable", bundle: .module, comment: "settings - MitotiM: contattai"))
                        Spacer()
                        Text(NSLocalizedString("tips or issues", tableName: "MTMLocalizable", bundle: .module, comment: "settings - MitotiM: contattai"))
                            .foregroundColor(.gray)
                            .font(.caption)
                        Image(systemName: "chevron.right")
                    }
                }
                .contentShape(Rectangle())
                
            }
            .padding(.top, 6)
            Spacer()
        }
        .padding()
        .foregroundColor(textColor)
        .popover(isPresented: self.$isShowingMail, content: {
            MailViewRepresentable(setToRecipients: [MitotiMLibraryNew.mailTo], setSubject: MitotiMLibraryNew.appName, setMessageBody: MitotiMLibraryNew.messageBody, result: .constant(.none))
        })
//        .sheet(isPresented: self.$isShowingMail) {
//            MailViewRepresentable(setToRecipients: [AppConfiguration.mail.mailTo], setSubject: AppConfiguration.mail.subject, setMessageBody: AppConfiguration.mail.messageBody, result: .constant(.none))
//        }
    }
}

struct MitotiMViewBig_Previews: PreviewProvider {
    static var previews: some View {
        MitotiMViewBig(textColor: .black)
    }
}
