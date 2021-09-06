//
//  FeedImageMapper.swift
//  FeedAPIChallenge
//
//  Created by Angela Lin on 9/6/21.
//  Copyright © 2021 Essential Developer Ltd. All rights reserved.
//

import Foundation

internal final class FeedImageMapper {
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
	}

	private struct NetworkFeedImageContainer: Decodable {
		let items: [NetworkFeedImage]

		var feedImages: [FeedImage] {
			return items.map { FeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url) }
		}
	}

	private static var OK_200: Int { 200 }

	internal static func map(_ data: Data, _ response: HTTPURLResponse) -> FeedLoader.Result {
		guard response.statusCode == OK_200 else {
			return .failure(RemoteFeedLoader.Error.invalidData)
		}
		do {
			let root = try JSONDecoder().decode(NetworkFeedImageContainer.self, from: data)
			return .success(root.feedImages)
		} catch {
			return .failure(RemoteFeedLoader.Error.invalidData)
		}
	}
}
