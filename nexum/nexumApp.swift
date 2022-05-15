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
public struct Response: Codable {
    var status: Int
}

func login(usr: String, pwd: String, authKey: String){
    let payload: [String:String] = ["usr":usr,"pwd":pwd,"auth":authKey]
    let payloadEncoded = try! JSONSerialization.data(withJSONObject: payload)
    guard let url = URL(string:"http://192.168.1.23:5000/login" ) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = payloadEncoded
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            if let decodedData = try? JSONDecoder().decode(Response.self, from: data) {
                print("d:\(decodedData)")
            }
        }
    }.resume()
}



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

// Created by: Brighton Alcantara
// Edited by: Siddharth Ajay
struct Settings: View {
    @State var image = "offbutton";
    @State var emptyBool = false;
    var body: some View {
        ZStack {
            bgcolor.ignoresSafeArea()
            //Image("g r a ss")
            // . resizable().aspectRatio(1.5,contentMode: .fill)
            
            VStack(){
                Spacer()
                Text("Settings")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                    .frame(height:20)
                
                // Profile picture settings
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 100, height: 100)
                Spacer()
                // Settings List
                List {
                    Button(action: {emptyBool = true}) {
                        Text("Change Username")
                    } .listRowBackground(gray1)
                    Button(action: {emptyBool = true}) {
                        Text("Change Username")
                    } .listRowBackground(gray1)

                }
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }

                Spacer()
            }
            .frame(width: 300.0, height: 500.0,alignment: .top)
            }
        }
}

// Created by: Brighton Alcantara
// Edited by: Siddharth Ajay
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
        Settings()
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
    @State var auth = "";
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
                        var i = 0;
                        auth = ""
                        while(i < 20){
                            let x = Int.random(in: 0..<3)
                            if (x==0){
                                auth = auth + String(Int.random(in: 0..<10));
                            }
                            else if (x==1){
                                auth = auth + String(UnicodeScalar(UInt8(Int.random(in: 65..<91))));
                            }
                            else{
                                auth = auth + String(UnicodeScalar(UInt8(Int.random(in: 97..<123))));
                            }
                            i = i + 1;
                        }
                        print(auth)
                        login(usr:usr,pwd:pwd,authKey:auth)
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
        Settings()
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
