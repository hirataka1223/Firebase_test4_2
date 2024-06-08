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
        
        if let rootViewController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
            GIDSignIn.sharedInstance.signIn(with: config, presenting: rootViewController) { user, error in
                if let error = error {
                    print("GIDSignInError: \(error.localizedDescription)")
                    return
                }
                
                guard let authentication = user?.authentication,
                      let idToken = authentication.idToken, // ここでStringとして取得
                      let accessToken = authentication.accessToken else { // ここでStringとして取得
                    return
                }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
                self.login(credential: credential)
            }
        }
    }
    
    private func login(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("SignInError: \(error.localizedDescription)")
                return
            }
            
            if let user = authResult?.user {
                // 新規登録かログインかを判断
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
