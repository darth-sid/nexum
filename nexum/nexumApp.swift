//
//  nexumApp.swift
//  nexum
//
//  Created by Sid Ajay on 5/14/22.
//

import SwiftUI

//colors
let bgcolor = Color(red: 60/255, green: 60/255, blue: 60/255)
let purple1 = Color(red: 88/255,green:0/255,blue:108/255)
let gray1 = Color(red: 88/255,green:88/255,blue:88/255)

//pages
struct empty1: View {
    @State var image = "offbutton"
    var body: some View {
        ZStack {
            bgcolor.ignoresSafeArea()
            //Image("g r a ss")
            // . resizable().aspectRatio(1.5,contentMode: .fill)
            
            VStack(){
                Spacer()
                    //On Off Button
                    

                Spacer()
            }
            .frame(width: 300.0, height: 500.0,alignment: .top)
            }
        }
}
struct empty2: View {
    @State var image = "offbutton"
    var body: some View {
        ZStack {
            bgcolor.ignoresSafeArea()
            //Image("g r a ss")
            // . resizable().aspectRatio(1.5,contentMode: .fill)
            
            VStack(){
                Spacer()
                    //On Off Button
                    

                Spacer()
            }
            .frame(width: 300.0, height: 500.0,alignment: .top)
            }
        }
}
struct empty3: View {
    @State var image = "offbutton"
    var body: some View {
        ZStack {
            bgcolor.ignoresSafeArea()
            //Image("g r a ss")
            // . resizable().aspectRatio(1.5,contentMode: .fill)
            
            VStack(){
                Spacer()
                    //On Off Button
                    

                Spacer()
            }
            .frame(width: 300.0, height: 500.0,alignment: .top)
            }
        }
}
struct Profile: View {
    @State var image = "offbutton"
    var body: some View {
        ZStack {
            bgcolor.ignoresSafeArea()
            //Image("g r a ss")
            // . resizable().aspectRatio(1.5,contentMode: .fill)
            
            VStack(){
                Spacer()
                
                // Profile title
                Text("Finn's Profile")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    
                HStack(){
                    Spacer()
                    
                    // Profile picture
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 100, height: 100)
                    Spacer()
                    
                    // Quick Personal info
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Fineas Phlynn")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        Text("Entrepreneur")
                            .italic()
                            .foregroundColor(.purple)
                        Text("Contact here: (123) 456-7889")
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                    .frame(height: 30)
                
                // About Me information
                ZStack() {
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/)
                        .foregroundColor(gray1)
                    HStack() {
                        Spacer()
                            .frame(width: 15)
                    VStack(alignment: .leading, spacing: 10) {
                        Spacer()
                            .frame(height: 5)
                        // My links
                        Text("My links: ")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        HStack() {
                            Spacer()
                                .frame(width: 10)
                            VStack(alignment: .leading) {
                                Text("Resume")
                                    .foregroundColor(.cyan)
                                Text("summervacationbuilds.com")
                                    .foregroundColor(.cyan)
                            }
                        }
                        
                        // My products
                        Text("Products: ")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        HStack() {
                            Spacer()
                                .frame(width: 10)
                            VStack(alignment: .leading) {
                                Text("Beach Robot")
                                    .foregroundColor(.white)
                                Text("")
                                    .foregroundColor(.white)
                            }
                            }
                        Spacer()
                        }
                        Spacer()
                    }
                }
            }
            .frame(width: 300.0, height: 500.0,alignment: .top)
            }
        }
}

struct Menu: View {
    @State var selection = 2
    var body: some View {
        //Tab Bar at bottom
        TabView(selection: $selection){
        empty1()
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }
            .tag(1)
        empty2()
            .tabItem {
                Image(systemName: "power")
                Text("Manual")
                    
                }.tag(2)
        empty3()
            .tabItem {
                Image(systemName: "square.grid.2x2")
                Text("Custom")
            
                
            }
            .tag(3)
        Profile()
            .tabItem {
                    Image(systemName: "leaf.fill")
                    Text("Plant Presets")
            }
            .tag(4)
            
        }

    }
}

struct Login: View {
    @State var usr = "";
    @State var pwd = "";
    @State var loggedIn = false;
    var body: some View {
        ZStack {
            bgcolor.ignoresSafeArea()
            VStack{
                Spacer()
                //HStack{
                Text("Username:")
                ZStack {
                    RoundedRectangle(cornerRadius:10)
                        .fill(purple1)
                        .frame(width: 200.0, height: 30.0)
                    TextField("e",text:$usr)
                        .multilineTextAlignment(.center)
                }
                //}
                //HStack{
                Text("Password:")
                ZStack {
                    RoundedRectangle(cornerRadius:10)
                        .fill(purple1)
                        .frame(width: 200.0, height: 30.0)
                    TextField("e",text:$pwd)
                        .multilineTextAlignment(.center)
                }
                Button(action:{loggedIn = true}){
                    //Text("Login")
                    Image(systemName:"chevron.right.circle").resizable().frame(width: 25.0, height: 25.0)
                }
                .padding(.top)
                
                //}
                Spacer()
        if(loggedIn){
            Menu();
        }
        else{
            ZStack {
                bgcolor.ignoresSafeArea()
                VStack{
                    Spacer()
                    //HStack{
                    Text("Username:")
                    ZStack {
                        RoundedRectangle(cornerRadius:10)
                            .fill(purple1)
                            .frame(width: 200.0, height: 30.0)
                        TextField("e",text:$usr)
                            .multilineTextAlignment(.center)
                    }
                    //}
                    //HStack{
                    Text("Password:")
                    ZStack {
                        RoundedRectangle(cornerRadius:10)
                            .fill(purple1)
                            .frame(width: 200.0, height: 30.0)
                        TextField("e",text:$pwd)
                            .multilineTextAlignment(.center)
                    }
                    Button(action:{
                        loggedIn = true
                        
                    }){
                        //Text("Login")
                        Image(systemName:"chevron.right.circle").resizable().frame(width: 25.0, height: 25.0)
                    }
                    .padding(.top)
                    
                    //}
                    Spacer()

                }
            }
        }
    }
}
    }
}
struct nexumPreview: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}

@main
struct nexumApp: App {
    var body: some Scene {
        WindowGroup {
            Login()
        }
    }
}
