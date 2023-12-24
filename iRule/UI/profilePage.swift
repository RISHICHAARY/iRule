import SwiftUI
import RealmSwift

struct profilePage: View {
    
    @ObservedResults(Users.self) var users: Results<Users>
    
    @Binding var mainPageState: String
    @Binding var loginState:String
    @Binding var userID: String
    
    let backgroundGradient = LinearGradient(gradient: Gradient(colors: [Color.gray, Color.teal, Color.cyan, Color.indigo, Color.blue]),startPoint: .topTrailing, endPoint: .bottom)
    
    var currentUser: [Users] {
        users.filter{$0.email == userID && $0.type == "user"}
    }
    
    func homeSwitch(){
        mainPageState = "Home"
    }
    
    func logOut(){
        UserDefaults.standard.set(false,forKey: "LoginState")
        UserDefaults.standard.set("",forKey: "LoggedUserID")
        UserDefaults.standard.set("",forKey: "LoggedUserType")
        loginState = "None"
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
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                
                VStack(alignment:.center){
                    Text("W")
                        .font(.custom("montserrat", size: 75))
                        .foregroundColor(.white)
                        .frame(width: 110 , height:110)
                        .background(.orange)
                        .cornerRadius(100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(.white, lineWidth: 5)
                        )
                    Text(currentUser[0].name)
                        .font(.system(size: 35))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .padding(.bottom,1)
                    Text("USER")
                        .font(.system(size: 25))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.bottom,1)
                }
                
                ScrollView{
                    VStack(alignment:.leading){
                        HStack{
                            Text("Company:")
                                .font(.system(size: 25))
                            Spacer()
                            Text(currentUser[0].company)
                                .font(.system(size: 25))
                        }
                        .padding(.bottom,1)
                        HStack{
                            Text("Post:")
                                .font(.system(size: 25))
                            Spacer()
                            Text(currentUser[0].post)
                                .font(.system(size: 25))
                        }
                        .padding(.bottom,1)
                        HStack{
                            Text("Clubs:")
                                .font(.system(size: 25))
                            Spacer()
                            VStack{
                                ForEach(currentUser[0].others, id: \.self){ club in
                                    Text("\(club)")
                                        .font(.system(size: 25))
                                        .padding(.bottom,0.5)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding(.vertical,10)
                    .padding(.horizontal,10)
                    .foregroundColor(.black)
                    .background(.white.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.vertical,20)
                    
                    VStack{
                        HStack(spacing:35){
                            ZStack{
                                Circle()
                                    .stroke(
                                        Color.pink.opacity(0.5),
                                        lineWidth: 20
                                    )
                                Circle()
                                    .trim(from: 0, to: CGFloat(Float(currentUser[0].participatedpolls.count)/Float(currentUser[0].assignedpolls)))
                                    .stroke(
                                        Color.pink,
                                        lineWidth: 10
                                    )
                                Text("\(Int((Float(currentUser[0].participatedpolls.count)/Float(currentUser[0].assignedpolls))*100))%")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                            }
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
                            Text("Participation")
                                .font(.system(size: 30))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.bottom,25)
                    HStack{
                        
                        VStack{
                            Text("Polled")
                                .font(.system(size: 30))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Text("\(currentUser[0].participatedpolls.count)")
                                .font(.system(size: 30))
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        
                        Divider()
                            .overlay(.white)
                        
                        VStack{
                            Text("Total")
                                .font(.system(size: 30))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Text("\(currentUser[0].assignedpolls)")
                                .font(.system(size: 30))
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                    }
                }
                
                Spacer()
                VStack{
                    Button(action:{logOut()}){
                        Text("Logout")
                            .font(.custom("montserrat", size: 25))
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.red.opacity(0.9))
                    .cornerRadius(20)
                }
            }
            .padding(10)
        }
    }
}
