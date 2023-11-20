//
//  ContentView.swift
//  FavCrypt
//
//  Created by Bora Gündoğu on 4.10.2023.
//

import SwiftUI



struct ContentView: View {
    
    var body: some View {
        Coins()
    }
}

#Preview {
    Coins()
}

struct Coins: View {
    @State var selectedTab = "Coins"
    @Namespace var animation
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 0) {
                GeometryReader {_ in
                    ZStack {
                        MainPage()
                            .opacity(selectedTab == "Coins" ? 1 : 0)
                        CoinPrediction()
                            .opacity(selectedTab == "Prediction" ? 1 : 0)
                    }
                }
                HStack(spacing: 0) {
                    ForEach(tabs, id:\.self) { tab in
                        Spacer()
                        TabButton(title: tab, selectedTab: $selectedTab, animation: animation)
                            .padding()
                        Spacer()
                    }
                }
                .padding(.bottom, 15)
                .background(Color("bgColor").opacity(0.9))
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .background(Color.black.opacity(0.6).ignoresSafeArea(.all, edges: .all))
        }
    }
}

struct TabButton: View {
    var title: String
    @Binding var selectedTab: String
    var animation: Namespace.ID
    var body: some View {
        Button {
            withAnimation{selectedTab = title}
        } label: {
            VStack(spacing: 6) {
                
                ZStack {
                    CustomShape()
                        .fill(Color.clear)
                        .frame(width: 45, height: 6)
                    
                    if selectedTab == title {
                        CustomShape()
                            .fill(Color("tint"))
                            .frame(width: 45, height: 6)
                            .matchedGeometryEffect(id: "", in: animation)
                    }
                }
                .padding(.bottom, 10)
                
                Image(title)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(selectedTab == title ? Color("tint") : Color.white.opacity(0.2))
                    .frame(width: 24, height: 24)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(selectedTab == title ? Color("tint") : Color.white.opacity(0.2))
            }
        }
        
    }
}

struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        
        return Path(path.cgPath)
    }
}

var tabs = ["Coins", "Prediction"]
