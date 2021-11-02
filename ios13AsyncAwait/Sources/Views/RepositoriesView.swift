//
//  RepositoriesView.swift
//  ios13AsyncAwait
//
//  Created by Michal on 01/11/2021.
//

import SwiftUI

enum DataProvider: Int {
    case local
    case remote
}

struct RepositoriesView: View {
    @StateObject var localRepositoriesProvider = LocalRepositoriesProvider()
    @StateObject var gitHubRepositoriesProvider = GitHubRepositoriesProvider()
    @State var selectedDataSource: DataProvider = .local
    
    var currentDataProvider: RepositoryProvider {
        switch selectedDataSource {
        case .local: return localRepositoriesProvider
        case .remote: return gitHubRepositoriesProvider
        }
    }
    
    var body: some View {
        VStack {
            Picker("Data provider", selection: $selectedDataSource) {
                Text("Local").tag(DataProvider.local)
                Text("Remote").tag(DataProvider.remote)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 10)
            
            if let error = currentDataProvider.error {
                Text(error.localizedDescription)
                    .padding(10)
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(Color.red)
                    .foregroundColor(.white)
            }
            
            if currentDataProvider.isLoading {
                Text("Loading...")
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(Color.clear)
            } else {
                List(currentDataProvider.repositories) {
                    Text($0.name)
                        .frame(minHeight: 30, alignment: .leading)
                }
            }
            
            Spacer()
            
            Button("Load repos") {
                Task {
                    await currentDataProvider.loadRepositories()
                }
            }
        }
        .navigationBarTitle("Repositories", displayMode: .large)
    }
}

struct RepositoriesView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoriesView()
    }
}
