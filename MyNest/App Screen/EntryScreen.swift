import SwiftUI

struct  EntryScreen: View {
  var body: some View {
    ZStack() {
      Rectangle()
        .foregroundColor(.clear)
        .frame(width: 928.32, height: 403)
        .background(Color(red: 0.50, green: 0.23, blue: 0.27).opacity(0.50))
        .offset(x: 262.66, y: 692.82)
      Text("Create Account")
        .font(Font.custom("Instrument Sans", size: 25).weight(.bold))
        .foregroundColor(.white)
        .offset(x: 0, y: 151.50)
      Text("Sign -in")
        .font(Font.custom("Instrument Sans", size: 25).weight(.bold))
        .foregroundColor(.white)
        .offset(x: 1, y: 237.50)
      Rectangle()
        .foregroundColor(.clear)
        .frame(width: 262, height: 236)
        .background(Color(red: 0.50, green: 0.23, blue: 0.27).opacity(0.50))
        .offset(x: 0.50, y: -118)
    }
    .frame(width: 403, height: 874)
    .background(.white)
    .cornerRadius(3);
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
