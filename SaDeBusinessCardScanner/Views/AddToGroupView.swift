import SwiftUI
import SwiftData

struct AddToGroupView: View {
    var card: Card
    @Query var groups: [Group]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var selectedGroup: Group?
    @State private var newGroupName = ""
    @State private var showNewGroupField = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Select a group")) {
                    ForEach(groups) { group in
                        Button(action: {
                            selectedGroup = group
                        }) {
                            HStack {
                                Text(group.name)
                                Spacer()
                                if selectedGroup == group {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                }
                Button(action: {
                    showNewGroupField.toggle()
                }) {
                    Section(header: Text("Create New Group").foregroundStyle(.secondaryC)) {
                        if showNewGroupField {
                            TextField("New Group Name", text: $newGroupName)
                        }
                    }
                }
            }
            .navigationTitle("Add to Group")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        if let selectedGroup = selectedGroup {
                            addCardToGroup(selectedGroup)
                        } else if !newGroupName.isEmpty {
                            createNewGroupAndAddCard()
                        }
                        dismiss()
                    }
                    .disabled(selectedGroup == nil && newGroupName.isEmpty)
                }
            }
        }
    }
    
    private func addCardToGroup(_ group: Group) {
        group.cards.append(card)
        card.group = group
        try? modelContext.save()
    }
    
    private func createNewGroupAndAddCard() {
        let newGroup = Group(name: newGroupName)
        modelContext.insert(newGroup)
        addCardToGroup(newGroup)
    }
}
