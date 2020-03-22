import SwiftUI

struct Empty: View {
    var body: some View {
        VStack {
            HStack {
                RoundedRectangle(cornerRadius: 4, style: .circular)
                    .foregroundColor(.secondary)
                    .frame(width: 50, height: 8)
                Spacer()
                RoundedRectangle(cornerRadius: 4, style: .circular)
                    .foregroundColor(.secondary)
                    .frame(width: 50, height: 8)
            }.padding(.top, 10)
            HStack {
                RoundedRectangle(cornerRadius: 8, style: .circular)
                    .foregroundColor(.secondary)
                    .frame(width: 300, height: 16)
                Spacer()
            }.padding(.top, 20)
            HStack {
                RoundedRectangle(cornerRadius: 8, style: .circular)
                    .foregroundColor(.secondary)
                    .frame(width: 120, height: 16)
                Spacer()
            }
            HStack {
                RoundedRectangle(cornerRadius: 8, style: .circular)
                    .foregroundColor(.secondary)
                    .frame(width: 250, height: 16)
                Spacer()
            }
            HStack {
                RoundedRectangle(cornerRadius: 8, style: .circular)
                    .foregroundColor(.secondary)
                    .frame(width: 180, height: 16)
                Spacer()
            }.padding(.bottom, 30)
        }.opacity(0.7)
    }
}
