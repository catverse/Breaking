import Combine

final class NewsSubscription<T>: Subscription where T : Subscriber, T.Input == Set<Item> {
    var subscriber: T?

    func request(_ demand: Subscribers.Demand) { }
    
    func cancel() {
        subscriber = nil
    }
}
