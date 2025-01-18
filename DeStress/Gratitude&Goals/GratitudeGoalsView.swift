//
//  Gratitude&Goals.swift
//  DeStress
//
//  Created by Eva Madarasz


import SwiftUI

struct GratitudeGoalsView: View {
    @ObservedObject var viewModel = GratitudeGoalsViewModel()
    @State private var newGratitudeTitle = ""
    @State private var newGoalTitle = ""
    @State private var showSuccessAlert = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Gratitude Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Gratitude")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        LazyVStack(spacing: 8) {
                            ForEach(Array(viewModel.gratitudeItems.enumerated()), id: \.1.id) { index, item in
                                HStack {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                    Text(item.title)
                                    Spacer()
                                    Button(action: {
                                        deleteGratitude(at: IndexSet(integer: index))
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding()
                                .background(Color.purple.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                        
                        if viewModel.gratitudeItems.count > 3 {
                            Text("Showing only the first 3 items.")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("New Gratitude")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            TextEditor(text: $newGratitudeTitle)
                                .frame(height: 60)
                                .padding(4)
                                .background(Color(UIColor.secondarySystemBackground))
                                .cornerRadius(8)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            HStack {
                                Spacer()
                                Button(action: addNewGratitude) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                                .disabled(newGratitudeTitle.isEmpty || viewModel.gratitudeItems.count >= 3)
                            }
                        }
                        .padding(.top)
                    }
                    
                    // Goals Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Goals")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        LazyVStack(spacing: 8) {
                            ForEach(Array(viewModel.goalItems.enumerated()), id: \.1.id) { index, item in
                                HStack {
                                    GoalItemView(goal: item, toggleAchieved: {
                                        toggleAchieved(for: item)
                                    })
                                    Spacer()
                                    Button(action: {
                                        deleteGoals(at: IndexSet(integer: index))
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                        
                        if viewModel.goalItems.count > 3 {
                            Text("Showing only the first 3 items.")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("New Goal")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            TextEditor(text: $newGoalTitle)
                                .frame(height: 60)
                                .padding(4)
                                .background(Color(UIColor.secondarySystemBackground))
                                .cornerRadius(8)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            HStack {
                                Spacer()
                                Button(action: addNewGoal) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                                .disabled(newGoalTitle.isEmpty || viewModel.goalItems.count >= 3)
                            }
                        }
                        .padding(.top)
                    }
                }
                .padding()
            }
            .navigationBarTitle("Gratitude & Goals", displayMode: .inline)
            .background(Color("appBackground"))
            .alert(isPresented: $showSuccessAlert) {
                Alert(title: Text("🖐️ High Five!"),
                      message: Text("You can do anything you put your mind to."),
                      dismissButton: .default(Text("Got it!")))
            }
        }
    }
    
    // MARK: - Functions
    
    func deleteGratitude(at offsets: IndexSet) {
        offsets.forEach { index in
            viewModel.gratitudeItems.remove(at: index)
        }
    }
    
    func deleteGoals(at offsets: IndexSet) {
        offsets.forEach { index in
            viewModel.goalItems.remove(at: index)
        }
    }
    
    func addNewGratitude() {
        guard viewModel.gratitudeItems.count < 3 else { return }
        viewModel.gratitudeItems.append(GratitudeItem(title: newGratitudeTitle))
        newGratitudeTitle = ""
        showSuccessAlert = true
    }
    
    func addNewGoal() {
        guard viewModel.goalItems.count < 3 else { return }
        viewModel.goalItems.append(GoalItem(title: newGoalTitle))
        newGoalTitle = ""
        showSuccessAlert = true
    }
    
    func toggleAchieved(for goal: GoalItem) {
        if let index = viewModel.goalItems.firstIndex(where: { $0.id == goal.id }) {
            withAnimation {
                viewModel.goalItems[index].isAchieved.toggle()
            }
        }
    }
}

struct GratitudeGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GratitudeGoalsView()
    }
}

