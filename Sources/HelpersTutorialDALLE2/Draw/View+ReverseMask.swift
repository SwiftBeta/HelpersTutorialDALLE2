//
//  View+ReverseMask.swift
//  OpenAI
//
//  Created by Home on 5/11/22.
//

import Foundation
import SwiftUI

extension View {
  public func reverseMask<Mask: View>(@ViewBuilder _ mask: () -> Mask) -> some View {
    self.mask {
      Rectangle()
            .overlay(alignment: .center) {
                mask()
                    .blendMode(.destinationOut)
            }
        }
    }
}
