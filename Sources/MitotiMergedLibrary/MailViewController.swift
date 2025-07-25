//
//  MailViewController.swift
//  Pippi
//
//  Created by Simone Pistecchia on 23/10/16.
//  Copyright © 2016 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit
import MessageUI


@MainActor
public class MailViewController : UIViewController, MFMailComposeViewControllerDelegate {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    public func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([MitotiMLibraryNew.mailTo])
            mail.setSubject(MitotiMLibraryNew.appName)
            mail.setMessageBody(MitotiMLibraryNew.messageBody, isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    public nonisolated func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        Task { @MainActor in
            controller.dismiss(animated: true)
            dismiss(animated: false, completion: nil)
        }
    }
    
    public func sendMailToShareAppStoreLink(additionalText: String? = nil) {
        var text = "\(NSLocalizedString("Download", tableName: "MTMLocalizable", bundle: .module, comment: "")) \(MitotiMLibraryNew.appName) \(NSLocalizedString("on the App Store", tableName: "MTMLocalizable", bundle: .module, comment: "")): \(AppleStore.appleStoreAppLink)"
        if let additionalText = additionalText {
            text = additionalText + "\n" + text
        }
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([])
            mail.setSubject("\(NSLocalizedString("Download", tableName: "MTMLocalizable", bundle: .module, comment: "get or download on applestore")) \(MitotiMLibraryNew.appName) \(NSLocalizedString("on the App Store", tableName: "MTMLocalizable", bundle: .module, comment: ""))")
            mail.setMessageBody(text, isHTML: true)
            
            present(mail, animated: true)
        }
    }
    
}


import SwiftUI
public struct MailViewRepresentable: UIViewControllerRepresentable {
    
    public init(setToRecipients: [String]? = nil, setSubject: String, setMessageBody: String, result: Binding<Result<MFMailComposeResult, Error>?>) {
        self.setToRecipients = setToRecipients
        self.setSubject = setSubject
        self.setMessageBody = setMessageBody
        _result = result
    }
    

    @Environment(\.presentationMode) public var presentation
    public var setToRecipients: [String]?
    public var setSubject: String
    public var setMessageBody: String
    @Binding public var result: Result<MFMailComposeResult, Error>?

    
    public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding public var presentation: PresentationMode
        @Binding public var result: Result<MFMailComposeResult, Error>?

        public init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }

        public func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation,
                           result: $result)
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<MailViewRepresentable>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setToRecipients(setToRecipients)
        vc.setSubject(setSubject)
        vc.setMessageBody(setMessageBody, isHTML: true)
        return vc
    }

    public func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailViewRepresentable>) {

    }
}


/* mo non mi serve
struct MailView: View {

   @State private var result: Result<MFMailComposeResult, Error>? = nil
   @State var isShowingMailView = false

    var body: some View {
        Button(action: {
            self.isShowingMailView.toggle()
        }) {
            Text("Tap Me")
        }
        .disabled(!MFMailComposeViewController.canSendMail())
        .sheet(isPresented: $isShowingMailView) {
            MailViewRepresentable(result: self.$result, setMessageBody: ,setSubject: ,setToRecipients: )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/

