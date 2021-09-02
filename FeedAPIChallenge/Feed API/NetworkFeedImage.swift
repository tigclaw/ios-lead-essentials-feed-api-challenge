//
//  NetworkFeedImage.swift
//  FeedAPIChallenge
//
//  Created by Angela Lin on 9/1/21.
//  Copyright © 2021 Essential Developer Ltd. All rights reserved.
//

import Foundation

internal struct NetworkFeedImage: Decodable {
	let id: UUID
	let description: String?
	let location: String?
	let url: URL
}
