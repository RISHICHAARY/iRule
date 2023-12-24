import SwiftUI
import RealmSwift

struct viewController: View {
    
    @State var isLogged: Bool = UserDefaults.standard.bool(forKey: "LoginState")
    @State var loggedUserType: String = UserDefaults.standard.string(forKey: "LoggedUserType") ?? ""
    @State var loggedUserID: String = UserDefaults.standard.string(forKey: "LoggedUserID") ?? ""
    
    @State var loginState: String = ""
    @State var userID: String = ""
    
    var body: some View {
        if(loginState == "user"){
            mainPageCall(loginState: $loginState, userID: $userID)
        }
        else if(loginState == "admin"){
            adminViewController(loginState: $loginState, userID: $userID)
        }
        else{
            if(isLogged == true){
                if(loggedUserType == "user"){
                    mainPageCall(loginState: $loggedUserType, userID: $loggedUserID)
                }
                else if(loggedUserType == "admin"){
                    adminViewController(loginState: $loggedUserType, userID: $loggedUserID)
                }
                else{
                    loginPage(loginState: $loginState, userID: $userID)
                }
            }
            else{
                loginPage(loginState: $loginState, userID: $userID)
            }
        }
    }
}

struct loginPage: View {
    
    @ObservedResults(Users.self) var users: Results<Users>
    
    @Binding var loginState: String
    @Binding var userID: String
    
    @State var logingInvalid: Bool = false
    @State var userName: String = ""
    @State var passWord: String = ""
    
    let backgroundGradient = LinearGradient(gradient: Gradient(colors: [Color.gray, Color.teal, Color.cyan, Color.indigo, Color.blue]),startPoint: .topTrailing, endPoint: .bottom)
    
    func logIn(){
        for i in 0...users.count-1{
            if(userName == users[i].email && passWord == users[i].password){
                UserDefaults.standard.set(true,forKey: "LoginState")
                userID = users[i].email
                UserDefaults.standard.set(userID,forKey: "LoggedUserID")
                if(users[i].type == "user"){
                    UserDefaults.standard.set("user",forKey: "LoggedUserType")
                    loginState = "user"
                }
                else if(users[i].type == "admin"){
                    UserDefaults.standard.set("admin",forKey: "LoggedUserType")
                    loginState = "admin"
                }
                return
            }
            else if(i == users.count-1){
                UserDefaults.standard.set(false,forKey: "LoginState")
                UserDefaults.standard.set("",forKey: "LoggedUserID")
                UserDefaults.standard.set("",forKey: "LoggedUserType")
                logingInvalid = true
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            backgroundGradient.ignoresSafeArea(.all)
            VStack(spacing:60){
                VStack{
                    Text("Smart Poll")
                        .font(.system(size: 60,weight: .medium))
                    Text("Vote Your Wish")
                        .font(.system(size: 30))
                }
                .foregroundColor(.white)
                VStack(spacing:30){
                    VStack(alignment: .leading , spacing:10){
                        Text("Username")
                            .font(.system(size: 25))
                        TextField("\("WalterWhite@Gmail.com")",text: $userName)
                            .font(.system(size: 20))
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                        Divider()
                    }
                    VStack(alignment: .leading , spacing:10){
                        Text("Password")
                            .font(.system(size: 25))
                        SecureField("p@SsW0Rd",text: $passWord)
                            .font(.system(size: 20))
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                        Divider()
                    }
                    Button(action:{logIn()}){
                        Text("Log In")
                            .padding(5)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .font(.system(size: 25,weight: .bold))
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(25)
                .background(.white.opacity(0.8))
                .cornerRadius(10)
                .foregroundColor(.black)
            }
            .padding()
            .alert(isPresented: $logingInvalid){
                Alert(title: Text("Login Error"), message: Text("Invalid Credentials"))
            }
        }
    }
}

struct mainPageCall: View {
    
    @Binding var loginState:String
    @Binding var userID: String
    
    var body: some View {
        mainViewController(loginState: $loginState, userID: $userID)
    }
}
