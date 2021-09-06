//
//  FeedImageMapper.swift
//  FeedAPIChallenge
//
//  Created by Angela Lin on 9/6/21.
//  Copyright © 2021 Essential Developer Ltd. All rights reserved.
//

import Foundation

internal class FeedImageMapper {
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
