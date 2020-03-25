import SwiftUI

struct Empty: View {
    var body: some View {
        VStack {
            HStack {
                RoundedRectangle(cornerRadius: 2.5, style: .circular)
                    .foregroundColor(.secondary)
                    .frame(width: 40, height: 5)
                Spacer()
                RoundedRectangle(cornerRadius: 2.5, style: .circular)
                    .foregroundColor(.secondary)
                    .frame(width: 40, height: 5)
            }.padding(.top, 10)
            HStack {
                RoundedRectangle(cornerRadius: 5, style: .circular)
                    .foregroundColor(.secondary)
                    .frame(width: 300, height: 10)
                Spacer()
            }.padding(.top, 20)
            HStack {
                RoundedRectangle(cornerRadius: 5, style: .circular)
                    .foregroundColor(.secondary)
                    .frame(width: 120, height: 10)
                Spacer()
            }.padding(.top, 5)
            HStack {
                RoundedRectangle(cornerRadius: 5, style: .circular)
                    .foregroundColor(.secondary)
                    .frame(width: 250, height: 10)
                Spacer()
            }.padding(.top, 5)
            HStack {
                RoundedRectangle(cornerRadius: 5, style: .circular)
                    .foregroundColor(.secondary)
                    .frame(width: 180, height: 10)
                Spacer()
            }.padding(.init(top: 5, leading: 0, bottom: 30, trailing: 0))
        }.opacity(0.3)
    }
}
