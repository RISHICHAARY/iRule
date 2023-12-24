import Foundation

class LoginData: ObservableObject{
    
    @Published var isLogged: Bool {
        didSet{
            UserDefaults.standard.set(isLogged, forKey: "LoginState")
        }
    }
    
    @Published var loggedUserID: String {
        didSet{
            UserDefaults.standard.set(loggedUserID, forKey: "LoggedUserID")
        }
    }
    
    @Published var loggedUserType: String {
        didSet{
            UserDefaults.standard.set(loggedUserType, forKey: "LoggedUserType")
        }
    }
    
    init(){
        self.isLogged = false
        self.loggedUserID = ""
        self.loggedUserType = ""
    }
    
}
