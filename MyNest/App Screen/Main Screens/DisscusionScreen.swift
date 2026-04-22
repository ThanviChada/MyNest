import SwiftUI

struct DiscussionScreen: View {
    var body: some View {
        VStack(spacing: 0) {
            
            // Header
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Discussion\nBoard")
                        .font(.system(size: 42, weight: .bold))
                        .foregroundColor(Color(red: 0.49, green: 0.22, blue: 0.13))
                    
                    Spacer()
                    
                    Image(systemName: "person.3.fill")
                        .font(.system(size: 30))
                }
                
                HStack {
                    Text("Posts")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.49, green: 0.22, blue: 0.13))
                    
                    Spacer()
                    
                    Image(systemName: "gearshape.fill")
                        .padding(8)
                        .background(Color.blue.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding()
            .background(Color.white)
            
            // Content
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Post Card
                    VStack(alignment: .leading, spacing: 10) {
                        
                        HStack(alignment: .top) {
                            
                            Circle()
                                .stroke(Color.green, lineWidth: 3)
                                .frame(width: 70, height: 70)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Item")
                                    .foregroundColor(.orange)
                                    .fontWeight(.bold)
                                
                                Text("Category")
                                Text("Location")
                                Text("Pick-up time")
                            }
                            .foregroundColor(Color.blue)
                            .font(.subheadline)
                            
                            Spacer()
                            
                            Text("Date")
                                .foregroundColor(Color.blue)
                                .font(.caption)
                        }
                        
                        Text("Name")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                        
                        // ✅ FIXED connect button
                        HStack {
                            Spacer()
                            
                            HStack(spacing: 5) {
                                Image(systemName: "plus")
                                Text("connect")
                            }
                            .foregroundColor(Color.green)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 3)
                    
                    // Placeholder cards
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .frame(height: 150)
                        .shadow(radius: 3)
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .frame(height: 150)
                        .shadow(radius: 3)
                }
                .padding()
            }
            
            // ✅ ADD navigation bar to screen
            NavigationBar()
        }
        .background(Color(red: 0.90, green: 0.94, blue: 0.95))
    }
}

// Bottom Navigation
struct NavigationBar: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Setting")
            Spacer()
            
            Divider().frame(height: 20)
            
            Spacer()
            Text("Home")
            Spacer()
            
            Divider().frame(height: 20)
            
            Spacer()
            Text("Progress")
            Spacer()
        }
        .font(.system(size: 18, weight: .bold))
        .foregroundColor(Color(red: 0.17, green: 0.60, blue: 0.80))
        .frame(height: 55) // 👈 slightly smaller
        .background(Color.white)
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.bottom, 8)
        .shadow(radius: 3)
    }
}

#Preview {
    DiscussionScreen()
}
