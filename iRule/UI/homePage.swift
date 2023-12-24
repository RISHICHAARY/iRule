import SwiftUI
import RealmSwift

struct homePage: View {
    
    @ObservedResults(Users.self) var users: Results<Users>
    @ObservedResults(Polls.self) var polls: Results<Polls>
    
    @Binding var mainPageState: String
    @Binding var userID: String
    @Binding var pollID: ObjectId
    
    @State var filteredPolls: [Polls]!
    
    var currentUser: [Users] {
        users.filter{$0.email == userID && $0.type == "user"}
    }
    
    var userPollsActive: [Polls] {
        polls.filter{$0.company == currentUser[0].company && ($0.post == currentUser[0].post || currentUser[0].others.contains($0.others) || $0.post == "All" || $0.others == "All") && $0.status == "Active" && $0.date > Date.now}
    }
    
    var userPollsinActive: [Polls] {
        polls.filter{$0.company == currentUser[0].company && ($0.post == currentUser[0].post || currentUser[0].others.contains($0.others) || $0.post == "All" || $0.others == "All") && $0.status == "inActive" && $0.date > Date.now}
    }
    
    let backgroundGradient = LinearGradient(gradient: Gradient(colors: [Color.gray, Color.teal, Color.cyan, Color.indigo, Color.blue]),startPoint: .topTrailing, endPoint: .bottom)
    
    func profileSwitch(){
        mainPageState = "Profile"
    }
    
    func pollSwitch( polliD: ObjectId ){
        pollID = polliD
        mainPageState = "Poll"
    }
    
    var body: some View {
        ZStack{
            backgroundGradient.ignoresSafeArea(.all)
            Text("Smart Poll")
                .font(.system(size: 50,weight: .medium))
                .foregroundColor(.white)
                .offset(y:-300)
            VStack{
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text(currentUser[0].name)
                                .font(.system(size: 30,weight: .bold))
                            Text("USER")
                                .font(.system(size: 20))
                        }
                        .foregroundColor(.white)
                        Spacer()
                        VStack{
                            Button(action: {profileSwitch()}){
                                Text("W")
                                    .font(.system(size: 40))
                                    .frame(width: 75 , height: 75)
                                    .background(.orange)
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
                            if(userPollsActive.count == 0 && userPollsinActive.count == 0){
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
                                    if(currentUser[0].participatedpolls.contains(poll._id)){}
                                    else{
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
                                                        Text("Poll")
                                                            .font(.system(size: 25))
                                                            .fontWeight(.medium)
                                                            .padding()
                                                            .background(.red)
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
                                ForEach(userPollsinActive, id: \._id){ poll in
                                    if(currentUser[0].participatedpolls.contains(poll._id)){}
                                    else{
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
                                                        Text("Poll")
                                                            .font(.system(size: 25))
                                                            .fontWeight(.medium)
                                                            .padding()
                                                            .background(.red.opacity(0.75))
                                                            .foregroundColor(.white)
                                                            .cornerRadius(15)
                                                    }
                                                    .disabled(true)
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
                    }
                    .padding(.horizontal,10)
                }
            }
            .padding(.top,110)
        }
    }
}
