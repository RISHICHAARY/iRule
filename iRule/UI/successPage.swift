//
//  successPage.swift
//  iRule
//
//  Created by user1 on 06/12/23.
//

import SwiftUI

struct successPage: View {
    
    @Binding var mainPageState:String
    
    let backgroundGradient = LinearGradient(gradient: Gradient(colors: [Color.gray, Color.teal, Color.cyan, Color.indigo, Color.blue]),startPoint: .topTrailing, endPoint: .bottom)
    
    func homeSwitch() async{
        try? await Task.sleep(nanoseconds: 2_000_000_000)
                mainPageState = "Home"
    }
    
    
    var body: some View {
        ZStack{
            backgroundGradient.ignoresSafeArea(.all)
            VStack{
                VStack{
                    Image(systemName: "checkmark")
                        .resizable()
                        .font(.system(size: 200))
                        .frame(width:150 ,height: 150)
                        .foregroundColor(.white)
                        .padding()
                        .shadow(color: .white, radius: 5)
                }
                .padding()
                .background(.green)
                .cornerRadius(100)
                .shadow(color: .green, radius: 30, x:0, y:10)
                VStack(spacing:10){
                    Text("DONE")
                        .font(.system(size: 50))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("Saved Successfully")
                        .font(.system(size: 25))
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .padding(.vertical,35)
            }
        }
        .task {
            await homeSwitch()
        }
    }
}

