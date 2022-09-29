//
//  Messages.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 29/09/22.
//

import Foundation
import SwiftMessages

class Messages{
    
    static func showMessage(theme: Theme, title: String, body: String){
        
        // Instantiate a message view from the provided card view layout. SwiftMessages searches for nib
        // files in the main bundle first, so you can easily copy them into your project and make changes.
        let view = MessageView.viewFromNib(layout: .cardView)

        // Theme message elements with the warning style.
        view.configureTheme(theme)

        // Add a drop shadow.
        view.configureDropShadow()

        // Set message title, body, and icon. Here, we're overriding the default warning
        // image⚠️ with an emoji character.
        
        var iconText = ""
        switch theme {
        case .info:
            iconText = "❕"
        case .success:
            iconText = "✅"
        case .warning:
            iconText = "⚠️"
        case .error:
            iconText = "❌"
        }
        
        
        view.configureContent(title: title, body: body, iconText: iconText)

        // Increase the external margin around the card. In general, the effect of this setting
        // depends on how the given layout is constrained to the layout margins.
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        
        view.button?.isHidden = true

        // Show the message.
        SwiftMessages.show(view: view)
    }
    
}

