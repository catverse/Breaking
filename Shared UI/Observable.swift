import Foundation

final class Observable: ObservableObject {
    @Published var articles = [Item]()
    
    init() {
        
    }
}
