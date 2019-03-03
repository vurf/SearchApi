//
//  TapImageDelegate.swift
//  SearchApi
//
//  Created by i.varfolomeev on 03/03/2019.
//  Copyright © 2019 i.varfolomeev. All rights reserved.
//

import Foundation
import UIKit

protocol TapImageDelegate: AnyObject {
    
    func didTapImageView(_ sender: UIImageView, url: String)
}
