import SwiftUI

struct Empty: View {
    var body: some View {
        VStack {
            GeometryReader { g in
                HStack {
                    RoundedRectangle(cornerRadius: 2.5, style: .circular)
                        .foregroundColor(.secondary)
                        .frame(width: g.size.width * 0.1, height: 5)
                    Spacer()
                    RoundedRectangle(cornerRadius: 2.5, style: .circular)
                        .foregroundColor(.secondary)
                        .frame(width: g.size.width * 0.1, height: 5)
                }
            }
            GeometryReader { g in
                HStack {
                    RoundedRectangle(cornerRadius: 5, style: .circular)
                        .foregroundColor(.secondary)
                        .frame(width: g.size.width * 0.8, height: 10)
                    Spacer()
                }
            }
            GeometryReader { g in
                HStack {
                    RoundedRectangle(cornerRadius: 5, style: .circular)
                        .foregroundColor(.secondary)
                        .frame(width: g.size.width * 0.2, height: 10)
                    Spacer()
                }
            }
            GeometryReader { g in
                HStack {
                    RoundedRectangle(cornerRadius: 5, style: .circular)
                        .foregroundColor(.secondary)
                        .frame(width: g.size.width * 0.6, height: 10)
                    Spacer()
                }
            }
            GeometryReader { g in
                HStack {
                    RoundedRectangle(cornerRadius: 5, style: .circular)
                        .foregroundColor(.secondary)
                        .frame(width: g.size.width * 0.4, height: 10)
                    Spacer()
                }
            }
        }.padding(.vertical, 20)
            .opacity(0.3)
    }
}
