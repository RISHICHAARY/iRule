import SwiftUI
import RealmSwift

struct adminViewController: View {
    
    @Binding var loginState:String
    @Binding var userID: String
    
    @State var adminPageState:String = "Home"
    @State var pollID: ObjectId = ObjectId()
    
    var body: some View {
        if(adminPageState == "Home"){
            adminHomePage(adminPageState: $adminPageState, userID: $userID, pollID: $pollID)
        }
        else if(adminPageState == "Profile"){
            adminProfilePage(adminPageState: $adminPageState, loginState: $loginState, userID: $userID)
        }
        else if(adminPageState == "View"){
            adminViewPage(adminPageState: $adminPageState, userID: $userID, pollID: $pollID)
        }
        else if(adminPageState == "Add"){
            newPollPage(adminPageState: $adminPageState, userID: $userID)
        }
        else if(adminPageState == "Success"){
            adminSuccessPage(adminPageState: $adminPageState)
        }
    }
}
