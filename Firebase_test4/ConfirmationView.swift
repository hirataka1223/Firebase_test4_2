import SwiftUI
import Firebase

struct ConfirmationView: View {
    @State private var isRegistrationComplete: Bool = false
    let email: String
    let selectedSNS: String
    let selectedGenre: String
    let accountName: String
    let fanCount: String
    let url: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("確認ページ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("ツール1")
                        .font(.headline)
                    HStack {
                        Text("　SNSツール:")
                        Spacer()
                        Text(selectedSNS)
                            .font(.headline)
                    }
                    
                    HStack {
                        Text("　ジャンル:")
                        Spacer()
                        Text(selectedGenre)
                            .font(.headline)
                    }
                    
                    HStack {
                        Text("　アカウント名:")
                        Spacer()
                        Text(accountName)
                            .font(.headline)
                    }
                    
                    HStack {
                        Text("　\(fanCountTitle()):")
                        Spacer()
                        Text(fanCount)
                            .font(.headline)
                    }
                    
                    HStack {
                        Text("　URL:")
                        Spacer()
                        Text(url)
                            .font(.headline)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                
                Spacer()
                
                HStack(spacing: 20) {
                    Button(action: {
                        saveToFirestore()
                        self.isRegistrationComplete = true
                    }) {
                        Text("登録する")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("修正する")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .navigationBarTitle("", displayMode: .inline)
            .background(
                NavigationLink(
                    destination: MyPageView(email: email),
                    isActive: $isRegistrationComplete
                ) {
                    EmptyView()
                }
                    .hidden()
            )
        }
    }
    
    private func saveToFirestore() {
        let db = Firestore.firestore()
        let data: [String: Any] = [
            "email": email,
            "selectedSNS": selectedSNS,
            "selectedGenre": selectedGenre,
            "accountName": accountName,
            "fanCount": fanCount,
            "url": url
        ]
        db.collection("users").addDocument(data: data) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully")
            }
        }
    }
    
    private func fanCountTitle() -> String {
        if selectedSNS == "Youtube" {
            return "チャンネル登録者数"
        } else {
            return "フォロワー数"
        }
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(
            email: "example@example.com",
            selectedSNS: "Youtube",
            selectedGenre: "音楽",
            accountName: "サンプルアカウント",
            fanCount: "1000",
            url: "https://example.com"
        )
    }
}
