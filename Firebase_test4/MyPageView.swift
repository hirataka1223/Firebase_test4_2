import SwiftUI
import Firebase

struct MyPageView: View {
    let email: String
    
    @State private var userAccountDetails: UserAccountDetails? = nil
    
    var body: some View {
        VStack {
            if let userDetails = userAccountDetails {
                Text("マイページ").font(.largeTitle).padding()
                
                UserInformationView(
                    email: email,
                    selectedSNS: userDetails.selectedSNS,
                    selectedGenre: userDetails.selectedGenre,
                    accountName: userDetails.accountName,
                    fanCount: userDetails.fanCount,
                    url: userDetails.url
                )
                
                Spacer()
            } else {
                Text("Loading...").font(.largeTitle).padding()
                Spacer()
            }
        }
        .onAppear {
            loadUserDetails()
        }
    }
    
    private func loadUserDetails() {
        let db = Firestore.firestore()
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error getting documents: \(error)")
                } else if let document = querySnapshot?.documents.first {
                    let data = document.data()
                    self.userAccountDetails = UserAccountDetails(
                        email: data["email"] as? String ?? "",
                        selectedSNS: data["selectedSNS"] as? String ?? "",
                        selectedGenre: data["selectedGenre"] as? String ?? "",
                        accountName: data["accountName"] as? String ?? "",
                        fanCount: data["fanCount"] as? String ?? "",
                        url: data["url"] as? String ?? ""
                    )
                }
            }
        }
    }
}

struct UserInformationView: View {
    let email: String
    let selectedSNS: String
    let selectedGenre: String
    let accountName: String
    let fanCount: String
    let url: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("メールアドレス:")
                Spacer()
                Text(email)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("ツール1")
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Text("　SNSツール:")
                    Spacer()
                    Text(selectedSNS)
                }
                HStack {
                    Text("　ジャンル:")
                    Spacer()
                    Text(selectedGenre)
                }
                HStack {
                    Text("　アカウント名:")
                    Spacer()
                    Text(accountName)
                }
                HStack {
                    Text("　\(fanCountTitle()):")
                    Spacer()
                    Text(fanCount)
                }
                HStack {
                    Text("　URL:")
                    Spacer()
                    Text(url)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding()
    }
    
    private func fanCountTitle() -> String {
        if selectedSNS == "Youtube" {
            return "チャンネル登録者数"
        } else {
            return "フォロワー数"
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView(email: "example@example.com")
    }
}
