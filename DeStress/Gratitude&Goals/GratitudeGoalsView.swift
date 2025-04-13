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
                VStack(alignment: .leading, spacing: 20) {
                    SectionView(title: "Gratitude", items: viewModel.gratitudeItems, newTitle: $newGratitudeTitle, addAction: addNewGratitude, deleteAction: deleteGratitude)
                    SectionView(title: "Goals", items: viewModel.goalItems, newTitle: $newGoalTitle, addAction: addNewGoal, deleteAction: deleteGoals, isGoal: true)
                }
                .padding()
            }
            .navigationBarTitle("Gratitude & Goals", displayMode: .inline)
            .background(
                backgroundColorView()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all))
            
            .alert(isPresented: $showSuccessAlert) {
                Alert(title: Text("🖐️ High Five!"),
                      message: Text("You can do anything you put your mind to."),
                      dismissButton: .default(Text("Got it!")))
            }
        }
    }
    
    // MARK: - Functions
    
    func deleteGratitude(at offsets: IndexSet) {
        viewModel.gratitudeItems.remove(atOffsets: offsets)
    }
    
    func deleteGoals(at offsets: IndexSet) {
        viewModel.goalItems.remove(atOffsets: offsets)
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
}

struct SectionView<T: Identifiable>: View {
    let title: String
    let items: [T]
    @Binding var newTitle: String
    let addAction: () -> Void
    let deleteAction: (IndexSet) -> Void
    var isGoal: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            LazyVStack(spacing: 8) {
                ForEach(Array(items.enumerated()), id: \ .1.id) { index, item in
                    HStack {
                        Image(systemName: isGoal ? "checkmark.circle" : "heart.fill")
                            .foregroundColor(isGoal ? .green : .red)
                        Text((item as? GratitudeItem)?.title ?? (item as? GoalItem)?.title ?? "")
                        Spacer()
                        Button(action: {
                            deleteAction(IndexSet(integer: index))
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                    .background(Color.purple.opacity(0.15))
                    .cornerRadius(8)
                }
            }
            
            if items.count > 3 {
                Text("Showing only the first 3 items.")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading) {
                Text("New \(title)")
                    .font(.title2)
                    .foregroundColor(.white)
                TextEditor(text: $newTitle)
                    .frame(height: 70)
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
                    Button(action: addAction) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .disabled(newTitle.isEmpty || items.count >= 3)
                }
            }
            .padding(.top)
        }
    }
}

struct GratitudeGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GratitudeGoalsView()
    }
}
