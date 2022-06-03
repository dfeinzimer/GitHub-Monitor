//
//  ContentView.swift
//  Shared
//
//  Created by David on 6/2/22.
//

import SwiftUI

struct ContentView: View {
    @State var gitHubTestMessage: String = "Hello, world!"
    
    var body: some View {
        Text(gitHubTestMessage)
            .frame(width: 300, height: 300)
            .onAppear {
                Task {
                    let message = try? await testGitHubConnection()
                    gitHubTestMessage = message ?? "Error"
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func testGitHubConnection() async throws -> String {
    let url = URL(string: "https://api.github.com/zen")!
    let urlRequest = URLRequest(url: url)
    let (data, _) = try await URLSession.shared.data(for: urlRequest)
    return String(data: data, encoding: .utf8) ?? ""
}
