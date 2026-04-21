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
            }

            Group {
               //order pic
                Image("order 1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .offset(x: -130, y: 200)
                
                //discussion pic
                Image("discussion")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                    .offset(x: 130, y: 200)
                
                //donate pic
                Image("donate")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .offset(x: 1, y: 200)

                Text("Order")
                    .font(Font.custom("Times New Roman", size: 30))
                    .offset(x: -130, y: 281.50)

                Text("Discuss")
                    .font(Font.custom("Times New Roman", size: 30))
                    .offset(x: 130, y: 280)

                Text("Donate")
                    .font(Font.custom("Times New Roman", size: 30))
                    .offset(x: 0, y: 281.50)

                Ellipse()
                    .frame(width: 330, height: 315)
                    .foregroundColor(Color(.systemGray6))
                    .offset(x: 1, y: -190)

                //logo pic
                Image("myNest_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 345)
                    .offset(x: -7, y: -190)

                Text("Hello, (name)!")
                    .font(Font.custom("Kumbh Sans", size: 35).weight(.semibold))
                    .offset(x: 13, y: 30.50)

                Text("What do you want to do today?")
                    .font(Font.custom("Times New Roman", size: 22).weight(.bold))
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
