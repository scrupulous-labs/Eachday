import SwiftUI

struct HabitDetailsSelectYear: View {
    var year: Year
    var onYearChange: (Year) -> Void
    
    var body: some View {
        HStack {
            Text(String(year.value))
                .font(Font.system(size: 24).weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            Button { onYearChange(year.prev) } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.black)
                    .fontWeight(.medium)
            }
            Spacer().frame(width: 26)
            Button { if year < Year.current() { onYearChange(year.next) } } label: {
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(year == Year.current() ? .gray : .black)
                    .fontWeight(.medium)
            }
        }
        .padding(.horizontal, 8)
    }
}
