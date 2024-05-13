
import SwiftUI
import FirebaseDatabase // FirebaseDatabaseのインポートを追加

struct AccountRegistrationView: View {
    @State private var selectedSNS = "ユーザーのSNSツール1"
    @State private var selectedGenre = "ツールのジャンル1"
    @State private var accountName = ""
    @State private var fanCount = ""
    @State private var url = ""
    @State private var showingConfirmation = false
    
    let snsOptions = ["ユーザーのSNSツール1", "Youtube", "Twitter", "Instagram", "Tiktok"]
    let genreOptions = ["ツールのジャンル1", "音楽", "ゲーム", "漫画/アニメ", "バラエティ/エンタメ", "Vlog", "教育", "商品紹介/レビュー", "日常生活", "旅行", "料理", "趣味/ライフスタイル", "メイク/ファッション", "家族/カップル", "ビジネススキル", "お金/投資", "語学", "大食い", "ギャンブル", "政治・ニュース"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                Picker(selection: $selectedSNS, label: Text("")) {
                    ForEach(snsOptions, id: \.self) { option in
                        Text(option)
                            .foregroundColor(option == "ユーザーのSNSツール1" ? .gray : .black)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
            .padding(.bottom, 10)
            
            VStack(alignment: .leading) {
                Picker(selection: $selectedGenre, label: Text("")) {
                    ForEach(genreOptions, id: \.self) { option in
                        Text(option)
                            .foregroundColor(option == "ツール1のジャンル" ? .gray : .black)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
            .padding(.bottom, 10)
            
            VStack(alignment: .leading, spacing: 20) {
                TextField("ツール1のアカウント名", text: $accountName)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                TextField(fanCountTitle(), text: $fanCount)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                TextField("ツール1のURL", text: $url)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            
            Button(action: {
                showingConfirmation = true
            }) {
                Text("確認する")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.vertical, 20)
            .sheet(isPresented: $showingConfirmation) {
                ConfirmationView(selectedSNS: selectedSNS, selectedGenre: selectedGenre, accountName: accountName, fanCount: fanCount, url: url)
            }
        }
        .padding()
    }
    
    private func fanCountTitle() -> String {
        if selectedSNS == "Youtube" {
            return "ツール1のチャンネル登録者数"
        } else {
            return "ツール1のフォロワー数"
        }
    }
}

struct AccountRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        AccountRegistrationView()
    }
}
