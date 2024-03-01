//
//  FeedbackView.swift
//  MoviesDemo
//
//  Created by Marco Alonso Rodriguez on 31/01/24.
//

import SwiftUI
import MessageUI
import SafariServices

struct FeedbackView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    
     private let mailComposeDelegate = MailDelegate()
     private let messageComposeDelegate = MessageDelegate()
    
    @State var isShowingActivityView = false
    @State var urlToShow = ""
    @State var isShowingURL = false
    let phoneNumber = "4432282860"
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        // Llamada
                        Button {
                            if let phoneURL = URL(string: "tel://\(phoneNumber)") {
                                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                            }
                        } label: {
                            HStack {
                                Image(systemName: "phone")
                                Text("Call Me")
                            }
                        }
                        
                        //WhatsApp
                        Button {
                            openWhatsApp()
                        } label: {
                            HStack {
                                Image(systemName: "phone.bubble.left")
                                Text("Send WhatsApp")
                            }
                        }
                        
                        ///Send email
                        Button {
                            self.presentMailCompose()
                        } label: {
                            HStack {
                                Image(systemName: "mail")
                                Text("Send an email")
                            }
                        }
                        
                        ///Send message text
                        Button {
                            self.presentMessageCompose()
                        } label: {
                            HStack {
                                Image(systemName: "message")
                                Text("Send an message text")
                            }
                        }
                        
                        

                    } header: {
                        HStack {
                            Text("Contacto")
                        }
                    } // Section Contact
                    
                    Section(header: Text("Informacion")) {
                        ForEach(informationActions, id: \.id) { action in
                            Button {
                                urlToShow = action.url
                                isShowingURL = true
                            } label: {
                                HStack {
                                    Image(systemName: action.icon)
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                    
                                    Text(action.name)
                                        .font(.body)
                                }
                                
                            }
                        }
                        .listStyle(.inset)
                        .frame(height: 30)
                    }// Section Info
                    
                    // MARK:  Cines
                    Section(header: Text("Cines")) {
                        ForEach(cines) { cine in
                            Button {
                                urlToShow = cine.url
                                isShowingURL = true
                            } label: {
                                HStack {
                                    Image(systemName: cine.icon)
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                    
                                    Text(cine.name)
                                        .font(.body)
                                }
                            }
                        }
                    }
                    
                    // MARK:  Apariencia
                    Section(header: Text("Apariencia")) {
                        Toggle(isOn: $isDarkModeOn) {
                            HStack(spacing: 20.0) {
                                Image(systemName: "person.crop.circle.badge.moon.fill")
                                    .imageScale(.large)
                                Text("Dark mode")
                            }
                        }.padding(.horizontal, 20)
                            .foregroundColor(.accentColor)
                    }
                    
                }/// Form
            }
            .padding(10)
            .navigationBarItems(trailing: Button(action: {
                isShowingActivityView = true
            }, label: {
                Image(systemName: "square.and.arrow.up.fill")
            }))
            .navigationBarTitle("Configuración", displayMode: .large)
            .sheet(isPresented: $isShowingActivityView, content: {
                ActivityView(activityItems: ["https://apps.apple.com/es/app/capcut-editor-de-v%C3%ADdeo/id1500855883"])
            })
            .sheet(isPresented: $isShowingURL, content: {
                safari(urlString: $urlToShow)
            })
        }
    }
    
    func openWhatsApp() {
        let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=4432282860&text=Hola")!
        if UIApplication.shared.canOpenURL(whatsappURL) {
            UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
        }    }
}

#Preview {
    FeedbackView()
}

struct safari : UIViewControllerRepresentable {
    
    @Binding var urlString: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<safari>) -> SFSafariViewController {
        let controller = SFSafariViewController(url: URL(string: urlString)!)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<safari>) {
        
    }
}

// MARK:  Message Text
extension FeedbackView {
    private class MessageDelegate: NSObject, MFMessageComposeViewControllerDelegate {
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            // Customize here
            controller.dismiss(animated: true)
        }

    }
    
    private func presentMessageCompose() {
        guard MFMessageComposeViewController.canSendText() else {
            return
        }
        let vc = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController

        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = messageComposeDelegate
        composeVC.recipients = ["4432282860"]
        composeVC.body = "I would like to ..."
        vc?.present(composeVC, animated: true)
    }
}

extension FeedbackView {
    private class MailDelegate: NSObject, MFMailComposeViewControllerDelegate {

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            
            controller.dismiss(animated: true)
        }

    }

    private func presentMailCompose() {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        let vc = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController

        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = mailComposeDelegate
        composeVC.setToRecipients(["marcoalonsoiosdeveloper@gmail.com"])
        composeVC.setSubject("Quiero hacer una sugerencia")
        composeVC.setMessageBody("Me gustaría ...", isHTML: false)
        vc?.present(composeVC, animated: true)
    }
}
