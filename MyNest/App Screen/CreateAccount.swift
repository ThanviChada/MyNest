import SwiftUI

struct CreateAccount: View {
    
    @State private var fullName = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        VStack(spacing: 20) {
            // Logo
            Image("myNest_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 340)
                .offset(x:-10,y: -230)
            
            // Title
            Text("Create Account")
                .font(.custom("Instrument Sans", size: 25).weight(.bold))
                .foregroundColor(Color(red: 0.49, green: 0.22, blue: 0.13))
            
            // Form Fields
            VStack(alignment: .leading, spacing: 15) {
                
                Text("Name*")
                    .font(.custom("Instrument Sans", size: 18).weight(.bold))
                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                
                TextField("Full Name", text: $fullName)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                
                
                Text("Username*")
                    .font(.custom("Instrument Sans", size: 18).weight(.bold))
                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                
                
                Text("Password*")
                    .font(.custom("Instrument Sans", size: 18).weight(.bold))
                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                
                
                Text("Re-enter Password*")
                    .font(.custom("Instrument Sans", size: 18).weight(.bold))
                    .foregroundColor(Color(red: 0.13, green: 0.49, blue: 0.69))
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            // Create Button
            Button(action: {
                print("Create account tapped")
            }) {
                Text("Create")
                    .font(.custom("Instrument Sans", size: 20).weight(.bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0.13, green: 0.49, blue: 0.69))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 30)
            
            // Back Button
            Button(action: {
                print("Back tapped")
            }) {
                Text("Back")
                    .font(.custom("Instrument Sans", size: 18).weight(.bold))
                    .foregroundColor(Color.gray)
            }
            .padding(.bottom, 20)
        }
        .background(Color(red: 0.92, green: 0.94, blue: 0.89))
        .ignoresSafeArea()
    }
}

struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccount()
    }
}
