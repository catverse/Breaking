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
                GeometryReader {
                    RoundedRectangle(cornerRadius: 5, style: .circular)
                        .foregroundColor(.secondary)
                        .frame(width: $0.size.width * 0.8, height: 10)
                    Spacer()
                }
            }.padding(.top, 20)
            HStack {
                GeometryReader {
                    RoundedRectangle(cornerRadius: 5, style: .circular)
                        .foregroundColor(.secondary)
                        .frame(width: $0.size.width * 0.2, height: 10)
                    Spacer()
                }
            }.padding(.top, 5)
            HStack {
                GeometryReader {
                    RoundedRectangle(cornerRadius: 5, style: .circular)
                        .foregroundColor(.secondary)
                        .frame(width: $0.size.width * 0.6, height: 10)
                    Spacer()
                }
            }.padding(.top, 5)
            HStack {
                GeometryReader {
                    RoundedRectangle(cornerRadius: 5, style: .circular)
                        .foregroundColor(.secondary)
                        .frame(width: $0.size.width * 0.4, height: 10)
                    Spacer()
                }
            }.padding(.init(top: 5, leading: 0, bottom: 30, trailing: 0))
        }.opacity(0.3)
    }
}
