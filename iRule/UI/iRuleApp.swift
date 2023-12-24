import SwiftUI

@main
struct iRuleApp: App {
    
    @StateObject private var realmManager = RealmManager.shared
    
    var body: some Scene {
        WindowGroup {
            VStack{
                if let configuration = realmManager.configuration, let realm = realmManager.realm{
                    ContentView()
                        .environment(\.realmConfiguration, configuration)
                        .environment(\.realm, realm)
                }
            }
            .task {
                try! await realmManager.initialize()
            }
        }
    }
}
