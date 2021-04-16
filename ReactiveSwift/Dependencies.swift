import Foundation
import Reachability

protocol ReachabilityProtocol {
    func startNotifier() throws
    func stopNotifier()
    var connection: Reachability.Connection { get }
}

extension Reachability: ReachabilityProtocol {}
