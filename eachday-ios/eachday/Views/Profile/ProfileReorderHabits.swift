import SwiftUI

struct ProfileReorderHabits: View {
    let dismiss: DismissAction
    let purchasePro: () -> Void
    @Bindable var ui = ProfileReorderHabitsModel.instance
    @Environment(\.colorScheme) var colorScheme
    @Environment(RootStore.self) var rootStore

    var body: some View {
        VStack(spacing: 0) {
            Picker("What is your favorite color?", selection: $ui.tab) {
                Text("Habits").tag(0)
                Text("Groups").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(EdgeInsets(top: -4, leading: 96, bottom: 10, trailing: 96))

            List {
                if ui.tab == 0 {
                    Section {
                        if rootStore.habits.sorted.isEmpty {
                            Text("No Habits")
                                .padding(.vertical, 32)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        
                        ForEach(rootStore.habits.sorted, id: \.id) { habit in
                            HStack {
                                Text(habit.name)
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                                    .padding(.leading, 10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Image(systemName: "line.3.horizontal")
                                    .resizable()
                                    .frame(width: 22, height: 11)
                                    .aspectRatio(contentMode: .fit)
                                    .symbolRenderingMode(.monochrome)
                                    .foregroundStyle(Color(hex: "#9CA3AF"))
                                    .fontWeight(.light)
                                    .frame(alignment: .trailing)
                                    .padding(.trailing, 2)
                            }
                        }
                        .onMove { offsets, to in
                            rootStore.habits.canMove(offsets: offsets, to: to)
                                ? rootStore.habits.moveHabit(offsets: offsets, to: to)
                                : purchasePro()
                        }
                    }
                }

                if ui.tab == 1 {
                    Section {
                        if rootStore.habitGroups.sorted.isEmpty {
                            Text("No groups")
                                .padding(.vertical, 32)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        ForEach(rootStore.habitGroups.sorted, id: \.id) { group in
                            HStack {
                                Text(group.name)
                                    .foregroundColor(!group.habitGroupItemsUI.isEmpty
                                        ? (colorScheme == .light ? .black : .white)
                                        : .gray
                                    )
                                    .padding(.leading, 10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Image(systemName: "line.3.horizontal")
                                    .resizable()
                                    .frame(width: 22, height: 11)
                                    .aspectRatio(contentMode: .fit)
                                    .symbolRenderingMode(.monochrome)
                                    .foregroundStyle(Color(hex: "#9CA3AF"))
                                    .fontWeight(.light)
                                    .frame(alignment: .trailing)
                                    .padding(.trailing, 2)
                            }
                        }
                        .onMove { rootStore.habitGroups.moveGroup(offsets: $0, to: $1) }
                    }
                }
            }
        }
        .navigationTitle("Reorder List")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(ui.hideBackButton)
        .toolbar {
            if ui.hideBackButton {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { dismiss() } label: { Text("Done") }
                }
            }
        }
        .onDisappear { ui.hideBackButton = false }
    }
}

@Observable
class ProfileReorderHabitsModel {
    static var instance: ProfileReorderHabitsModel = ProfileReorderHabitsModel()
    
    var tab: Int = 0
    var hideBackButton: Bool = false
    
    func selectHabits() {
        tab = 0
    }
    
    func selectGroups() {
        tab = 1
    }
    
    func reset() {
        tab = 0
    }
}
