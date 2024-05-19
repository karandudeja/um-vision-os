import SwiftUI

struct SplashScreenView: View {
    
    var body: some View {
        VStack{
            Image("logo")
                .padding()
            Text("Restaurant App")
                .font(.title3)
        }
    }
}


#Preview {
    SplashScreenView()
}
