//
//  MitotiMView.swift
//  Pod Alarm
//
//  Created by Simone Pistecchia on 31/12/20.
//

import SwiftUI



public struct MitotiMView: View {
    
    public init () {}
    
    @State private var isShowingMail = false
    
    public var body: some View {
                    
        Group {
            Button {
                Task {
                    _ = await AppleStore.openRateMe()
                }
            } label: {
                Label {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(AppStoreReview.titleRateUs)
                            Text(AppStoreReview.messageRateUs)
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 6)
                } icon: {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .frame(width: 14, height: 14)
                }
            }
            .buttonStyle(.plain)
            .contentShape(Rectangle())
            Button {
                self.isShowingMail.toggle()
            } label: {
                Label {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(NSLocalizedString("Contact us", tableName: "MTMLocalizable", bundle: .module, comment: "settings - MitotiM: contattai"))
                            Text(NSLocalizedString("tips or issues", tableName: "MTMLocalizable", bundle: .module, comment: "settings - MitotiM: contattai"))
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 6)
                } icon: {
                    Image(systemName: "envelope.fill")
                        .foregroundStyle(.blue)
                        .frame(width: 14, height: 14)
                }
            }
            .buttonStyle(.plain)
            .contentShape(Rectangle())
            Button {
                Task {
                    _ = await AppleStore.openiTunesLink()
                }
            } label: {
                Label {
                    HStack {
                        Text("App in Apple Store")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 6)
                } icon: {
                    Image(systemName: "apps.iphone")
                        .foregroundStyle(.green)
                        .frame(width: 14, height: 14)
                }
            }
            .buttonStyle(.plain)
            .contentShape(Rectangle())
        }
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
                    
        Group {
            Button {
                Task {
                    _ = await AppleStore.openRateMe()
                }
            } label: {
                Label {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(AppStoreReview.titleRateUs)
                            Text(AppStoreReview.messageRateUs)
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 6)
                } icon: {
                    Image(systemName: "star.fill")
                        .padding(.horizontal)
                        .font(.system(size: 30))
                        .foregroundStyle(.yellow)
                }
            }
            .buttonStyle(.plain)
            .contentShape(Rectangle())
            .padding(.top, 6)
            Button {
                self.isShowingMail.toggle()
            } label: {
                Label {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(NSLocalizedString("Contact us", tableName: "MTMLocalizable", bundle: .module, comment: "settings - MitotiM: contattai"))
                            Text(NSLocalizedString("tips or issues", tableName: "MTMLocalizable", bundle: .module, comment: "settings - MitotiM: contattai"))
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 6)
                } icon: {
                    Image(systemName: "envelope.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(.blue)
                }
            }
            .buttonStyle(.plain)
            .contentShape(Rectangle())
            .padding(.top, 6)
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
        List {
            MitotiMViewBig(textColor: .black)
        }
    }
}

struct MitotiMView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            MitotiMView()
        }
    }
}

