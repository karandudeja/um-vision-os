import SwiftUI
import RealityKit
import RealityKitContent

struct PizzaView: View {
    var body: some View {
        Model3D(named: "Pizza") { model in
            model
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:500, height:300)
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    PizzaView()
}
