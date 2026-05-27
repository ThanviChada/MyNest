import SwiftUI

// MARK: - Post Model
struct Post: Identifiable {
    let id = UUID()
    let userName: String
    let item: String
    let category: String
    let location: String
    let time: String
    let date: String
    let message: String
    var comments: [String]
}

// MARK: - Sample Data
let samplePosts: [Post] = [
    Post(
        userName: "Alex Johnson",
        item: "Desk Lamp",
        category: "Furniture",
        location: "Eden Prairie",
        time: "4 PM",
        date: "Today",
        message: "Category: Food Type: Protein",
        comments: ["Is this still available?", "Can pick up today!"]
    ),
    
    Post(
        userName: "Maya Patel",
        item: "Winter Jacket",
        category: "Clothing",
        location: "Minnetonka",
        time: "6 PM",
        date: "May 10",
        message: "Category: Clothes  Type: Winter Clothing",
        comments: []
    )
]

// MARK: - Comment Section
struct CommentSection: View {
    @State private var newComment = ""
    @Binding var comments: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            ForEach(comments, id: \.self) { comment in
                Text(comment)
                    .font(.subheadline)
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }
            
            HStack {
                TextField("Add a comment...", text: $newComment)
                    .textFieldStyle(.roundedBorder)
                
                Button("Post") {
                    if !newComment.isEmpty {
                        comments.append(newComment)
                        newComment = ""
                    }
                }
            }
        }
        .padding(.top, 8)
    }
}

// MARK: - Post Card (Compact Social Style)
struct PostCard: View {
    @State var post: Post
    @State private var showComments = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            // Header
            HStack(alignment: .top) {
                Circle()
                    .fill(Color.green.opacity(0.3))
                    .frame(width: 45, height: 45)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(post.userName)
                        .fontWeight(.bold)
                    
                    Text("\(post.item) • \(post.category)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text(post.date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            // Post Text
            Text(post.message)
                .font(.subheadline)
            
            // Location + pickup
            Text("📍 \(post.location) • ⏰ \(post.time)")
                .font(.caption)
                .foregroundColor(.blue)
            
            // Buttons row
            HStack {
                Button("➕ Connect") { }
                    .font(.caption)
                    .foregroundColor(.green)
                
                Spacer()
                
                Button("💬 Comment") {
                    withAnimation {
                        showComments.toggle()
                    }
                }
                .font(.caption)
            }
            
            // Expandable comments
            if showComments {
                CommentSection(comments: $post.comments)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}

// MARK: - Main Screen
struct DiscussionScreen: View {
    
    @State private var goHome = false
    @State private var goProgress = false
    
    var body: some View {
        NavigationStack {
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
                
                // Feed
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(samplePosts) { post in
                            PostCard(post: post)
                        }
                    }
                    .padding()
                }
                
                // Bottom Nav
                HStack {
                    Spacer()
                    Text("Setting")
                    Spacer()
                    
                    Text("Home")
                        .onTapGesture { goHome = true }
                    Spacer()
                    
                    Text("Progress")
                        .onTapGesture { goProgress = true }
                    Spacer()
                }
                .font(.system(size: 18))
                .foregroundColor(Color(red: 0.17, green: 0.60, blue: 0.80))
                .frame(height: 55)
                .background(Color.white)
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.bottom, 8)
                .shadow(radius: 3)
            }
            .background(Color(red: 0.90, green: 0.94, blue: 0.95))
            .navigationDestination(isPresented: $goHome) { HomeScreen(isNewUser: false) }
            .navigationDestination(isPresented: $goProgress) { ProgressScreen() }
        }
    }
}

// Preview
#Preview {
    DiscussionScreen()
}
