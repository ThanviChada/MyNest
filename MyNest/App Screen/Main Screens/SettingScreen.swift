import SwiftUI

struct SettingScreen: View {
  var body: some View {
    ZStack() {
      Group {
        Text("Settings ")
          .font(Font.custom("Instrument Sans", size: 50).weight(.bold))
          .foregroundColor(.black)
          .offset(x: 1, y: -300)
      
          Text("Account ")
          .font(Font.custom("Instrument Sans", size: 27).weight(.medium))
          .foregroundColor(.black)
          .offset(x: -45, y: -136)
     
          Image("person")
              .resizable()
              .scaledToFit()
              .frame(width: 100)
              .offset(x: -150, y: -130)
          
    
          

       
          Text("Help and Support")
          .font(Font.custom("Instrument Sans", size: 27).weight(.medium))
          .foregroundColor(.black)
          .offset(x: -45, y: 1)
      }
        Group
        {
        Text("About")
          .font(Font.custom("Instrument Sans", size: 23).weight(.medium))
          .foregroundColor(.black)
          .offset(x: -82, y: 176)
        Text("Logout")
          .font(Font.custom("Instrument Sans", size: 23).weight(.medium))
          .foregroundColor(.black)
          .offset(x: -77.50, y: 241)
        
            
            Text("Notifications")
          .font(Font.custom("Instrument Sans", size: 23).weight(.medium))
          .foregroundColor(.black)
          .offset(x: -47.50, y: -58)
            
            Image("bell")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .offset(x: -150, y: -55)
        
           
       
            
        Text("Setting")
          .font(Font.custom("Instrument Sans", size: 22).weight(.bold))
          .foregroundColor(Color(red: 0.17, green: 0.60, blue: 0.80))
          .offset(x: -119, y: 400.50)
        Text("Home")
          .font(Font.custom("Instrument Sans", size: 22).weight(.bold))
          .foregroundColor(Color(red: 0.17, green: 0.60, blue: 0.80))
          .offset(x: 22, y: 401.50)
        Text("Progress")
          .font(Font.custom("Instrument Sans", size: 20).weight(.bold))
          .foregroundColor(Color(red: 0.17, green: 0.60, blue: 0.80))
          .offset(x: 131, y: 401.50)
      
      }
    }
    .frame(width: 402, height: 874)
    .background(Color(red: 0.93, green: 0.93, blue: 0.93));
  }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen()
    }
}
