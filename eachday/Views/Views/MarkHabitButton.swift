import SwiftUI

struct MarkHabitButton: View {
    let habit: HabitModel
    @State private var confirmCompletionReset: Bool = false
    
    var size = 38.0
    var innerSize = 30.0
    var cornerRadius = 6.0
    var innerCornerRadius = 4.0
    var today = Day.today()
    @Environment(\.colorScheme) var colorScheme
    
    var icon: String { habit.isCompleted(day: today)
        ? "arrow.uturn.backward"
        : "checkmark"
    }
    var iconColor: Color { colorScheme == .dark
        ? Color.white
        : habit.isCompleted(day: today) ? Color.white : Color.black
    }
    
    var body: some View {
        HStack(spacing: 6) {
            switch habit.frequency {
            case .daily(let times) where times > 1 && !habit.isCompleted(day: today):
                Text("\(habit.repetitionsToGo(day: today))").font(Font.system(size: 22).weight(.bold))
                Text("✕").font(Font.caption.weight(.bold))
            default:
                EmptyView()
            }
            
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .size(width: size, height: size)
                    .fill(Color(hex: colorScheme == .light ? "#F2F2F7" : "#000000"))
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .size(width: size, height: size)
                            .fill(habit.color.shade1)
                            .overlay {
                                if habit.isCompleted(day: today) {
                                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                                        .size(width: size, height: size)
                                        .fill(habit.color.shade5)
                                }
                            }
                    }
                
                if !habit.isCompleted(day: today) && habit.habitTasks.count > 1 {
                    PaintArcs(habit.habitTasks.count, outOf: habit.habitTasks.count)
                        .fill(habit.color.shade3)
                        .frame(width: size, height: size)
                        .cornerRadius(cornerRadius)
                        .clipped()
                    PaintArcs(habit.repetitionCompletedTasks(day: today).count, outOf: habit.habitTasks.count)
                        .fill(habit.color.shade5)
                        .frame(width: size, height: size)
                        .cornerRadius(cornerRadius)
                        .clipped()
                    PaintSquare(size: innerSize)
                        .fill(Color(Color(hex: colorScheme == .light ? "#F2F2F7" : "#000000")))
                        .frame(width: innerSize, height: innerSize)
                        .cornerRadius(innerCornerRadius)
                    PaintSquare(size: innerSize)
                        .fill(habit.color.shade1)
                        .frame(width: innerSize, height: innerSize)
                        .cornerRadius(innerCornerRadius)
                }

                Image(systemName: icon)
                    .resizable()
                    .frame(width: 14, height: 14)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(iconColor)
            }
            .frame(width: size, height: size)
            .onTapGesture {
                let impactHeavy = UIImpactFeedbackGenerator(style: .rigid); impactHeavy.impactOccurred()
                if habit.isCompleted(day: today) {
                    confirmCompletionReset.toggle()
                } else {
                    habit.markNextTask(day: today)
                    habit.save()
                }
            }
        }
        .confirmationDialog(
            "Are you sure you want to reset completion for habit - \"\(habit.name)\"?",
            isPresented: $confirmCompletionReset,
            titleVisibility: .visible
        ) {
            Button("Reset Completion", role: .destructive) { habit.unmarkDay(day: today); habit.save() }
            Button("Cancel", role: .cancel) { }
        }
    }
}

struct PaintArcs: Shape {
    var n: Int
    var outOf: Int
    var gapRadius: Double
    var arcRadius: Double
    
    init(_ n: Int, outOf: Int) {
        self.n = n
        self.outOf = outOf
        self.gapRadius = 10.0
        self.arcRadius = (360.0 - gapRadius * Double(outOf)) / Double(outOf)
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            for i in 0..<n {
                let start = 270.0 + (gapRadius / 2.0) + Double(i) * (gapRadius + arcRadius)
                let end = start + arcRadius
                path.addArc(
                    center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.height,
                    startAngle: Angle(degrees: start),
                    endAngle: Angle(degrees: end),
                    clockwise: false
                )
                path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            }
        }
    }
}

struct PaintSquare: Shape {
    var size: Double
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX + (size / 2.0), y: rect.midY + (size / 2.0)))
            path.addLine(to: CGPoint(x: rect.midX + (size / 2.0), y: rect.midY - (size / 2.0)))
            path.addLine(to: CGPoint(x: rect.midX - (size / 2.0), y: rect.midY - (size / 2.0)))
            path.addLine(to: CGPoint(x: rect.midX - (size / 2.0), y: rect.midY + (size / 2.0)))
            path.addLine(to: CGPoint(x: rect.midX + (size / 2.0), y: rect.midY + (size / 2.0)))
        }
    }
}
