import SwiftUI

struct EditHabitSelectFrequency: View {
    var habit: HabitModel
    var onFieldChange: () -> Void
    var ui: EditHabitSelectFrequencyModel = EditHabitSelectFrequencyModel.instance

    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 0) {
            Text("HABIT FREQUENCY")
                .font(Font.subheadline.weight(.light))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 38, leading: 16, bottom: 16, trailing: 16))
                .background(Color(hex: colorScheme == .light ? "#F3F4F6" : "#000000"))

            ForEach(Array(0..<3), id: \.self) { ind in
                HStack {
                    Text(ui.frequencies[ind].uiText())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onTapGesture {
                            habit.frequency = ui.frequencies[ind]
                            onFieldChange()
                            dismiss()
                        }
                    
                    HStack(spacing: 16) {
                        Button { ui.frequencies[ind].decr() } label: {
                            Image(systemName: "minus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .foregroundColor(colorScheme == .light ? .black : .white)
                                .fontWeight(.medium)
                                .padding(9)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 25).stroke(
                                        colorScheme == .light ? Color(hex: "#1F2937") : .white,
                                        lineWidth: 0.25
                                    )
                                }
                        }
                        Button { ui.frequencies[ind].incr() } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .foregroundColor(colorScheme == .light ? .black : .white)
                                .fontWeight(.medium)
                                .padding(9)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 25).stroke(
                                        colorScheme == .light ? Color(hex: "#1F2937") : .white,
                                        lineWidth: 0.25
                                    )
                                }
                        }
                    }
                }
                .padding(.all)
                
                Divider()
            }
            Spacer()
        }
        .frame(maxHeight: .infinity)
    }
}

@Observable
class EditHabitSelectFrequencyModel {
    static var instance = EditHabitSelectFrequencyModel()
     
    var frequencies = [
        Frequency.daily(times: 1),
        Frequency.weekly(times: 1),
        Frequency.monthly(times: 1)
    ]
}
