import SwiftUI

struct FilterView: View {
    var iconName:String
    var iconLabel:String
    @Binding var isOn: Bool
    //let style:Styles

    var body: some View {
        ZStack{
            HStack{
                Image(iconName)
                    .resizable()
                    .frame(width:48, height:48)
                    .padding(.trailing, 4)
                Text(iconLabel)
                    .fontWeight(.medium)
                    .font(.system(size: 24))
                    .padding(.trailing, 8)
            }
            .padding()
            //.background(isOn ? Color(red:0, green:0, blue:0, opacity: 0) : Color(red:0, green:0, blue:0, opacity: 0))
        }
        .onTapGesture {
            self.isOn.toggle()
        }
        
    }
}

/*
#Preview {
    FilterView(iconName: "icon-badge", iconLabel: "Top Rated", isOn: true)
}
*/
