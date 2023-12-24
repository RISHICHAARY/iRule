import Foundation
import RealmSwift

class Users: Object, Identifiable {
    @Persisted (primaryKey: true) var _id: ObjectId
    @Persisted var faceid: String
    @Persisted var type: String
    @Persisted var name: String
    @Persisted var email: String
    @Persisted var mobileno: String
    @Persisted var company: String
    @Persisted var post: String
    @Persisted var others: List<String>
    @Persisted var assignedpolls: Int
    @Persisted var participatedpolls: List<ObjectId>
    @Persisted var password: String
}

class Polls: Object, Identifiable {
    @Persisted (primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    @Persisted var options: List<Options>
    @Persisted var noOptions: String
    @Persisted var date: Date
    @Persisted var company: String
    @Persisted var post: String
    @Persisted var others: String
    @Persisted var participants: List<Participants>
    @Persisted var status: String
}

class Options: Object, Identifiable {
    @Persisted (primaryKey: true) var _id: ObjectId
    @Persisted var option1: String
    @Persisted var option1Votes: Int
    @Persisted var option2: String
    @Persisted var option2Votes: Int
    @Persisted var option3: String?
    @Persisted var option3Votes: Int?
    @Persisted var option4: String?
    @Persisted var option4Votes: Int?
}

class Participants: Object, Identifiable {
    @Persisted (primaryKey: true) var _id: ObjectId
    @Persisted var email: String
    @Persisted var isvoted: Bool
}

class Companies: Object, Identifiable {
    @Persisted (primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    @Persisted var posts: List<String>
    @Persisted var groups: List<String>
}
