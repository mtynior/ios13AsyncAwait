//
//  RepositoryProvider.swift
//  ios13AsyncAwait
//
//  Created by Michal on 01/11/2021.
//

import Foundation

@MainActor
protocol RepositoryProvider {
    var isLoading: Bool { get set }
    var error: Error? { get set }
    var repositories: [Repository] { get set }
    
    func loadRepositories() async
}
