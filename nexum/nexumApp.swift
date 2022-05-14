//
//  nexumApp.swift
//  nexum
//
//  Created by Sid Ajay on 5/14/22.
//

import SwiftUI

//colors
let bgcolor = Color(red: 60/255, green: 60/255, blue: 60/255)

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
struct empty4: View {
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
        empty4()
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
    var body: some View {
        VStack{
            HStack{
                Text("Username:")
                TextField($usr)
            }
            HStack{
                Text("Password:")
                TextField($pwd)
            }

        }
    }
}

struct nexumPreview: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}

@main
struct nexumApp: App {
    var body: some Scene {
        WindowGroup {
            Menu()
        }
    }
}
