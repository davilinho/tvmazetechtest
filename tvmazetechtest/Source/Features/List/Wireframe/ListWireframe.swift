//
//  ListWireframe.swift
//  tvmazetechtest
//
//  Created by David Martin on 17/11/21.
//

import UIKit

class ListWireframe: Wireframe, InjectableComponent {
    typealias Destination = ListDestination

    enum ListDestination: WireframeDestination {
        case detail(by: Int)
    }
}

extension Wireframe where Destination == ListWireframe.ListDestination {
    func navigate(to: Destination, with navigationController: UINavigationController?) {
        if case let .detail(id) = to {
            let storyboard = UIStoryboard(name: "Detail", bundle: Bundle.main)
            guard let viewController = storyboard.instantiateInitialViewController() as? DetailViewController else { return }
            viewController.id = id
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
