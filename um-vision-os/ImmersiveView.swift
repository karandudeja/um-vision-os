import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var body: some View {
        RealityView { content in
            if let skyBox360 = createSkybox(){
                content.add(skyBox360)
            }
            else {
                print("Failed to create skybox.")
            }
        }
    }
    
    private func createSkybox() -> Entity? {
        let skyboxEntity = Entity()
        let largeSphere = MeshResource.generateSphere(radius: 4)
        var skyboxMaterial = UnlitMaterial()
        
        do{
            let texture = try TextureResource.load(named: "Cafe1")
            skyboxMaterial.color = .init(texture: .init(texture))
        }
        catch{
            print("Failed to create skybox: \(error)")
            return nil
        }
        
        skyboxEntity.components.set(ModelComponent(mesh: largeSphere, materials: [skyboxMaterial]))
        
        skyboxEntity.scale = .init(x: -1, y:1, z:1)
        
        return skyboxEntity
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
}
