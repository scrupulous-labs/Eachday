import SwiftUI

struct EditHabitSectionColor: View {
    let habit: Habit
    
    let ringColor = Color(hex: "#a3a3a3")
    let ringWidth = 4.0
    let ringRadiusMultiplier = 0.58
    let colorRadiusMultiplier = 0.42

    var body: some View {
        Section {
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 28), count: 6),
                spacing:32
            ) {
                ForEach(
                    [ HabitColor.blue,
                      HabitColor.red,
                      HabitColor.fuchsia,
                      HabitColor.rose,
                      HabitColor.orange,
                      HabitColor.emerald,
                      HabitColor.pink,
                      HabitColor.purple
                    ],
                    id: \.self
                ) { color in
                    let fillColor = color.shade500
                    ZStack {
                        GeometryReader { g in
                            let center = CGPoint(x: g.size.width * 0.5, y: g.size.height * 0.5)
                            let startAngle = Angle(degrees: 0)
                            let endAngle = Angle(degrees: 360)
                            
                            Path { path in
                                path.addArc(
                                    center: center,
                                    radius: g.size.width * colorRadiusMultiplier,
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: false
                                )
                            }
                            .fill(fillColor)

                            if habit.color == color {
                                Path { path in
                                    path.addArc(
                                        center: center,
                                        radius: g.size.width * ringRadiusMultiplier,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: false
                                    )
                                }
                                .stroke(ringColor, lineWidth: ringWidth)
                            }
                        }
                    }
                    .onTapGesture {
                        habit.color = color
                    }
                }
            }
            .padding(.vertical, 8)
        }
    }
}
