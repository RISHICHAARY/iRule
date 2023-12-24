import SwiftUI
import RealmSwift
import LocalAuthentication

struct pollPage: View {
    
    @Environment(\.realm) var realm
    
    @ObservedResults(Polls.self) var polls: Results<Polls>
    @ObservedResults(Users.self) var users: Results<Users>
    
    @State var optionPicked:String = "None"
    @State var pageErrorState: Bool = false
    @State var pageErrors: String = ""
    
    @Binding var mainPageState:String
    @Binding var userID: String
    @Binding var pollID: ObjectId
    
    let backgroundGradient = LinearGradient(gradient: Gradient(colors: [Color.gray, Color.teal, Color.cyan, Color.indigo, Color.blue]),startPoint: .topTrailing, endPoint: .bottom)
    
    var currentPoll: [Polls] {
        polls.filter{$0._id == pollID}
    }
    
    var currentUser: [Users] {
        users.filter{$0.email == userID && $0.type == "user"}
    }
    
    func homeSwitch(){
        mainPageState = "Home"
    }
    
    /*func authenticate(){
        let context = LAContext()
        var error: NSError?
        
        if optionPicked == "None"{
            pageErrors = "No option picked"
            pageErrorState = true
            return
        }

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "This is a security check reason.") { success, authenticationError in
                
                if success {
                    successSwitch()
                } else {
                    pageErrors = "Face Does not match"
                    pageErrorState = true
                    return
                }
            }
        } else {
            pageErrors = "No faceID found"
            pageErrorState = true
            return
        }
    }*/
    
    func successSwitch(){
        let pollToUpdate = realm.object(ofType: Polls.self, forPrimaryKey: pollID)
        try? realm.write{
            if(optionPicked == "Option1"){
                pollToUpdate?.options[0].option1Votes += 1
            }
            else if(optionPicked == "Option2"){
                pollToUpdate?.options[0].option2Votes += 1
            }
            else if(optionPicked == "Option3"){
                pollToUpdate?.options[0].option3Votes! += 1
            }
            else if(optionPicked == "Option4"){
                pollToUpdate?.options[0].option4Votes! += 1
            }
            for i in 0...(pollToUpdate?.participants.count)!-1{
                if(pollToUpdate?.participants[i].email == userID){
                    pollToUpdate?.participants[i].isvoted = true
                }
            }
        }
        
        let userToUpdate = realm.object(ofType: Users.self, forPrimaryKey: currentUser[0]._id)
        try? realm.write{
            userToUpdate?.participatedpolls.append(currentPoll[0]._id)
        }
        
        mainPageState = "Success"
    }
    
    var body: some View {
        ZStack(alignment:.top){
            backgroundGradient.ignoresSafeArea(.all)
            VStack{
                HStack{
                    Button(action:{homeSwitch()}){
                        Image(systemName: "chevron.backward")
                            .font(.custom("montserrat", size: 25))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                VStack{
                    VStack{
                        Text(currentPoll[0].name)
                            .font(.system(size: 30))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .foregroundColor(.white)
                    .padding(.vertical,20)
                    
                    ScrollView{
                        VStack(alignment:.leading,spacing: 20){
                            
                            if(optionPicked == "Option1"){
                                Button(action:{
                                    optionPicked = "None"
                                }){
                                    Text(currentPoll[0].options[0].option1)
                                        .font(.system(size: 25))
                                        .foregroundColor(.pink)
                                }
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .padding()
                                .background(.white.opacity(0.8))
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.pink, lineWidth: 5)
                                )
                                .padding(2)
                            }
                            else{
                                Button(action:{
                                    optionPicked = "Option1"
                                }){
                                    Text(currentPoll[0].options[0].option1)
                                        .font(.system(size: 25))
                                        .foregroundColor(.black)
                                }
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .padding()
                                .background(.white.opacity(0.8))
                                .cornerRadius(20)
                                .padding(2)
                            }
                            
                            if(optionPicked == "Option2"){
                                Button(action:{
                                    optionPicked = "None"
                                }){
                                    Text(currentPoll[0].options[0].option2)
                                        .font(.system(size: 25))
                                        .foregroundColor(.pink)
                                }
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .padding()
                                .background(.white.opacity(0.8))
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.pink, lineWidth: 5)
                                )
                                .padding(2)
                            }
                            else{
                                Button(action:{
                                    optionPicked = "Option2"
                                }){
                                    Text(currentPoll[0].options[0].option2)
                                        .font(.system(size: 25))
                                        .foregroundColor(.black)
                                }
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .padding()
                                .background(.white.opacity(0.8))
                                .cornerRadius(20)
                                .padding(2)
                            }
                            
                            if(currentPoll[0].noOptions == "4"){
                                
                                if(optionPicked == "Option3"){
                                    Button(action:{
                                        optionPicked = "None"
                                    }){
                                        Text(currentPoll[0].options[0].option3!)
                                            .font(.system(size: 25))
                                            .foregroundColor(.pink)
                                    }
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                    .padding()
                                    .background(.white.opacity(0.8))
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(.pink, lineWidth: 5)
                                    )
                                    .padding(2)
                                }
                                else{
                                    Button(action:{
                                        optionPicked = "Option3"
                                    }){
                                        Text(currentPoll[0].options[0].option3!)
                                            .font(.system(size: 25))
                                            .foregroundColor(.black)
                                    }
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                    .padding()
                                    .background(.white.opacity(0.8))
                                    .cornerRadius(20)
                                    .padding(2)
                                }
                                
                                if(optionPicked == "Option4"){
                                    Button(action:{
                                        optionPicked = "None"
                                    }){
                                        Text(currentPoll[0].options[0].option4!)
                                            .font(.system(size: 25))
                                            .foregroundColor(.pink)
                                    }
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                    .padding()
                                    .background(.white.opacity(0.8))
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(.pink, lineWidth: 5)
                                    )
                                    .padding(2)
                                }
                                else{
                                    Button(action:{
                                        optionPicked = "Option4"
                                    }){
                                        Text(currentPoll[0].options[0].option4!)
                                            .font(.system(size: 25))
                                            .foregroundColor(.black)
                                    }
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                    .padding()
                                    .background(.white.opacity(0.8))
                                    .cornerRadius(20)
                                    .padding(2)
                                }
                                
                            }
                        }
                    }
                }
                
                Spacer()
                
                VStack{
                    Button(action:{successSwitch()}){
                        Text("Poll")
                            .font(.custom("montserrat", size: 30))
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding()
                    .foregroundColor(.white)
                    .background(.red.opacity(0.9))
                    .cornerRadius(20)
                }
            }
            .padding(10)
            .alert(isPresented: $pageErrorState){
                Alert(title: Text("Polling Error"), message: Text(pageErrors))
            }
        }
    }
}
