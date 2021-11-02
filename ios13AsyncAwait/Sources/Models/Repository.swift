//
//  Repository.swift
//  ios13AsyncAwait
//
//  Created by Michal on 01/11/2021.
//

import Foundation

struct Repository: Identifiable, Codable {
    let id: Int
    let name: String
    let url: String?
}
