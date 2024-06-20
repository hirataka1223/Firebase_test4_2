import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct GoogleAccountLogin: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navigationManager: NavigationManager
    
    private func googleAuth() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        // 現行の SwiftUI ビューをプレゼンティングビューコントローラとして使用
        if let rootViewController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
            GIDSignIn.sharedInstance.signIn(with: config, presenting: rootViewController) { [unowned self] user, error in
                // エラーハンドリング
                guard error == nil else {
                    print("GIDSignInError: \(error!.localizedDescription)")
                    return
                }
                
                // 認証データの取得
                guard let authentication = user?.authentication,
                      let idToken = authentication.idToken,
                      let accessToken = authentication.accessToken else {
                    return
                }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
                self.login(credential: credential)
            }
        }
    }
    
    private func login(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { [unowned self] authResult, error in
            if let error = error {
                print("SignInError: \(error.localizedDescription)")
                return
            }
            
            if let user = authResult?.user {
                self.navigationManager.isSignUpComplete = user.metadata.creationDate == user.metadata.lastSignInDate
                self.navigationManager.isSignInComplete = !self.navigationManager.isSignUpComplete
            }
        }
    }
    
    var body: some View {
        Button("GoogleアカウントでLogin", action: googleAuth)
    }
}

class NavigationManager: ObservableObject {
    @Published var isSignUpComplete = false
    @Published var isSignInComplete = false
}

struct GoogleAccountLogin_Previews: PreviewProvider {
    static var previews: some View {
        GoogleAccountLogin().environmentObject(NavigationManager())
    }
}
