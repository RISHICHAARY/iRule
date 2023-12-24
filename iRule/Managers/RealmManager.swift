import Foundation
import RealmSwift

class RealmManager: ObservableObject{
    let app: App
    @Published var user: User?
    @Published var configuration: Realm.Configuration?
    @Published var realm: Realm?

    static let shared = RealmManager()
    
    private init(){
        self.app = App(id: "application-0-jvynk")
    }
    
    @MainActor func initialize() async throws{
        user = try await app.login(credentials: Credentials.anonymous)
        self.configuration = user?.flexibleSyncConfiguration(initialSubscriptions: { subs in
            if let _ = subs.first(named:"all-Users"), let _ = subs.first(named:"all-Polls"), let _ = subs.first(named:"all-Options"), let _ = subs.first(named:"all-Participants"), let _ = subs.first(named:"all-Companies"){
                return
            }
            else{
                subs.append(QuerySubscription<Users>(name:"all-Users"))
                subs.append(QuerySubscription<Polls>(name:"all-Polls"))
                subs.append(QuerySubscription<Options>(name:"all-Options"))
                subs.append(QuerySubscription<Participants>(name:"all-Participants"))
                subs.append(QuerySubscription<Companies>(name:"all-Companies"))
            }
        },rerunOnOpen: true)
        realm = try! await Realm(configuration: configuration!, downloadBeforeOpen: .always)
    }
}
