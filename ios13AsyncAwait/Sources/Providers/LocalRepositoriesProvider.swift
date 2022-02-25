//
//  LocalRepositories.swift
//  ios13AsyncAwait
//
//  Created by Michal on 01/11/2021.
//

import Foundation

final class LocalRepositoriesProvider: ObservableObject, RepositoryProvider {
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var repositories: [Repository] = []
    
    func loadRepositories() async {
        error = nil
        isLoading = true
        
        do {
            try await Task.sleep(nanoseconds: 2000000000) // wait 2 seconds
            
            repositories = [
                Repository(id: 0, name: "match", url: "~/repos/match"),
                Repository(id: 1, name: "SwiftPackageWithGithubActionsAsCI", url: "~/repos/SwiftPackageWithGithubActionsAsCI"),
                Repository(id: 2, name: "NikeClockIcon", url: "~/repos/NikeClockIcon"),
                Repository(id: 3, name: "halloween_2018_watch_face", url: "~/repos/halloween_2018_watch_face"),
                Repository(id: 4, name: "tatooine", url: "~/repos/tatooine")
            ]
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}
