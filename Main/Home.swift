//
//  Home.swift
//
//
//  Created by Vincent Chiang on 2024/2/18.
//

import SwiftUI
import SwiftData
import TipKit

struct Home: View {
    @State var user: UserData
    @State var showadd: Bool = false
    @State var showedit: Bool = false
    @State private var refreshFlag = UUID()
    private let tip = addgoal()
    var body: some View {
        
        ZStack(alignment: .bottom){
            if user.Goal.isEmpty{
                HomePageEmpty(user: user)
            }else{
                let goal = user.Goal
                List {
                    Section{
                        QuoteView(user: user)
                            .listRowBackground(Color.black.opacity(0.2))
                    }
                    ForEach(goal.sorted(by: { $0.goal < $1.goal })) { index in
                        Section {
                            GoalDescribeGrid(goal: index)
                                .foregroundStyle(Color.black)
                                .listRowBackground(Color(white: 1, opacity: 0.3))
                        }
                    }
                    .onDelete { indexSet in
                        // Perform delete operation here
                        user.Goal.remove(atOffsets: indexSet)
                    }
                    .id(refreshFlag)
                }
                
            }
            Section{
                HStack{
                    Spacer()
                    Button(action:{
                        showadd = true
                    }){
                        ZStack{
                            Circle()
                                .foregroundStyle(.orange)
                                .frame(width: 70, height: 70)
                            Image(systemName: "plus")
                                .font(.system(size: 30))
                                .foregroundStyle(.white)
                                .bold()
                        }
                        
                    }.popoverTip(tip, arrowEdge: .top)
                        .onTapGesture {
                          tip.invalidate(reason: .actionPerformed)
                        }
                    Spacer()
                }/*
                  .background(
                      LinearGradient(colors: [.clear ,.white], startPoint: .top, endPoint: .bottom)
                          .blur(radius: 30)
                          .ignoresSafeArea()
                  )

                  */
            }
        }
        .scrollContentBackground(.hidden)
        .background(
            LinearGradient(colors: [.purple, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)
        )
        
        //.navigationTitle("Goal")
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Text("Goal")
                    .font(.title)
                    .bold()
            }
            ToolbarItem(placement: .topBarTrailing){
                Button(action:{
                    showedit.toggle()
                }){
                    Image(systemName: "person.circle")
                        .foregroundColor(.orange)
                        .font(.title2)
                }
            }
        }.navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showadd) {
            AddGoal(user: user)
                .presentationDetents([.medium])
                .presentationBackground(.thinMaterial)
        }
        .sheet(isPresented: $showedit) {
            UserInfo1(user: user)
                .presentationBackground(.thinMaterial)
        }
    }
}


