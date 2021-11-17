//
//  Wireframe.swift
//  tvmazetechtest
//
//  Created by David Martin on 17/11/21.
//

import UIKit

protocol WireframeDestination {}

protocol Wireframe: AnyObject {
    associatedtype Destination: WireframeDestination
    func navigate(to: Destination, with navigationController: UINavigationController?)
}
