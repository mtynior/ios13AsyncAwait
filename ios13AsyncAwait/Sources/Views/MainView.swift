//
//  MainView.swift
//  ios13AsyncAwait
//
//  Created by Michal on 01/11/2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            RepositoriesView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
