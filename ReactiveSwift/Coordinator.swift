import Foundation
import UIKit

protocol Coordinator {
    func start()
}

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MainViewModel(client: APIClient())
        let vc = MainViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
