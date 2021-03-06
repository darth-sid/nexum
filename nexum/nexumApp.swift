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

public var auth: String = "0"
public var acct: Acct = Acct(Fname:"John",Lname: "Smith",phoneNo:"(123)456-7890",email:"john.smith@email.com",links:["www.johnsmith.com","https://www.youtube.com/watch?v=dQw4w9WgXcQ"],productNames:["John","Smith"]);

public struct Response: Codable {
    var auth: String
    var acct: Acct
}

public struct Acct: Codable {
    var Fname : String
    var Lname : String
    var phoneNo : String
    var email : String
    var links: [String]
    var productNames: [String]
}

public struct newAcct: Codable{
    var usr: String
    var pwd: String
    var acct: Acct
}

func login(usr: String, pwd: String){
    let payload: [String:String] = ["usr":usr,"pwd":pwd]
    let payloadEncoded = try! JSONSerialization.data(withJSONObject: payload)
    guard let url = URL(string:"http://127.0.0.1:5000/login" ) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = payloadEncoded
    let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
        if let error = error {
            print("Error: \(error)")
            return
        }
        if let data = data{
            print(data)
            if let dataDecoded = try? JSONDecoder().decode(Response.self, from: data){
                DispatchQueue.main.async{
                    print("e")
                    auth = dataDecoded.auth
                    acct = dataDecoded.acct
                }
            }
        }
    }
    
    task.resume()
}

func register(usr: String, pwd: String, acct: Dictionary<String,Any>){
    let payload:Dictionary<String,Any> = ["usr":usr,"pwd":pwd,"acct":acct]
    let payloadEncoded = try! JSONSerialization.data(withJSONObject: payload)
    guard let url = URL(string:"http://127.0.0.1:5000/register" ) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = payloadEncoded
    let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
        if let error = error {
            print("Error: \(error)")
            return
        }
    }
    task.resume()
}

func logout(id: String){
    let payload: [String:String] = ["id":id]
    let payloadEncoded = try! JSONSerialization.data(withJSONObject: payload)
    guard let url = URL(string:"http://127.0.0.1:5000/logout" ) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = payloadEncoded
    let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
        if let error = error {
            print("Error: \(error)")
            return
        }
    }
    
    task.resume()
}

func getAcct(id: String){
    let payload: [String:String] = ["id":id]
    let payloadEncoded = try! JSONSerialization.data(withJSONObject: payload)
    guard let url = URL(string:"http://127.0.0.1:5000/acct" ) else {return}
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = payloadEncoded
    let task = URLSession.shared.dataTask(with: request) { (data,response,error) in
        if let error = error {
            print("Error: \(error)")
            return
        }
        if let data = data{
            if let dataDecoded = try? JSONDecoder().decode(Acct.self, from: data){
                DispatchQueue.main.async{acct = dataDecoded}
            }
        }
    }
    
    task.resume()
}

// Created by: Brighton Alcantara
// Edited by: Siddharth Ajay
struct Search: View {
    @State var image = "offbutton";
    @State var searchItem = "";
    @State var emptyBool = true;
    @State var someSelect = "";
    var body: some View {
        ZStack {
            bgcolor.ignoresSafeArea()
            //Image("g r a ss")
            // . resizable().aspectRatio(1.5,contentMode: .fill)
            
            VStack(){
                Spacer()
                    .frame(height: 60)
                Text("Search")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                // Search bar
                ZStack() {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width:300, height: 30)
                        .foregroundColor(.white)
                    HStack() {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 20, height: 20)
                    
                        TextField("Search...", text: $searchItem)
                            .background(.white)
                            .frame(width: 250)
                    }
                }
                
                // Filters
                HStack {
                    Spacer()
                    
                    // "Sort by" menu
                    Text("Sort by:")
                        .foregroundColor(.white)
                        .font(.caption)
                    ZStack() {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width:100, height: 30)
                            .foregroundColor(.white)
                        Picker("sortby", selection: $someSelect) {
                            Text("Latest").tag("Latest")
                            Text("Oldest").tag("Latest")
                            Text("Most Popular").tag("Latest")
                        }
                    }
                    Spacer()
                        .frame(width: 6)
                    
                    // "Show" menu
                    Text("Show:")
                        .foregroundColor(.white)
                        .font(.caption)
                    ZStack() {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width:80, height: 30)
                            .foregroundColor(.white)
                        Picker("show", selection: $someSelect) {
                            Text("All").tag("Latest")
                            Text("People").tag("Latest")
                            Text("Products").tag("Latest")
                        }
                    }
                Spacer()
                }
                
                // Search results
                ZStack() {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(gray1)
                        .frame(width: 300.0, height:500.0,alignment: .top)
                    VStack() {
                        Spacer()
                            .frame(height: 10)
                        ScrollView {
                            
                            // People
                            HStack() {
                                Spacer()
                                    .frame(width: 20)
                                Text("People")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            
                            // Candice
                            Button(action: {emptyBool = false}) {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 50, height: 50)
                                Spacer()
                                    .frame(width: 10)
                                
                                // Quick Personal info
                                VStack(alignment: .leading) {
                                    Text("Candice")
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                    Text("Investor")
                                        .italic()
                                        .foregroundColor(.purple)
                                        .font(.subheadline)
                                    Text("Hello! I am an investor looking to...")
                                        .font(.caption)
                                        .foregroundColor(.black)
                                            
                                } ;Spacer()}.frame(width: 280, height: 60)
                            
                            // Perry
                            Button(action: {emptyBool = false}) {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 50, height: 50)
                                Spacer()
                                    .frame(width: 10)
                                
                                // Quick Personal info
                                VStack(alignment: .leading) {
                                    Text("Perry")
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                    Text("Entrepreneur")
                                        .italic()
                                        .foregroundColor(.purple)
                                        .font(.subheadline)
                                    Text("Hi! I am an entrepreneur trying to...")
                                        .font(.caption)
                                        .foregroundColor(.black)
                                            
                                }; Spacer()}.frame(width: 280, height: 60)
                        
                            HStack() {
                                Spacer()
                                    .frame(width: 20)
                                Text("Products")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            
                            // Products
                            Button(action: {emptyBool = false}) {
                                Image(systemName: "shippingbox.circle.fill")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 50, height: 50)
                                Spacer()
                                    .frame(width: 10)
                                
                                // Quick Personal info
                                VStack(alignment: .leading) {
                                    Text("Robotic Turret")
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                    Text("Created By: Perry")
                                        .italic()
                                        .foregroundColor(.purple)
                                        .font(.subheadline)
                                    Text("Engineering, Robotics, Tech")
                                        .font(.caption)
                                        .foregroundColor(.black)
                                            
                                } ;Spacer()}.frame(width: 280, height: 60)
                    }
                }
            }
            .frame(width: 300.0, height: 500.0,alignment: .top)
            }
        }
}
}
struct ChangeUsername: View {
    @State var emptyBool = true;
    @State var page = 0;
    @State var username = ""
    var body: some View {
        if (page == 0) {
            ZStack() {
                bgcolor.ignoresSafeArea()
                VStack() {
                    Spacer()
                        .frame(height: 30)
                    Text("Change Username")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                        .frame(height:40)
                    Text("New Username:")
                        .foregroundColor(.white)
                    ZStack {
                        RoundedRectangle(cornerRadius:10)
                            .fill(gray1)
                            .frame(width: 200.0, height: 30.0)
                        TextField("",text:$username).frame(width: 180, height: 30.0)
                    }
                    Spacer()
                        .frame(height: 30)
                    ZStack {
                        RoundedRectangle(cornerRadius:10)
                            .fill(purple1)
                            .frame(width: 65.0, height: 30.0)
                        
                        // SETS THE USERNAME
                        Button(action:{page = 1
                            
                        }) {
                            Text("Set")
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
                .frame(width: 300.0, height: 500.0,alignment: .top)
            }
        }
        else if (page == 1) {
            Settings()
        }
    }
}
struct ChangePassword: View {
    @State var emptyBool = true;
    @State var page = 0;
    @State var password = ""
    @State var confirm = ""
    var body: some View {
        if (page == 0) {
            ZStack() {
                bgcolor.ignoresSafeArea()
                VStack() {
                    Spacer()
                        .frame(height: 30)
                    Text("Change Password")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                        .frame(height:40)
                    Text("New Password:")
                        .foregroundColor(.white)
                    ZStack {
                        RoundedRectangle(cornerRadius:10)
                            .fill(gray1)
                            .frame(width: 200.0, height: 30.0)
                        TextField("",text:$password).frame(width: 180, height: 30.0)
                    }
                    Spacer()
                        .frame(height: 30)
                    Text("Confirm Password:")
                        .foregroundColor(.white)
                    ZStack {
                        RoundedRectangle(cornerRadius:10)
                            .fill(gray1)
                            .frame(width: 200.0, height: 30.0)
                        TextField("",text:$password).frame(width: 180, height: 30.0)
                    }
                    Spacer()
                        .frame(height: 30)
                    ZStack {
                        RoundedRectangle(cornerRadius:10)
                            .fill(purple1)
                            .frame(width: 65.0, height: 30.0)
                        
                        // SETS THE USERNAME
                        Button(action:{page = 1
                            
                        }) {
                            Text("Set")
                                .foregroundColor(.white)
                        }
                    }
                    //Spacer()
                    }
                .frame(width: 300.0, height: 500.0,alignment: .top)
                }
        }
        else if (page == 1) {
            Settings()
        }
    }
}
struct ChangeDisplay: View {
    @State var emptyBool = true;
    @State var page = 0;
    @State var firstname = ""
    @State var lastname = ""
    var body: some View {
        if (page == 0) {
            ZStack() {
                bgcolor.ignoresSafeArea()
                VStack() {
                    Spacer()
                        .frame(height: 30)
                    Text("Change Display Name")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                        .frame(height:40)
                    Text("New Real Name:")
                        .foregroundColor(.white)
                    ZStack {
                        RoundedRectangle(cornerRadius:10)
                            .fill(gray1)
                            .frame(width: 200.0, height: 30.0)
                        TextField("",text:$firstname).frame(width: 180, height: 30.0)
                    }
                    Spacer()
                        .frame(height: 30)
                    Text("New Last Name:")
                        .foregroundColor(.white)
                    ZStack {
                        RoundedRectangle(cornerRadius:10)
                            .fill(gray1)
                            .frame(width: 200.0, height: 30.0)
                        TextField("",text:$lastname).frame(width: 180, height: 30.0)
                    }
                    Spacer()
                        .frame(height: 30)
                    ZStack {
                        RoundedRectangle(cornerRadius:10)
                            .fill(purple1)
                            .frame(width: 65.0, height: 30.0)
                        
                        // SETS THE USERNAME
                        Button(action:{page = 1
                            
                        }) {
                            Text("Set")
                                .foregroundColor(.white)
                        }
                    }
                    }
                .frame(width: 300.0, height: 500.0,alignment: .top)
                }
        }
        else if (page == 1) {
            Settings()
        }
    }
}
struct ChangeContact: View {
    @State var emptyBool = true;
    @State var page = 0;
    @State var email = "";
    @State var phone = "";
    var body: some View {
        if (page == 0) {
            ZStack() {
                bgcolor.ignoresSafeArea()
                VStack() {
                    Spacer()
                        .frame(height: 30)
                    Text("Change Contact Info")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                        .frame(height:40)
                    Text("New Email:")
                        .foregroundColor(.white)
                    ZStack {
                        RoundedRectangle(cornerRadius:10)
                            .fill(gray1)
                            .frame(width: 200.0, height: 30.0)
                        TextField("",text:$email).frame(width: 180, height: 30.0)
                    }
                    Spacer()
                        .frame(height: 30)
                    Text("New Phone Number:")
                        .foregroundColor(.white)
                    ZStack {
                        RoundedRectangle(cornerRadius:10)
                            .fill(gray1)
                            .frame(width: 200.0, height: 30.0)
                        TextField("",text:$phone).frame(width: 180, height: 30.0)
                    }
                    Spacer()
                        .frame(height: 30)
                    ZStack {
                        RoundedRectangle(cornerRadius:10)
                            .fill(purple1)
                            .frame(width: 65.0, height: 30.0)
                        
                        // SETS THE USERNAME
                        Button(action:{page = 1
                            
                        }) {
                            Text("Set")
                                .foregroundColor(.white)
                        }
                    }
                    }
                .frame(width: 300.0, height: 500.0,alignment: .top)
            }
        }

        else if (page == 1) {
            Settings()
        }
    }
}
struct ChangeBiography: View {
    @State var emptyBool = true;
    @State var page = 0;
    @State var bio = "";
    @State var product = "";
    var body: some View {
        if (page == 0) {
            ZStack() {
                bgcolor.ignoresSafeArea()
                VStack() {
                    Spacer()
                        .frame(height: 30)
                    Text("Change Biography")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                        .frame(height:40)
                    Text("New Username:")
                        .foregroundColor(.white)
                    ZStack {
                        RoundedRectangle(cornerRadius:10)
                            .fill(gray1)
                            .frame(width: 200.0, height: 30.0)
                        TextField("",text:$product).frame(width: 180, height: 30.0)
                    }
                    Spacer()
                        .frame(height: 30)
                    ZStack {
                        RoundedRectangle(cornerRadius:10)
                            .fill(purple1)
                            .frame(width: 65.0, height: 30.0)
                        
                        // SETS THE USERNAME
                        Button(action:{page = 1
                            
                        }) {
                            Text("Set")
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
                .frame(width: 300.0, height: 500.0,alignment: .top)
            }
        }
        else if (page == 1) {
            Settings()
        }
    }
}

// Created by: Brighton Alcantara
// Edited by: Siddharth Ajay
struct Settings: View {
    @State var image = "offbutton";
    @State var emptyBool = true;
    @State var option = 0;
    var body: some View {
        switch option {
        case 1:
            ChangeUsername();
        case 2:
            ChangePassword();
        case 3:
            ChangeDisplay();
        case 4:
            ChangeContact();
        case 5:
            ChangeBiography();
        default:
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
                    .frame(height:40)
                
                // Profile picture settings
                HStack() {
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 120, height: 100)
                Spacer()
                    .frame(width: 20)
                }
                Spacer()
                    .frame(height:10)
                
                // Settings List
                List {
                    Button(action: {option = 1}) {
                        Text("Change Username")
                    } .listRowBackground(gray1)
                    Button(action: {option = 2}) {
                        Text("Change Password")
                    } .listRowBackground(gray1)
                    Button(action: {option = 3}) {
                        Text("Change Display Name")
                    } .listRowBackground(gray1)
                    Button(action: {option = 4}) {
                        Text("Change Contact Info")
                    } .listRowBackground(gray1)
                    Button(action: {option = 5}) {
                        Text("Change Biography")
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
}

// Created by: Brighton Alcantara
// Edited by: Siddharth Ajay
struct Profile: View {
    var body: some View {
        ZStack {
            bgcolor.ignoresSafeArea()
            //Image("g r a ss")
            // . resizable().aspectRatio(1.5,contentMode: .fill)
            
            VStack(){
                Spacer()
                
                // Profile title
                Text(acct.Fname + "'s Profile")
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
                        Text(acct.Fname + " " + acct.Lname)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        Text("Entrepreneur")
                            .italic()
                            .foregroundColor(.purple)
                        Text("Contact here: \(acct.phoneNo) \(acct.email)")
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
                                ForEach(0..<acct.links.count, id:\.self){
                                    Text(acct.links[$0]).foregroundColor(.blue)
                                }
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
                                ForEach(0..<acct.productNames.count, id:\.self){
                                    Text(acct.productNames[$0]).foregroundColor(.white)
                                }
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
        
        Profile()
            .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
            }
            .tag(1)
        Search()
            .tabItem {
                Image(systemName: "magnifyingglass.circle.fill")
                Text("Search")
                    
                }.tag(2)
        Settings()
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }
            .tag(3)
            
        }

    }
}

struct Register: View {
    
    @State var username = ""
    @State var password = ""
    @State var confirm = ""
    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var phone = ""
    @State var page = 0
    var body: some View {
        ZStack {
            bgcolor.ignoresSafeArea()
            //Image("g r a ss")
            // . resizable().aspectRatio(1.5,contentMode: .fill)
            
            if(page == 0) {
                VStack(alignment: .center){
                    Spacer()
                        //On Off Button
                    HStack {
                        Text("Username:")
                        ZStack {
                            RoundedRectangle(cornerRadius:10)
                                .fill(purple1)
                                .frame(width: 200.0, height: 30.0)
                            TextField("",text:$username).frame(width: 180, height: 30.0)

                        }
                    }
                    HStack {
                        Text("Password:")
                        ZStack {
                            RoundedRectangle(cornerRadius:10)
                                .fill(purple1)
                                .frame(width: 200.0, height: 30.0)
                            TextField("",text:$password).frame(width: 180, height: 30.0)

                        }
                    }
                    HStack {
                        Text("Confirm Password:")
                        ZStack {
                            RoundedRectangle(cornerRadius:10)
                                .fill(purple1)
                                .frame(width: 200.0, height: 30.0)
                            TextField("",text:$confirm).frame(width: 180, height: 30.0)

                        }
                    }
                    HStack {
                        Text("First Name:")

                        ZStack {
                            RoundedRectangle(cornerRadius:10)
                                .fill(purple1)
                                .frame(width: 200.0, height: 30.0)
                            TextField("",text:$firstname).frame(width: 180, height: 30.0)

                        }
                    }
                    HStack {
                        Text("Last Name:")
                        ZStack {
                            RoundedRectangle(cornerRadius:10)
                                .fill(purple1)
                                .frame(width: 200.0, height: 30.0)
                            TextField("",text:$lastname).frame(width: 180, height: 30.0)

                        }
                    }
                    HStack {
                        Text("Email:")

                        ZStack {
                            RoundedRectangle(cornerRadius:10)
                                .fill(purple1)
                                .frame(width: 200.0, height: 30.0)
                            TextField("",text:$email).frame(width: 180, height: 30.0)

                        }
                    }
                    HStack {
                        Text("Phone:")
                        ZStack {
                            RoundedRectangle(cornerRadius:10)
                                .fill(purple1)
                                .frame(width: 200.0, height: 30.0)
                            TextField("",text:$phone).frame(width: 180, height: 30.0)

                        }
                    }
                    Spacer()
                    Button(action:{
                        if(email != "" && username != "" && password != "" && password == confirm && firstname != "" && lastname != ""){
                            let a: Dictionary<String, Any> = ["Fname":firstname,"Lname":lastname,"phoneNo":phone,"email":email,"links":[""],"productNames":[""]]
                            register(usr:username,pwd:password,acct:a)
                            page=1
                        }
                    }){
                        HStack {
                            Text("Register")
                            Image(systemName: "play")
                        }
                    }
                    //Spacer()
                }
                .frame(width: 300.0, height: 500.0,alignment: .top)
            }
            else if (page == 1){
                Login()
            }
        }
    }
}

struct Login: View {
    @State var usr = "";
    @State var pwd = "";
    @State var loggedIn = false
    @State var registering = false
    var body: some View {
        ZStack {
            if(loggedIn){
                Menu();
            }
            else if(registering){
                Register()
            }
            else{
                ZStack {
                    bgcolor.ignoresSafeArea()
                    VStack{
                        Spacer()
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
                            /*var i = 0;
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
                            print(auth)*/
                            login(usr:usr,pwd:pwd)
                            if(auth != "0"){
                                //getAcct(id: auth)
                                loggedIn = true
                            }
                            print(auth)
                        }){
                            //Text("Login")
                            Image(systemName:"chevron.right.circle").resizable().frame(width: 25.0, height: 25.0)
                        }
                        .padding(.top)
                        Spacer()
                        Button(action:{registering=true}){
                            Text("Register")
                        }
                        //}
                        Spacer()

                    }
                }
            }
        }
    }
}

struct nexumPreview: PreviewProvider {
    static var previews: some View {
        ChangePassword()
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
