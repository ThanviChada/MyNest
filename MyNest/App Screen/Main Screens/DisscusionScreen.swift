import SwiftUI

// MARK: - Post Model
struct Post: Identifiable {
    let id = UUID()
    let userName: String
    let item: String
    let category: String
    let location: String
    let time: String      // e.g. "4:00 PM"
    let date: String      // e.g. "May 27, 2026"
    let message: String
    var comments: [String]
    
    // Helper: combine date + time strings into a real Date
    var dateTime: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy h:mm a"
        return formatter.date(from: "\(date) \(time)")
    }
}

// MARK: - Sample Data
let samplePosts: [Post] = [
    Post(
        userName: "Alex Johnson",
        item: "Desk Lamp",
        category: "Clothing",
        location: "Eden Prairie High School",
        time: "4:00 PM",
        date: "May 27, 2026",
        message: "Category: Food   Type: Protein",
        comments: ["Is this still available?", "Can pick up today!"]
    ),
    
    Post(
        userName: "Maya Patel",
        item: "Winter Jacket",
        category: "Clothing",
        location: "Community Center",
        time: "6:00 PM",
        date: "May 10, 2026",
        message: "Category: Clothes   Type: Winter Clothing",
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

// MARK: - Post Card
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
        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Main Discussion Screen
struct DiscussionScreen: View {
    
    @State private var goHome = false
    @State private var goProgress = false
    @State private var goSettings = false
    
    // Filters
    @State private var kindFilter: KindFilter = .all
    @State private var locationFilter: String = "All"
    @State private var categoryFilter: String = "All"
    
    @State private var enableDateTimeFilter = false
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    
    @State private var showFilters = false
    
    private let primaryBlue = Color(red: 0.13, green: 0.49, blue: 0.69)
    private let accentGreen = Color(red: 0.47, green: 0.69, blue: 0.19)
    
    enum KindFilter: String, CaseIterable {
        case all = "All"
        case donate = "Donate"
        case request = "Request"
    }
    
    // Location options (your real locations)
    private let locationOptions = [
        "All",
        "Eden Prairie High School",
        "Central Middle School",
        "Oak Point Elementary School",
        "Community Center",
        "Target"
    ]
    
    // Category options (your categories)
    private let categoryOptions = [
        "All",
        "Clothing",
        "School Supplies",
        "Toys",
        "Food"
    ]
    
    // Filtered posts
    private var filteredPosts: [Post] {
        samplePosts.filter { post in
            // Kind filter – placeholder logic; later add a real field on Post
            let isDonate = post.message.lowercased().contains("category")
            let matchesKind: Bool = {
                switch kindFilter {
                case .all:
                    return true
                case .donate:
                    return isDonate
                case .request:
                    return !isDonate
                }
            }()
            
            let matchesLocation = (locationFilter == "All") || (post.location == locationFilter)
            let matchesCategory = (categoryFilter == "All") || (post.category == categoryFilter)
            
            // Date + time filter using DatePickers
            let matchesDateTime: Bool = {
                guard enableDateTimeFilter, let postDate = post.dateTime else {
                    return !enableDateTimeFilter
                }
                
                let calendar = Calendar.current
                
                // Combine selectedDate's Y/M/D with selectedTime's hour/minute
                let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
                let timeComponents = calendar.dateComponents([.hour, .minute], from: selectedTime)
                
                var combined = DateComponents()
                combined.year = dateComponents.year
                combined.month = dateComponents.month
                combined.day = dateComponents.day
                combined.hour = timeComponents.hour
                combined.minute = timeComponents.minute
                
                guard let selectedDateTime = calendar.date(from: combined) else {
                    return true
                }
                
                // Match same day and roughly same hour
                let sameDay = calendar.isDate(postDate, inSameDayAs: selectedDateTime)
                let sameHour = calendar.component(.hour, from: postDate) == calendar.component(.hour, from: selectedDateTime)
                
                return sameDay && sameHour
            }()
            
            return matchesKind
            && matchesLocation
            && matchesCategory
            && (enableDateTimeFilter ? matchesDateTime : true)
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
                    
                    // Header
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
                                Image(systemName: "line.3.horizontal.decrease.circle")
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
                    
                    // Feed
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(filteredPosts) { post in
                                PostCard(post: post)
                            }
                        }
                        .padding()
                    }
                    
                    // Bottom Nav (matching other screens)
                    HStack {
                        
                        Spacer()
                        
                        VStack(spacing: 4) {
                            Image(systemName: "gearshape.fill")
                            Text("Settings")
                                .font(.custom("Instrument Sans", size: 14).weight(.bold))
                        }
                        .foregroundColor(primaryBlue)
                        .onTapGesture { goSettings = true }
                        
                        Spacer()
                        
                        VStack(spacing: 4) {
                            Image(systemName: "house.fill")
                            Text("Home")
                                .font(.custom("Instrument Sans", size: 14).weight(.bold))
                        }
                        .foregroundColor(primaryBlue)
                        .onTapGesture { goHome = true }
                        
                        Spacer()
                        
                        VStack(spacing: 4) {
                            Image(systemName: "chart.bar.fill")
                            Text("Progress")
                                .font(.custom("Instrument Sans", size: 14).weight(.bold))
                        }
                        .foregroundColor(primaryBlue)
                        .onTapGesture { goProgress = true }
                        
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
            .sheet(isPresented: $showFilters) {
                filterSheet
            }
            .navigationDestination(isPresented: $goHome) {
                HomeScreen(isNewUser: false)
            }
            .navigationDestination(isPresented: $goProgress) {
                ProgressScreen()
            }
            .navigationDestination(isPresented: $goSettings) {
                SettingScreen()
            }
        }
    }
    
    // MARK: - Filter Sheet
    private var filterSheet: some View {
        NavigationStack {
            Form {
                Section("Type") {
                    Picker("Type", selection: $kindFilter) {
                        ForEach(KindFilter.allCases, id: \.self) { kind in
                            Text(kind.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Location") {
                    Picker("Location", selection: $locationFilter) {
                        ForEach(locationOptions, id: \.self) { loc in
                            Text(loc)
                        }
                    }
                }
                
                Section("Category") {
                    Picker("Category", selection: $categoryFilter) {
                        ForEach(categoryOptions, id: \.self) { cat in
                            Text(cat)
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
                        kindFilter = .all
                        locationFilter = "All"
                        categoryFilter = "All"
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

// Preview
#Preview {
    DiscussionScreen()
}
