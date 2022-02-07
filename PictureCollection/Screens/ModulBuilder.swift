//
//  ModulBuilder.swift
//  PictureCollection
//
//  Created by Артем Вишняков on 03.02.2022.
//

import Foundation
import UIKit

protocol AssemblerProtocol {
    func createMainScreen(router: RouterProtocol) -> UIViewController
}
