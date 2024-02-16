//
//  Custom.swift
//
//
//  Created by Vincent Chiang on 2024/2/16.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.green, lineWidth: 3)
        ).padding()
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
