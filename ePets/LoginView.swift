import SwiftUI
struct LoginView: View {
    @State var showingSignup = false // pour alterner entre sign i et sign up
    @State var showingFinishReg = false
    @Environment(\.presentationMode) var presentationMode
    
    @State var email = ""
    @State var password = ""
    @State var repeatPassword = ""
    
    var body: some View {
        VStack {
            Text("Sign In")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.bottom, .top], 10)
            VStack
            {
                Image("friends")
                    .resizable()
                    .frame(width: 350.0, height: 250.0)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .border(Color.orange, width: 3)
    
                Text("Your future friends are waiting for you!")
                    .foregroundColor(.orange)
                    .padding([.top], 20)
                    .padding([.bottom], 20)
            }
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    TextField("Enter your email", text: $email)
                    Divider()
                    Text("Password")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    
                    SecureField("Enter your password", text: $password)
                    Divider()
                    
                    if showingSignup {
                        Text("Verify Password")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(Color.init(.label))
                            .opacity(0.75)
                        
                        SecureField("Re-enter your password", text: $repeatPassword)
                        Divider()
                    }
                }
                .padding(.bottom, 15)
                .animation(.easeOut(duration: 0.1))
                //Fin du VStack
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        
                        self.resetPassword()
                    }, label: {
                        Text("Forgot Password?")
                            .foregroundColor(Color.gray.opacity(0.5))
                    })
                }//Fin du HStack
                
            } .padding(.horizontal, 6)
            //Fin du VStack
            Button(action: {

                self.showingSignup ? self.signUpUser() : self.loginUser()
            }, label: {
                Text(showingSignup ? "Sign Up" : "Sign In")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 120)
                    .padding()
            }) //Fin du  Button
                .background(Color.orange)
                .clipShape(Capsule())
                .padding(.top, 45)
            
            SignUpView(showingSignup: $showingSignup)
    
        }//Fin du VStack
        .sheet(isPresented: $showingFinishReg)
        {
            FinishRegistrationView()
        }
        
    }//Fin du body

    private func loginUser()
    {
        if email != "" && password != "" {
                    FUser.loginUserWith(email: email, password: password) { (error, isEmailVerified) in
                        
                        if error != nil {
                            
                            print("error loging in the user: ", error!.localizedDescription)
                            return
                        }
                       //permettre d'ouvrir la fenêtre pour finaliser l'enregistrement si ce n'est pas encore fait
                        if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding {
                            self.presentationMode.wrappedValue.dismiss() // fermer la fenêtre qui est en mode présentation
                        } else {
                            self.showingFinishReg.toggle()
                        }
                    }
                }
    }
    private func signUpUser()
    {
        if email != "" && password != "" && repeatPassword != "" {
            if password == repeatPassword {
                
                FUser.registerUserWith(email: email, password: password) { (error) in
                    
                    if error != nil {
                        print("Error registering user: ", error!.localizedDescription)
                        return
                    }
                    print("User has been created")
                    //retourner à l'application
                    //vérifier si onBoard a été fait
                }

            } else {
                print("passwords dont match")
            }
            
            
        } else {
            print("Email and password must be set")
        }
    }
    private func resetPassword()
    {
        if email != ""
        {
            FUser.resetPassword(email: email)
            {(error) in
                if error != nil
                {print("error sending reset password,",error!.localizedDescription)
                    return
                }
                print ("Please check your email")
            }
        }
        else
        {
            print("email is empty")
        }
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct SignUpView : View {
    @Binding var showingSignup: Bool
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 8) {
                Text("Don't have an Account?")
                    .foregroundColor(Color.gray.opacity(0.5))
                Button(action: {
                    self.showingSignup.toggle()
                }, label: {
                    Text("Sign Up")
                })
                    .foregroundColor(.orange)
            }//Fin de HStack
                .padding(.top, 25)
        } //Fin de VStack
    }
}
