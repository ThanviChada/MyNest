import Foundation

struct DonationItem: Identifiable {
    let id = UUID()
    let name: String
    let quantity: Int
    let details: String?
}
