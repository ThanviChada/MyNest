import SwiftUI

// MARK: - Comment Model
struct Comment: Identifiable {
    let id = UUID()
    let author: String
    let text: String
    let timestamp: String
    let isCurrentUser: Bool
}

// MARK: - Post Model
struct Post: Identifiable {
    let id = UUID()
    let userName: String
    let postType: PostType
    let item: String
    let category: String
    let quantity: String
    let location: String
    let date: String
    let time: String
    let message: String
    var comments: [Comment]
    
    enum PostType: String, CaseIterable {
        case donation = "Donation"
        case request = "Request"
    }
    
    var dateTime: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy h:mm a"
        return formatter.date(from: "\(date) \(time)")
    }
}

// MARK: - Sample Data
let samplePosts: [Post] = [
    Post(
        userName: "Thanvi Chada",
        postType: .donation,
        item: "Winter Jacket",
        category: "Clothing",
        quantity: "2",
        location: "Community Center",
        date: "May 29, 2026",
        time: "6:00 PM",
        message: "Category: Clothes\nWinter Clothes - \"Winter Jacket\"\n(Qty: 2)",
        comments: [
            Comment(
                author: "Ava Johnson",
                text: "Hi! Is this still available?",
                timestamp: "May 29, 2026 at 7:15 PM",
                isCurrentUser: false
            )
        ]
    )
]

// MARK: - Comment Section
struct CommentSection: View {
    @State private var newComment = ""
    @Binding var comments: [Comment]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(comments) { comment in
                VStack(alignment: comment.isCurrentUser ? .trailing : .leading, spacing: 4) {
                    Text("\(comment.author) • \(comment.timestamp)")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    
                    Text(comment.text)
                        .font(.subheadline)
                        .padding(10)
                        .background(comment.isCurrentUser ? Color.blue.opacity(0.85) : Color.gray.opacity(0.18))
                        .foregroundColor(comment.isCurrentUser ? .white : .black)
                        .cornerRadius(12)
                }
                .frame(maxWidth: .infinity, alignment: comment.isCurrentUser ? .trailing : .leading)
            }
            
            HStack {
                TextField("Add a comment...", text: $newComment)
                    .textFieldStyle(.roundedBorder)
                
                Button("Post") {
                    if !newComment.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
                        
                        let userComment = Comment(
                            author: "You",
                            text: newComment,
                            timestamp: formatter.string(from: Date()),
                            isCurrentUser: true
                        )
                        
                        comments.append(userComment)
                        newComment = ""
                    }
                }
            }
        }
        .padding(.top, 8)
    }
}

// MARK: - Post Card
struct PostCard: View {
    @State var post: Post
    @State private var showComments = false
    
    private var badgeColor: Color {
        post.postType == .donation
        ? Color(red: 0.47, green: 0.69, blue: 0.19)
        : Color(red: 0.13, green: 0.49, blue: 0.69)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 3) {
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
            
            Text(post.postType.rawValue)
                .font(.caption)
                .fontWeight(.bold)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(badgeColor.opacity(0.15))
                .foregroundColor(badgeColor)
                .cornerRadius(10)
            
            Text(post.message)
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
            
            Text("Location: \(post.location)")
                .font(.caption)
                .foregroundColor(.blue)
            
            Text("Date: \(post.date) • Time: \(post.time)")
                .font(.caption)
                .foregroundColor(.blue)
            
            HStack {
                Spacer()
                
                Button("Comment") {
                    withAnimation {
                        showComments.toggle()
                    }
                }
                .font(.caption)
            }
            
            if showComments {
                CommentSection(comments: $post.comments)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Main Discussion Screen
struct DiscussionScreen: View {
    
    @State private var goHome = false
    @State private var goProgress = false
    @State private var goSettings = false
    
    @State private var typeFilter: String = "All"
    @State private var locationFilter: String = "All"
    @State private var categoryFilter: String = "All"
    @State private var quantityFilter: String = "All"
    
    @State private var enableDateTimeFilter = false
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    
    @State private var showFilters = false
    
    private let primaryBlue = Color(red: 0.13, green: 0.49, blue: 0.69)
    private let accentGreen = Color(red: 0.47, green: 0.69, blue: 0.19)
    
    private let lightTabColor = Color(red: 0.17, green: 0.60, blue: 0.80)
    
    private let typeOptions = ["All", "Donation", "Request"]
    
    private let locationOptions = [
        "All",
        "Eden Prairie High School",
        "Central Middle School",
        "Oak Point Elementary School",
        "Community Center",
        "Target"
    ]
    
    private let categoryOptions = [
        "All",
        "Clothing",
        "School Supplies",
        "Toys",
        "Food"
    ]
    
    private let quantityOptions = [
        "All",
        "1",
        "2",
        "3",
        "4",
        "5+"
    ]
    
    private var filteredPosts: [Post] {
        samplePosts.filter { post in
            let matchesType = typeFilter == "All" || post.postType.rawValue == typeFilter
            let matchesLocation = locationFilter == "All" || post.location == locationFilter
            let matchesCategory = categoryFilter == "All" || post.category == categoryFilter
            let matchesQuantity = quantityFilter == "All" || post.quantity == quantityFilter
            
            let matchesDateTime: Bool = {
                if !enableDateTimeFilter { return true }
                guard let postDate = post.dateTime else { return false }
                
                let calendar = Calendar.current
                let selectedDay = calendar.startOfDay(for: selectedDate)
                let postDay = calendar.startOfDay(for: postDate)
                
                let selectedHour = calendar.component(.hour, from: selectedTime)
                let postHour = calendar.component(.hour, from: postDate)
                
                return selectedDay == postDay && selectedHour == postHour
            }()
            
            return matchesType && matchesLocation && matchesCategory && matchesQuantity && matchesDateTime
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.93, green: 0.96, blue: 0.90),
                        Color(red: 0.88, green: 0.94, blue: 0.95)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Discussion Board")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(primaryBlue)
                            
                            Text("See offers and requests from your community.")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "person.3.fill")
                            .font(.system(size: 30))
                            .foregroundColor(accentGreen)
                            .padding(.trailing, 4)
                        
                        Button {
                            showFilters = true
                        } label: {
                            HStack(spacing: 6) {
                                Text("Filters")
                            }
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.vertical, 6)
                            .padding(.horizontal, 10)
                            .background(Color.white)
                            .cornerRadius(14)
                            .shadow(color: .black.opacity(0.08), radius: 3, x: 0, y: 2)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.95))
                    .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 3)
                    
                    ScrollView {
                        VStack(spacing: 15) {
                            if filteredPosts.isEmpty {
                                Text("No posts match your filters.")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                    .padding(.top, 40)
                            } else {
                                ForEach(filteredPosts) { post in
                                    PostCard(post: post)
                                }
                            }
                        }
                        .padding()
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            goSettings = true
                        } label: {
                            VStack(spacing: 4) {
                                Text("Settings")
                                    .font(.custom("Instrument Sans", size: 14).weight(.bold))
                            }
                            .foregroundColor(lightTabColor)
                        }
                        .buttonStyle(.plain)
                        
                        Spacer()
                        
                        Button {
                            goHome = true
                        } label: {
                            VStack(spacing: 4) {
                                Text("Home")
                                    .font(.custom("Instrument Sans", size: 14).weight(.bold))
                            }
                            .foregroundColor(lightTabColor)
                        }
                        .buttonStyle(.plain)
                        
                        Spacer()
                        
                        Button {
                            goProgress = true
                        } label: {
                            VStack(spacing: 4) {
                                Text("Progress")
                                    .font(.custom("Instrument Sans", size: 14).weight(.bold))
                            }
                            .foregroundColor(lightTabColor)
                        }
                        .buttonStyle(.plain)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
                }
            }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showFilters) {
                filterSheet
            }
            .navigationDestination(isPresented: $goHome) {
                HomeScreen(isNewUser: false)
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $goProgress) {
                ProgressScreen()
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $goSettings) {
                SettingScreen()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    private var filterSheet: some View {
        NavigationStack {
            Form {
                Section("Type") {
                    Picker("Type", selection: $typeFilter) {
                        ForEach(typeOptions, id: \.self) { type in
                            Text(type)
                        }
                    }
                }
                
                Section("Location") {
                    Picker("Location", selection: $locationFilter) {
                        ForEach(locationOptions, id: \.self) { location in
                            Text(location)
                        }
                    }
                }
                
                Section("Category") {
                    Picker("Category", selection: $categoryFilter) {
                        ForEach(categoryOptions, id: \.self) { category in
                            Text(category)
                        }
                    }
                }
                
                Section("Quantity") {
                    Picker("Quantity", selection: $quantityFilter) {
                        ForEach(quantityOptions, id: \.self) { quantity in
                            Text(quantity)
                        }
                    }
                }
                
                Section("Date & Time") {
                    Toggle("Filter by date & time", isOn: $enableDateTimeFilter)
                    
                    if enableDateTimeFilter {
                        DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                        DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    }
                }
            }
            .navigationTitle("Filters")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Clear") {
                        typeFilter = "All"
                        locationFilter = "All"
                        categoryFilter = "All"
                        quantityFilter = "All"
                        enableDateTimeFilter = false
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        showFilters = false
                    }
                }
            }
        }
    }
}

#Preview {
    DiscussionScreen()
}
