//
//  ContentView.swift
//  tic-tac-toe
//
//  Created by WHGNR-1671 on 28/06/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                
                Text("Player A")
                Spacer()
            }
            
            Box()
            
            HStack {
                Spacer()
                Text("Player B")
            }
            Spacer()
        }
        .frame(width: 300)
    }
}
struct Box: View {
    
    @State private var chance: [Int] = Array(repeating: 2, count: 9)
    @State private var num = 0
    private var winOptions = [[0,1,2],[0,3,6],[0,4,8],[1,4,7],[2,5,8],[2,4,6],[3,4,5],[6,7,8]]
    @State private var showsAlert = false
    @State private var alert: String = ""

    var body: some View {
        VStack(spacing: 5) {
            ForEach(0..<3) { i in
                HStack(spacing: 5) {
                    ForEach(0..<3) { k in
                        
                        Button(action: {
                            chance[3*i+k] = (num % 2 == 0 ? 0 : 1)
                            num = num + 1
                            if num == 9 {
                                alert = "Draw"
                                showsAlert = true
                            }
                            if checkWinCondition() == true {
                                if num % 2 == 0 {
                                              alert = "Player O won"
                                            }
                                            else {
                                                    alert = "Player X won"
                                            }
                                showsAlert = true
                            }
                           
                            
                        })
                        {
                            VStack {
                                if chance[3*i+k] == 0 { Cross() }
                                else { Circle()}
                            }
                            .frame(width: 80, height: 80)
                            .opacity(chance[3*i+k] == 2 ? 0 : 1)
                            
                        }
                        .disabled(chance[3*i+k] == 2 ? false : true)
                        .background(Color.white)
                        
                    }
                }
            }
        }
        .background(Color.black)
        .alert(isPresented: self.$showsAlert) {
            Alert(title:Text(alert), dismissButton: Alert.Button.default(
                Text("OK"), action: {
                    chance = Array(repeating: 2, count: 9)
                    num = 0
                    showsAlert = false
                    alert = ""
                    
                }
            ))
    }
    }
    func checkWinCondition() -> Bool {
        for i in winOptions{
                        if chance[i[0]] != 2 && chance[i[0]] == chance[i[1]] && chance[i[1]] == chance[i[2]]{
                            return true
                        }
                
        }
      return false
       }
}
struct Circle: View {
    
    var body: some View {
        Ellipse()
            .stroke(
                Color.black.opacity(0.4),
                lineWidth: 3
            )
            .frame(width: 20, height: 20)
        
    }
}

struct Cross: View {
    
    var body: some View {
        Image("x")
            .resizable()
            .frame(width: 20, height: 20)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
