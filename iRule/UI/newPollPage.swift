//
//  newPollPage.swift
//  iRule
//
//  Created by user1 on 07/12/23.
//

import SwiftUI
import RealmSwift

struct newPollPage: View {
    
    @Environment(\.realm) var realm
    
    @ObservedResults(Users.self) var users: Results<Users>
    @ObservedResults(Polls.self) var polls: Results<Polls>
    @ObservedResults(Companies.self) var companies: Results<Companies>
    
    var currentUser: [Users] {
        users.filter{$0.email == userID && $0.type == "admin"}
    }
    
    var currentCompany: [Companies]{
        companies.filter{$0.name == currentUser[0].company}
    }
    
    @Binding var adminPageState:String
    @Binding var userID: String
    
    @State var formInvalidity: Bool = false
    @State var formStatus: String = "Ok"
    @State var pollName:String = ""
    @State var noOptions:String = "2"
    
    @State var option1:String = ""
    @State var option2:String = ""
    @State var option3:String = ""
    @State var option4:String = ""
    
    @State var pollDate = Date()
    @State var post: String = "All"
    @State var others: String = "All"
    
    func savePoll(){
        
        if(pollName == ""){
            
            formStatus = "Form Incomplete"
            formInvalidity = true
            return
            
        }
        
        if(noOptions == "2" && (option1 == "" || option2 == "")){
            
            formStatus = "Form Incomplete"
            formInvalidity = true
            return
            
        }
        
        if(noOptions == "4" && (option1 == "" || option2 == "" || option3 == "" || option4 == "")){
            
            formStatus = "Form Incomplete"
            formInvalidity = true
            return
            
        }
        
        let newUser = Users()
        let newPoll = Polls()
        let pollOptions = Options()
        let pollParticipants = Participants()
        
        var currentParticipants: [Users]{
            users.filter{$0.company == currentUser[0].company && $0.type == "user"}
        }
        var filteredParticipants = currentParticipants
        
        if(post != "All" && others != "All"){
            
            var currentParticipants: [Users]{
                users.filter{$0.company == currentUser[0].company && $0.post == post && $0.others.contains(others) && $0.type == "user"}
            }
            filteredParticipants = currentParticipants
            
        }
        
        else if(post != "All" && others == "All"){
            
            var currentParticipants: [Users]{
                users.filter{$0.company == currentUser[0].company && $0.post == post && $0.type == "user"}
            }
            filteredParticipants = currentParticipants
            
        }
        
        else if(post == "All" && others != "All"){
            
            var currentParticipants: [Users]{
                users.filter{$0.company == currentUser[0].company && $0.others.contains(others) && $0.type == "user"}
            }
            filteredParticipants = currentParticipants
            
        }
        
        pollOptions.option1 = option1
        pollOptions.option1Votes = 0
        pollOptions.option2 = option2
        pollOptions.option2Votes = 0
        pollOptions.option3 = option3
        pollOptions.option3Votes = 0
        pollOptions.option4 = option4
        pollOptions.option4Votes = 0
        
        newPoll.name = pollName
        newPoll.date = pollDate
        newPoll.noOptions = noOptions
        newPoll.options.append(pollOptions)
        newPoll.company = currentUser[0].company
        newPoll.post = post
        newPoll.others = others
        newPoll.status = "inActive"
        
        newUser.assignedpolls = currentUser[0].assignedpolls+1
        
        if(filteredParticipants.count != 0){
            
            for i in 0...filteredParticipants.count-1{
                
                pollParticipants.email = filteredParticipants[i].email
                pollParticipants.isvoted = false
                newPoll.participants.append(pollParticipants)
                
                let userToUpdate = realm.object(ofType: Users.self, forPrimaryKey: filteredParticipants[i]._id)
                try? realm.write{
                    userToUpdate?.assignedpolls = filteredParticipants[i].assignedpolls+1
                }
            }
            
        }
        else{
            
            formStatus = "No Participants Found"
            formInvalidity = true
            return
            
        }
        
        $polls.append(newPoll)
        successSwitch()
        
    }
    
    func homeSwitch(){
        adminPageState = "Home"
    }
    
    func successSwitch(){
        adminPageState = "Success"
    }
    
    let backgroundGradient = LinearGradient(gradient: Gradient(colors: [Color.gray, Color.teal, Color.cyan, Color.indigo, Color.blue]),startPoint: .topTrailing, endPoint: .bottom)
    
    var body: some View {
        ZStack{
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
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                VStack{
                    Text("New Poll")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)
                ScrollView{
                    VStack(alignment:.leading){
                        VStack(alignment:.leading){
                            Text("Poll Name:")
                                .font(.system(size: 25))
                                .fontWeight(.medium)
                            TextField("President Ellection", text: $pollName)
                                .font(.system(size: 25))
                            Divider()
                        }
                        .padding()
                    }
                    .background(.white.opacity(0.8))
                    .cornerRadius(20)
                    VStack{
                        HStack{
                            Text("Options:")
                                .font(.system(size: 25))
                                .fontWeight(.medium)
                            Spacer()
                            Picker("",selection:$noOptions){
                                Text("2")
                                    .font(.system(size: 25))
                                    .fontWeight(.medium)
                                    .tag("2")
                                Text("4")
                                    .font(.system(size: 25))
                                    .fontWeight(.medium)
                                    .tag("4")
                            }
                            .foregroundColor(.black)
                        }
                        VStack{
                            TextField("Option 1", text: $option1)
                                .font(.system(size: 25))
                                .fontWeight(.medium)
                            Divider()
                            TextField("Option 2", text: $option2)
                                .font(.system(size: 25))
                                .fontWeight(.medium)
                            Divider()
                            if(noOptions == "4"){
                                TextField("Option 3", text: $option3)
                                    .font(.system(size: 25))
                                    .fontWeight(.medium)
                                Divider()
                                TextField("Option 4", text: $option4)
                                    .font(.system(size: 25))
                                    .fontWeight(.medium)
                                Divider()
                            }
                        }
                    }
                    .padding()
                    .background(.white.opacity(0.8))
                    .cornerRadius(20)
                    VStack(alignment:.leading){
                        HStack{
                            Text("Poll Date:")
                                .font(.system(size: 25))
                                .fontWeight(.medium)
                            Spacer()
                            DatePicker("Poll Date", selection: $pollDate, in: Date.now..., displayedComponents: .date)
                                .font(.system(size: 25))
                                .fontWeight(.medium)
                                .labelsHidden()
                        }
                    }
                    .padding()
                    .background(.white.opacity(0.8))
                    .cornerRadius(20)
                    VStack{
                        VStack(alignment:.leading){
                            HStack{
                                Text("Company:")
                                    .font(.system(size: 25))
                                    .fontWeight(.medium)
                                Spacer()
                                Text(currentUser[0].company)
                                    .font(.system(size: 20))
                                    .fontWeight(.regular)
                            }
                        }
                        VStack(alignment:.leading){
                            HStack{
                                Text("Post:")
                                    .font(.system(size: 25))
                                    .fontWeight(.medium)
                                Spacer()
                                Picker("",selection: $post){
                                    Text("All")
                                        .font(.system(size: 25))
                                        .fontWeight(.medium)
                                        .tag("All")
                                    ForEach(currentCompany[0].posts.indices){ indices in
                                        Text(currentCompany[0].posts[indices])
                                            .font(.system(size: 25))
                                            .fontWeight(.medium)
                                            .tag(currentCompany[0].posts[indices])
                                    }
                                }
                            }
                        }
                        VStack(alignment:.leading){
                            HStack{
                                Text("Other:")
                                    .font(.system(size: 25))
                                    .fontWeight(.medium)
                                Spacer()
                                Picker("",selection: $others){
                                    Text("All")
                                        .font(.system(size: 25))
                                        .fontWeight(.medium)
                                        .tag("All")
                                    ForEach(currentCompany[0].groups.indices){ indices in
                                        Text(currentCompany[0].groups[indices])
                                            .font(.system(size: 25))
                                            .fontWeight(.medium)
                                            .tag(currentCompany[0].groups[indices])
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(.white.opacity(0.8))
                    .cornerRadius(20)
                    Spacer()
                    VStack{
                        Button(action:{savePoll()}){
                            Text("Add")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(.red.opacity(0.9))
                        .cornerRadius(20)
                    }
                }
            }
            .padding()
            .alert(isPresented: $formInvalidity){
                Alert(title: Text("Form Error"), message: Text(formStatus))
            }
        }
    }
}
