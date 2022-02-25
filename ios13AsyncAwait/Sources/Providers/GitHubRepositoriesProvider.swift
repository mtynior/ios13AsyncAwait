//
//  GitHubRepositoriesProvider.swift
//  ios13AsyncAwait
//
//  Created by Michal on 01/11/2021.
//

import Foundation

final class GitHubRepositoriesProvider: ObservableObject, RepositoryProvider {
    private let remoteUrl = URL(string: "https://api.github.com/users/mtynior/repos")!
    
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var repositories: [Repository] = []
    
    func loadRepositories() async {
        error = nil
        isLoading = true
        
        do {
            let (data, _) = try await URLSession.shared.data(from: remoteUrl)
            repositories = try JSONDecoder().decode([Repository].self, from: data)
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}

extension URLSession {
    @available(iOS, deprecated: 15.0, message: "This extension is no longer necessary. Use API built into SDK")
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: url) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }
                
                continuation.resume(returning: (data, response))
            }
            
            task.resume()
        }
    }
}
