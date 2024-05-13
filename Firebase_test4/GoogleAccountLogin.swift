//
//  GoogleAccountLogin.swift
//  Firebase_test4
//
//  Created by Taka on 2024/04/03.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct GoogleAccountLogin: View {
    private func googleAuth() {
        
        guard let clientID:String = FirebaseApp.app()?.options.clientID else { return }
        let config:GIDConfiguration = GIDConfiguration(clientID: clientID)
        
        let windowScene:UIWindowScene? = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let rootViewController:UIViewController? = windowScene?.windows.first!.rootViewController!
        
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController!) { result, error in
            guard error == nil else {
                print("GIDSignInError: \(error!.localizedDescription)")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,accessToken: user.accessToken.tokenString)
            self.login(credential: credential)
        }
    }
    
    private func login(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("SignInError: \(error.localizedDescription)")
                return
            }
        }
    }
    var body: some View {
        Button(action: {
            googleAuth()
        }, label: {
            Text("GoogleアカウントでLogin")
        })
    }
}

struct GoogleAccountLogin_Previews: PreviewProvider {
    static var previews: some View {
        GoogleAccountLogin()
    }
}
