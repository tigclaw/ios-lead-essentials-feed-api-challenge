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

	private enum CodingKeys: String, CodingKey {
		case id = "image_id"
		case description = "image_desc"
		case location = "image_loc"
		case url = "image_url"
	}

	var feedImage: FeedImage {
		return FeedImage(id: id, description: description, location: location, url: url)
	}
}

internal struct NetworkFeedImageContainer: Decodable {
	let items: [NetworkFeedImage]
}
