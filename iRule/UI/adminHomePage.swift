//
//  homePage.swift
//  iRule
//
//  Created by user1 on 05/12/23.
//

import SwiftUI
import RealmSwift

struct adminHomePage: View {
    
    @Environment(\.realm) var realm
    
    @ObservedResults(Users.self) var users: Results<Users>
    @ObservedResults(Polls.self) var polls: Results<Polls>
    
    @Binding var adminPageState: String
    @Binding var userID: String
    @Binding var pollID: ObjectId
    
    let backgroundGradient = LinearGradient(gradient: Gradient(colors: [Color.gray, Color.teal, Color.cyan, Color.indigo, Color.blue]),startPoint: .topTrailing, endPoint: .bottom)
    
    var currentUser: [Users] {
        users.filter{$0.email == userID && $0.type == "admin"}
    }
    
    var userPollsinActive: [Polls] {
        polls.filter{$0.company == currentUser[0].company && $0.status == "inActive"}
    }
    
    var userPollsActive: [Polls] {
        polls.filter{$0.company == currentUser[0].company && $0.status == "Active"}
    }
    
    var userPollsCompleted: [Polls] {
        polls.filter{$0.company == currentUser[0].company && $0.status == "Completed"}
    }
    
    func profileSwitch(){
        adminPageState = "Profile"
    }
    
    func pollSwitch( polliD: ObjectId ){
        pollID = polliD
        adminPageState = "View"
    }
    
    func addSwitch(){
        adminPageState = "Add"
    }
    
    
    var body: some View {
        ZStack(alignment: .bottom){
            backgroundGradient.ignoresSafeArea(.all)
            Text("Smart Poll")
                .font(.system(size: 50,weight: .medium))
                .foregroundColor(.white)
                .offset(y:-650)
            VStack{
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text(currentUser[0].name)
                                .font(.system(size: 30,weight: .bold))
                            Text("ADMIN")
                                .font(.system(size: 20))
                        }
                        .foregroundColor(.white)
                        Spacer()
                        VStack(alignment: .trailing){
                            Button(action: {profileSwitch()}){
                                Text("H")
                                    .font(.system(size: 40))
                                    .frame(width: 75 , height: 75)
                                    .background(.yellow)
                                    .cornerRadius(100)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 100)
                                            .stroke(.white, lineWidth: 5)
                                    )
                            }
                        }
                        .foregroundColor(.white)
                    }
                    .padding(.top,25)
                    .padding(.horizontal,10)
                    
                    VStack(alignment:.leading){
                        HStack{
                            Text("Pollings")
                                .font(.system(size: 45))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                                .padding(.bottom,20)
                            Spacer()
                        }
                        ScrollView{
                            if(userPollsActive.count == 0 && userPollsinActive.count == 0 && userPollsCompleted.count == 0){
                                VStack(alignment:.center){
                                    Text("No Pollings Found")
                                        .font(.system(size: 25))
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity)
                            }
                            else{
                                ForEach(userPollsActive, id: \._id){ poll in
                                    VStack(alignment:.leading){
                                        VStack(alignment:.leading){
                                            HStack{
                                                Text(poll.name)
                                                    .font(.system(size: 25))
                                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                    .padding(.bottom,2)
                                                Spacer()
                                                Text("Active")
                                                    .font(.system(size: 15))
                                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                    .padding(.bottom,2)
                                                    .foregroundColor(.red)
                                            }
                                        }
                                        HStack{
                                            VStack(alignment:.leading){
                                                HStack{
                                                    Text("Options:")
                                                        .font(.system(size: 22))
                                                    Text(poll.noOptions)
                                                        .font(.system(size: 22))
                                                }
                                                HStack{
                                                    Text("On:")
                                                        .font(.system(size: 22))
                                                    Text(poll.date, style: .date)
                                                        .font(.system(size: 22))
                                                }
                                            }
                                            Spacer()
                                            VStack{
                                                Button(action:{pollSwitch( polliD: poll._id )}){
                                                    Text("View")
                                                        .font(.system(size: 25))
                                                        .fontWeight(.medium)
                                                        .padding()
                                                        .background(.blue)
                                                        .foregroundColor(.white)
                                                        .cornerRadius(15)
                                                }
                                            }
                                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                        }
                                    }
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                    .padding(.horizontal)
                                    .padding(.vertical)
                                    .background(.white.opacity(0.8))
                                    .cornerRadius(20)
                                    .padding(.bottom,10)
                                }
                                ForEach(userPollsinActive, id: \._id){ poll in
                                    VStack(alignment:.leading){
                                        VStack(alignment:.leading){
                                            HStack{
                                                Text(poll.name)
                                                    .font(.system(size: 25))
                                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                    .padding(.bottom,2)
                                                Spacer()
                                                Text("Upcomming")
                                                    .font(.system(size: 15))
                                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                    .padding(.bottom,2)
                                                    .foregroundColor(.orange)
                                            }
                                        }
                                        HStack{
                                            VStack(alignment:.leading){
                                                HStack{
                                                    Text("Options:")
                                                        .font(.system(size: 22))
                                                    Text(poll.noOptions)
                                                        .font(.system(size: 22))
                                                }
                                                HStack{
                                                    Text("On:")
                                                        .font(.system(size: 22))
                                                    Text(poll.date, style: .date)
                                                        .font(.system(size: 22))
                                                }
                                            }
                                            Spacer()
                                            VStack{
                                                Button(action:{pollSwitch( polliD: poll._id )}){
                                                    Text("View")
                                                        .font(.system(size: 25))
                                                        .fontWeight(.medium)
                                                        .padding()
                                                        .background(.blue)
                                                        .foregroundColor(.white)
                                                        .cornerRadius(15)
                                                }
                                            }
                                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                        }
                                    }
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                    .padding(.horizontal)
                                    .padding(.vertical)
                                    .background(.white.opacity(0.8))
                                    .cornerRadius(20)
                                    .padding(.bottom,10)
                                }
                                ForEach(userPollsCompleted, id: \._id){ poll in
                                    VStack(alignment:.leading){
                                        VStack(alignment:.leading){
                                            HStack{
                                                Text(poll.name)
                                                    .font(.system(size: 25))
                                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                    .padding(.bottom,2)
                                                Spacer()
                                                Text("Completed")
                                                    .font(.system(size: 15))
                                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                    .padding(.bottom,2)
                                                    .foregroundColor(.green)
                                            }
                                        }
                                        HStack{
                                            VStack(alignment:.leading){
                                                HStack{
                                                    Text("Options:")
                                                        .font(.system(size: 22))
                                                    Text(poll.noOptions)
                                                        .font(.system(size: 22))
                                                }
                                                HStack{
                                                    Text("On:")
                                                        .font(.system(size: 22))
                                                    Text(poll.date, style: .date)
                                                        .font(.system(size: 22))
                                                }
                                            }
                                            Spacer()
                                            VStack{
                                                Button(action:{pollSwitch( polliD: poll._id )}){
                                                    Text("View")
                                                        .font(.system(size: 25))
                                                        .fontWeight(.medium)
                                                        .padding()
                                                        .background(.blue)
                                                        .foregroundColor(.white)
                                                        .cornerRadius(15)
                                                }
                                            }
                                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                        }
                                    }
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                    .padding(.horizontal)
                                    .padding(.vertical)
                                    .background(.white.opacity(0.8))
                                    .cornerRadius(20)
                                    .padding(.bottom,10)
                                }
                            }
                        }
                    }
                    .padding(.horizontal,10)
                }
            }
            .padding(.top,110)
            Spacer()
            VStack{
                Button(action:{addSwitch()}){
                    Image(systemName: "plus")
                        .font(.system(size: 50))
                }
                .frame(width: 60,height: 60)
                .padding(10)
                .foregroundColor(.black)
                .background(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(.black, lineWidth: 8)
                )
                .cornerRadius(100)
                .shadow(radius: 10)
            }
            .frame(alignment:.bottom)
        }
    }
}
