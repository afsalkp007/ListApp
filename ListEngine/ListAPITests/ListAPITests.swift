//
//  ListAPITests.swift
//  ListAPITests
//
//  Created by Afsal on 03/05/2024.
//

import XCTest
import ListEngine

final class ListAPITests: XCTestCase {
  
  func test_endToEndServerGETFeedResult_matchesFixedTestAccountData() {
    switch getFeedResult() {
    case let .success(imageFeed)?:
      XCTAssertEqual(imageFeed.count, 37, "Expected 8 images in the test account image feed")
      
      XCTAssertEqual(imageFeed[0], expectedImage(at: 0))
      XCTAssertEqual(imageFeed[1], expectedImage(at: 1))
      XCTAssertEqual(imageFeed[2], expectedImage(at: 2))
    case let .failure(error)?:
      XCTFail("Expected successful feed result, got \(error) instead")
      
    default:
      XCTFail("Expected successful feed result, got no result instead")
    }
  }
  
  // MARK: - Helpers
  
  private func getFeedResult(file: StaticString = #filePath, line: UInt = #line) -> FeedLoader.Result? {
    let client = ephemeralClient(file: file, line: line)
    let loader = RemoteFeedLoader(url: feedTestServerURL, client: client)
    trackForMemoryLeaks(loader, file: file, line: line)
    
    let exp = expectation(description: "Wait for load completion")
    
    var receivedResult: FeedLoader.Result?
    loader.load { result in
      receivedResult = result
      exp.fulfill()
    }
    wait(for: [exp], timeout: 10.0)
    return receivedResult
  }
    
  private var feedTestServerURL: URL {
    return URL(string: "http://universities.hipolabs.com/search?country=United%20Arab%20Emirates")!
  }
  
  private func ephemeralClient(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
    let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    trackForMemoryLeaks(client, file: file, line: line)
    return client
  }
  
  private func expectedImage(at index: Int) -> FeedImage {
    FeedImage(
      name: name(at: index),
      country: country(at: index),
      code: code(at: index),
      state: state(at: index),
      webpage: webpage(at: index)
    )
  }
  
  private func name(at index: Int) -> String {
    return [
      "Mohamed bin Zayed University of Artificial Intelligence (MBZUAI)",
      "American College Of Dubai",
      "Abu Dhabi University",
    ][index]
  }

  private func country(at index: Int) -> String {
    return [
      "United Arab Emirates",
      "United Arab Emirates",
      "United Arab Emirates",
    ][index]
  }
  
  private func code(at index: Int) -> String {
    return [
      "AE",
      "AE",
      "AE",
    ][index]
  }
  
  private func state(at index: Int) -> String? {
    return [
      "Abu Dhabi",
      nil,
      nil,
    ][index]
  }
  
  private func webpage(at index: Int) -> String? {
    return [
      "https://mbzuai.ac.ae/",
      "http://www.acd.ac.ae/",
      "http://www.adu.ac.ae/",
    ][index]
  }
}
