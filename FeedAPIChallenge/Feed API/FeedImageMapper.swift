//
//  FeedImageMapper.swift
//  FeedAPIChallenge
//
//  Created by Angela Lin on 9/6/21.
//  Copyright © 2021 Essential Developer Ltd. All rights reserved.
//

import Foundation

internal class FeedImageMapper {
	private struct NetworkFeedImage: Decodable {
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

	private struct NetworkFeedImageContainer: Decodable {
		let items: [NetworkFeedImage]
	}

	static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [FeedImage] {
		guard response.statusCode == 200 else {
			throw RemoteFeedLoader.Error.invalidData
		}
		do {
			return try JSONDecoder().decode(NetworkFeedImageContainer.self, from: data).items.map { $0.feedImage }
		} catch {
			throw RemoteFeedLoader.Error.invalidData
		}
	}
}
