import SwiftUI
import RealmSwift

struct adminViewPage: View {
    
    @Environment(\.realm) var realm
    
    @ObservedResults(Polls.self) var polls: Results<Polls>
    
    @Binding var adminPageState:String
    @Binding var userID: String
    @Binding var pollID: ObjectId
    
    @State var leadBY: String = "None"
    
    let backgroundGradient = LinearGradient(gradient: Gradient(colors: [Color.gray, Color.teal, Color.cyan, Color.indigo, Color.blue]),startPoint: .topTrailing, endPoint: .bottom)
    
    var currentPoll: [Polls] {
        polls.filter{$0._id == pollID}
    }
    
    func homeSwitch(){
        adminPageState = "Home"
    }
    
    func togglePoll(){
        if(currentPoll[0].status == "inActive"){
            let pollToUpdate = realm.object(ofType: Polls.self, forPrimaryKey: currentPoll[0]._id)
            try? realm.write{
                pollToUpdate?.status = "Active"
            }
        }
        
        else if(currentPoll[0].status == "Active"){
            let pollToUpdate = realm.object(ofType: Polls.self, forPrimaryKey: currentPoll[0]._id)
            try? realm.write{
                pollToUpdate?.status = "Completed"
            }
        }
    }
    
    func leadFinder(){
        if(currentPoll[0].noOptions == "4"){
            if((currentPoll[0].options[0].option1Votes > currentPoll[0].options[0].option2Votes)
            && (currentPoll[0].options[0].option1Votes > currentPoll[0].options[0].option3Votes!)
               && (currentPoll[0].options[0].option1Votes > currentPoll[0].options[0].option4Votes!)){
                leadBY = "Option1"
            }
            else if((currentPoll[0].options[0].option2Votes > currentPoll[0].options[0].option2Votes)
            && (currentPoll[0].options[0].option2Votes > currentPoll[0].options[0].option3Votes!)
               && (currentPoll[0].options[0].option2Votes > currentPoll[0].options[0].option4Votes!)){
                leadBY = "Option2"
            }
            else if((currentPoll[0].options[0].option3Votes! > currentPoll[0].options[0].option1Votes)
            && (currentPoll[0].options[0].option3Votes! > currentPoll[0].options[0].option1Votes)
               && (currentPoll[0].options[0].option3Votes! > currentPoll[0].options[0].option4Votes!)){
                leadBY = "Option3"
            }
            else if((currentPoll[0].options[0].option4Votes! > currentPoll[0].options[0].option1Votes)
            && (currentPoll[0].options[0].option4Votes! > currentPoll[0].options[0].option1Votes)
               && (currentPoll[0].options[0].option4Votes! > currentPoll[0].options[0].option3Votes!)){
                leadBY = "Option4"
            }
        }
        else{
            if((currentPoll[0].options[0].option1Votes > currentPoll[0].options[0].option2Votes)){
                leadBY = "Option1"
            }
            else if((currentPoll[0].options[0].option2Votes > currentPoll[0].options[0].option1Votes)){
                leadBY = "Option2"
            }
        }
    }
    
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
                        
                        VStack(spacing:20){
                            if(leadBY == "Option1"){
                                HStack{
                                    VStack{
                                        Text(currentPoll[0].options[0].option1)
                                            .font(.system(size: 25))
                                            .fontWeight(.medium)
                                    }
                                    .frame(maxWidth: .infinity)
                                    Spacer()
                                    VStack{
                                        Text("\(currentPoll[0].options[0].option1Votes)")
                                            .font(.system(size: 25))
                                            .fontWeight(.bold)
                                        Text("Votes")
                                            .font(.system(size: 20))
                                    }
                                    .frame(maxWidth: .infinity)
                                }
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
                                HStack{
                                    VStack{
                                        Text(currentPoll[0].options[0].option1)
                                            .font(.system(size: 25))
                                            .fontWeight(.medium)
                                    }
                                    .frame(maxWidth: .infinity)
                                    Spacer()
                                    VStack{
                                        Text("\(currentPoll[0].options[0].option1Votes)")
                                            .font(.system(size: 25))
                                            .fontWeight(.bold)
                                        Text("Votes")
                                            .font(.system(size: 20))
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                .padding()
                                .background(.white.opacity(0.8))
                                .cornerRadius(20)
                                .padding(2)
                            }
                            
                            if(leadBY == "Option2"){
                                HStack{
                                    VStack{
                                        Text(currentPoll[0].options[0].option2)
                                            .font(.system(size: 25))
                                            .fontWeight(.medium)
                                    }
                                    .frame(maxWidth: .infinity)
                                    Spacer()
                                    VStack{
                                        Text("\(currentPoll[0].options[0].option2Votes)")
                                            .font(.system(size: 25))
                                            .fontWeight(.bold)
                                        Text("Votes")
                                            .font(.system(size: 20))
                                    }
                                    .frame(maxWidth: .infinity)
                                }
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
                                HStack{
                                    VStack{
                                        Text(currentPoll[0].options[0].option2)
                                            .font(.system(size: 25))
                                            .fontWeight(.medium)
                                    }
                                    .frame(maxWidth: .infinity)
                                    Spacer()
                                    VStack{
                                        Text("\(currentPoll[0].options[0].option2Votes)")
                                            .font(.system(size: 25))
                                            .fontWeight(.bold)
                                        Text("Votes")
                                            .font(.system(size: 20))
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                .padding()
                                .background(.white.opacity(0.8))
                                .cornerRadius(20)
                                .padding(2)
                            }
                            
                            if(currentPoll[0].noOptions == "4"){
                                if(leadBY == "Option3"){
                                    HStack{
                                        VStack{
                                            Text(currentPoll[0].options[0].option3!)
                                                .font(.system(size: 25))
                                                .fontWeight(.medium)
                                        }
                                        .frame(maxWidth: .infinity)
                                        Spacer()
                                        VStack{
                                            Text("\(currentPoll[0].options[0].option3Votes!)")
                                                .font(.system(size: 25))
                                                .fontWeight(.bold)
                                            Text("Votes")
                                                .font(.system(size: 20))
                                        }
                                        .frame(maxWidth: .infinity)
                                    }
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
                                    HStack{
                                        VStack{
                                            Text(currentPoll[0].options[0].option3!)
                                                .font(.system(size: 25))
                                                .fontWeight(.medium)
                                        }
                                        .frame(maxWidth: .infinity)
                                        Spacer()
                                        VStack{
                                            Text("\(currentPoll[0].options[0].option3Votes!)")
                                                .font(.system(size: 25))
                                                .fontWeight(.bold)
                                            Text("Votes")
                                                .font(.system(size: 20))
                                        }
                                        .frame(maxWidth: .infinity)
                                    }
                                    .padding()
                                    .background(.white.opacity(0.8))
                                    .cornerRadius(20)
                                    .padding(2)
                                }
                                
                                if(leadBY == "Option4"){
                                    HStack{
                                        VStack{
                                            Text(currentPoll[0].options[0].option4!)
                                                .font(.system(size: 25))
                                                .fontWeight(.medium)
                                        }
                                        .frame(maxWidth: .infinity)
                                        Spacer()
                                        VStack{
                                            Text("\(currentPoll[0].options[0].option4Votes!)")
                                                .font(.system(size: 25))
                                                .fontWeight(.bold)
                                            Text("Votes")
                                                .font(.system(size: 20))
                                        }
                                        .frame(maxWidth: .infinity)
                                    }
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
                                    HStack{
                                        VStack{
                                            Text(currentPoll[0].options[0].option4!)
                                                .font(.system(size: 25))
                                                .fontWeight(.medium)
                                        }
                                        .frame(maxWidth: .infinity)
                                        Spacer()
                                        VStack{
                                            Text("\(currentPoll[0].options[0].option4Votes!)")
                                                .font(.system(size: 25))
                                                .fontWeight(.bold)
                                            Text("Votes")
                                                .font(.system(size: 20))
                                        }
                                        .frame(maxWidth: .infinity)
                                    }
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
                if(currentPoll[0].status == "Completed"){
                    if(leadBY == "Option1"){
                        VStack{
                            HStack{
                                Text("Lead By:")
                                    .font(.system(size: 25))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                Spacer()
                                Text(currentPoll[0].options[0].option1)
                                    .font(.system(size: 25))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(.pink.opacity(0.8))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.white,lineWidth: 5)
                            )
                        }
                    }
                    else if(leadBY == "Option2"){
                        VStack{
                            HStack{
                                Text("Won By:")
                                    .font(.system(size: 25))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                Spacer()
                                Text(currentPoll[0].options[0].option2)
                                    .font(.system(size: 25))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(.pink.opacity(0.8))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.white,lineWidth: 5)
                            )
                        }
                    }
                    else if(leadBY == "Option3"){
                        VStack{
                            HStack{
                                Text("Won By:")
                                    .font(.system(size: 25))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                Spacer()
                                Text(currentPoll[0].options[0].option3!)
                                    .font(.system(size: 25))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(.pink.opacity(0.8))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.white,lineWidth: 5)
                            )
                        }
                    }
                    else if(leadBY == "Option4"){
                        VStack{
                            HStack{
                                Text("Won By:")
                                    .font(.system(size: 25))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                                Spacer()
                                Text(currentPoll[0].options[0].option4!)
                                    .font(.system(size: 25))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(.pink.opacity(0.8))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.white,lineWidth: 5)
                            )
                        }
                    }
                    else{
                        VStack{
                            HStack{
                                Text("Poll Drawn")
                                    .font(.system(size: 25))
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(.pink.opacity(0.8))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.white,lineWidth: 5)
                            )
                        }
                    }
                }
                else if(currentPoll[0].status == "inActive"){
                    VStack{
                        Button(action:{togglePoll()}){
                            Text("Start Poll")
                                .font(.custom("montserrat", size: 25))
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.red.opacity(0.9))
                        .cornerRadius(20)
                    }
                }
                else if(currentPoll[0].status == "Active"){
                    VStack{
                        Button(action:{togglePoll()}){
                            Text("End Poll")
                                .font(.custom("montserrat", size: 25))
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.red.opacity(0.9))
                        .cornerRadius(20)
                    }
                }
            }
            .padding()
            .task{
                leadFinder()
            }
        }
    }
}
