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
                .stroke(Color.black, lineWidth: 3)
        ).padding(.horizontal)
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

struct TextColor_BW: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .foregroundStyle(colorScheme == .dark ? .white : .white)
    }
}

struct BackgroundColor_BW: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .background(colorScheme == .dark ? .white : .white)
    }
}

extension View {
    func WB() -> Color{
        @Environment(\.colorScheme) var colorScheme
        if colorScheme == .dark {
            return .white
        }else{
            return .black
        }
    }
}

