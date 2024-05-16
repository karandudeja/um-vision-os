//
//  um_vision_osApp.swift
//  um-vision-os
//
//  Created by DSV on 2024-05-16.
//

import SwiftUI

@main
struct um_vision_osApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
