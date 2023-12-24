import SwiftUI
import RealmSwift

struct mainViewController: View {
    
    @Binding var loginState: String
    @Binding var userID: String
    
    @State var mainPageState: String = "Home"
    @State var pollID: ObjectId = ObjectId()
    
    var body: some View {
        if(mainPageState == "Home"){
            homePageCall(mainPageState: $mainPageState, userID: $userID, pollID: $pollID)
        }
        else if(mainPageState == "Profile"){
            profilePageCall(mainPageState: $mainPageState,loginState: $loginState, userID: $userID)
        }
        else if(mainPageState == "Poll"){
            pollPageCall(mainPageState: $mainPageState, userID: $userID, pollID: $pollID)
        }
        else if(mainPageState == "Success"){
            successPageCall(mainPageState: $mainPageState )
        }
    }
}

struct homePageCall: View {
    
    @Binding var mainPageState:String
    @Binding var userID: String
    @Binding var pollID: ObjectId
    
    var body: some View {
        homePage(mainPageState: $mainPageState, userID: $userID, pollID: $pollID)
    }
}


struct profilePageCall: View {
    @Binding var mainPageState:String
    @Binding var loginState:String
    @Binding var userID: String
    var body: some View {
        profilePage(mainPageState: $mainPageState,loginState: $loginState, userID: $userID)
    }
}

struct pollPageCall: View {
    @Binding var mainPageState:String
    @Binding var userID: String
    @Binding var pollID: ObjectId
    var body: some View {
        pollPage(mainPageState: $mainPageState, userID: $userID, pollID: $pollID)
    }
}

struct successPageCall: View {
    @Binding var mainPageState:String
    var body: some View {
        successPage(mainPageState: $mainPageState)
    }
}
