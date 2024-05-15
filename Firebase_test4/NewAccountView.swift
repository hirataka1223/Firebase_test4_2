import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

struct NewAccountView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignInSuccess: Bool = false
    @State private var isSignUpSuccess: Bool = false
    @State private var userAccountDetails: UserAccountDetails? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Sign In") {
                    signIn()
                }
                .padding()
                
                Button("Register") {
                    registerAccount()
                }
                .padding()
                
                GoogleAccountLogin()
                    .padding()
                
                Button("Account delete") {
                    accountDelete()
                }
                .padding()
            }
            .navigationBarTitle("Sign Up", displayMode: .inline)
            .background(
                Group {
                    NavigationLink(
                        destination: MyPageView(email: email),
                        isActive: $isSignInSuccess
                    ) { EmptyView() }
                    NavigationLink(
                        destination: AccountRegistrationView(email: email),
                        isActive: $isSignUpSuccess
                    ) { EmptyView() }
                }
                    .hidden()
            )
        }
    }
    
    private func signIn() {
        print("Sign In")
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let user = authResult?.user {
                print("Sign in successful")
                self.isSignInSuccess = true
            } else if let error = error {
                print("Sign in failed: \(error.localizedDescription)")
                handleError(error)
            }
        }
    }
    
    private func registerAccount() {
        print("Register")
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let user = authResult?.user {
                print("Sign up successful")
                self.isSignUpSuccess = true
            } else if let error = error {
                print("Sign up failed: \(error.localizedDescription)")
                handleError(error)
            }
        }
    }
    
    private func accountDelete() {
        print("Account delete")
        if let user = Auth.auth().currentUser {
            user.delete { error in
                if let error = error {
                    print("Failed to delete account: \(error.localizedDescription)")
                } else {
                    print("Account deleted")
                }
            }
        }
    }
    
    private func handleError(_ error: Error) {
        if let err = error as NSError? {
            // AuthErrorCodeの初期化方法を修正
            let errorCode = AuthErrorCode(rawValue: err.code)
            
            switch errorCode {
            case .invalidEmail:
                print("Invalid email")
            case .weakPassword:
                print("Weak password")
            case .wrongPassword:
                print("Wrong password")
            case .userNotFound:
                print("User not found")
            case .networkError:
                print("Network error")
            default:
                // err.localizedDescriptionを使用して、詳細なエラーメッセージを提供
                print("Unhandled error: \(err.localizedDescription)")
            }
        } else {
            print("Unknown error: \(error.localizedDescription)")
        }
    }
}



struct NewAccountView_Previews: PreviewProvider {
    static var previews: some View {
        NewAccountView()
    }
}
