import SwiftUI

struct HomeScreen: View {
    var body: some View {
        ZStack {
            Group {
                Text("Setting")
                    .font(Font.custom("Instrument Sans", size: 22).weight(.bold))
                    .foregroundColor(Color(red: 0.17, green: 0.60, blue: 0.80))
                    .offset(x: -120, y: 396.50)

                Text("Home")
                    .font(Font.custom("Instrument Sans", size: 22).weight(.bold))
                    .foregroundColor(Color(red: 0.17, green: 0.60, blue: 0.80))
                    .offset(x: 8.50, y: 397.50)

                Text("Progress")
                    .font(Font.custom("Instrument Sans", size: 22).weight(.bold))
                    .foregroundColor(Color(red: 0.17, green: 0.60, blue: 0.80))
                    .offset(x: 138, y: 397.50)

                Rectangle()
                    .frame(width: 59, height: 1)
                    .foregroundColor(Color.gray.opacity(0.7))
                    .offset(x: -34.50, y: 426)

                Rectangle()
                    .frame(width: 59, height: 1)
                    .foregroundColor(Color.gray.opacity(0.7))
                    .offset(x: 107.50, y: 426)
 
                Rectangle()
                    .frame(width: 410, height: 45)
                    .background(Color(red: 0.79, green: 0.85, blue: 0.72).opacity(0.76))
                    .overlay(
                        Rectangle()
                            .stroke(Color.black, lineWidth: 0.5)
                    )
                    .offset(x: 2, y: -418.50)
            }

            Group {
                Rectangle()
                    .frame(width: 76, height: 76)
                    .background(Color(red: 0.50, green: 0.23, blue: 0.27).opacity(0.50))
                    .offset(x: -142, y: 207)

                Rectangle()
                    .frame(width: 102.55, height: 92.68)
                    .background(Color(red: 0.50, green: 0.23, blue: 0.27).opacity(0.50))
                    .offset(x: 129.27, y: 209.34)

                Rectangle()
                    .frame(width: 95, height: 79)
                    .background(Color(red: 0.50, green: 0.23, blue: 0.27).opacity(0.50))
                    .offset(x: -5.50, y: 209.50)

                Text("Order")
                    .font(Font.custom("Abhaya Libre Medium", size: 20))
                    .offset(x: -136, y: 281.50)

                Text("Discuss")
                    .font(Font.custom("Abhaya Libre Medium", size: 20))
                    .offset(x: 137.50, y: 281.50)

                Text("Donate")
                    .font(Font.custom("Abhaya Libre Medium", size: 20))
                    .offset(x: 0, y: 281.50)

                Ellipse()
                    .frame(width: 330, height: 315)
                    .foregroundColor(Color(.systemGray6))
                    .offset(x: -5, y: -177.50)

                Rectangle()
                    .frame(width: 234, height: 211)
                    .background(Color(red: 0.50, green: 0.23, blue: 0.27).opacity(0.50))
                    .offset(x: 0, y: -181.50)

                Text("Hello, (name)!")
                    .font(Font.custom("Kumbh Sans", size: 35).weight(.semibold))
                    .offset(x: 13, y: 30.50)

                Text("What do you want to do today?")
                    .font(Font.custom("Instrument Sans", size: 17).weight(.bold))
                    .foregroundColor(Color.gray)
                    .offset(x: 6.50, y: 69)
            }
        }
        .frame(width: 402, height: 874)
        .background(Color.white)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
