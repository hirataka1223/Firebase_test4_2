import SwiftUI

struct MyPageView: View {
    let email: String
    let selectedSNS: String
    let selectedGenre: String
    let accountName: String
    let fanCount: String
    let url: String
    
    var body: some View {
        VStack {
            Text("マイページ").font(.largeTitle).padding()
            
            UserInformationView(email: email, selectedSNS: selectedSNS, selectedGenre: selectedGenre, accountName: accountName, fanCount: fanCount, url: url)
            
            // ここにユーザーアイコンを表示するコンポーネントを追加します
            Spacer()
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
    
    // ファン数のタイトルを選択されたSNSツールに応じて変更するメソッド
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
        MyPageView(email: "example@example.com", selectedSNS: "Youtube", selectedGenre: "音楽", accountName: "サンプルアカウント", fanCount: "1000", url: "https://example.com")
    }
}
