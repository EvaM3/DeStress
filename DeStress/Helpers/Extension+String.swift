//
//  Extension+String.swift
//  DeStress
//
//  Created by Eva Sira Madarasz on 05/11/2024.
//

import SwiftUI

extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
