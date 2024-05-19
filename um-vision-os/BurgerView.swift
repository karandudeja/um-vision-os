import SwiftUI
import RealityKit
import RealityKitContent

struct BurgerView: View {
    var body: some View {
        Model3D(named: "Burger") { model in
            model
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:1000, height:500)
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    BurgerView()
}
