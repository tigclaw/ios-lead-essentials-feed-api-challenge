//
//  Copyright © 2018 Essential Developer. All rights reserved.
//

import Foundation

public final class RemoteFeedLoader: FeedLoader {
	private let url: URL
	private let client: HTTPClient

	public enum Error: Swift.Error {
		case connectivity
		case invalidData
	}

	public init(url: URL, client: HTTPClient) {
		self.url = url
		self.client = client
	}

	public func load(completion: @escaping (FeedLoader.Result) -> Void) {
		client.get(from: url) { result in
			switch result {
			case .success((let data, let response)):
				guard response.statusCode == 200 else {
					completion(.failure(Error.invalidData))
					return
				}
				do {
					let validData = try JSONDecoder().decode([NetworkFeedImage].self, from: data)
					let feedImages = validData.map { FeedImage(
						id: $0.id,
						description: $0.description,
						location: $0.location,
						url: $0.url)
					}
					completion(.success(feedImages))
				} catch {
					completion(.failure(Error.invalidData))
					return
				}

			case .failure:
				completion(.failure(Error.connectivity))
			}
		}
	}
}
