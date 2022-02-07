//
//  Router.swift
//  PictureCollection
//
//  Created by Артем Вишняков on 03.02.2022.
//

import Foundation

protocol RouterMain {
    var assemblyBuilder: AssemblerProtocol? { get }
}

protocol RouterProtocol: RouterMain {
    func showMainScreen()
}

Class 
