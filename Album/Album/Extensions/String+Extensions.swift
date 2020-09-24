//
//  String+Extensions.swift
//  Album
//
//  Created by Danya on 9/21/20.
//  Copyright © 2020 Danya. All rights reserved.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
