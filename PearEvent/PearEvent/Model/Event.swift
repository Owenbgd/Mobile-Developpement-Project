//
//  Event.swift
//  PearEvent
//
//  Created by goldorak on 07/02/2022.
//

import Foundation
import UIKit

struct Records: Codable {
    let records: [Information]?
}

struct Information: Codable {
    let id: String
    let fields: Event
    let createdTime: String
}

struct Event: Codable {

    var type: String
    var date: String
    var location: String
    var speaker: String
    var topic: String
    var notes: String
    var title: String
    var pictureEvent: [InformationImage]?
    
    
    init(type: String, date: String, location: String, speaker: String, topic: String, notes: String, title: String, pictureEvent: [InformationImage]?){
        self.type = type
        self.date = date
        self.location = location
        self.speaker = speaker
        self.topic = topic
        self.notes = notes
        self.title = title
        self.pictureEvent = pictureEvent
    }
}

struct InformationImage: Codable {
    let url: String
}
struct Response: Codable {
    let id: String
    let deleted: Bool
}
struct ErrorResponse: Codable {
    let error: String
}

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}
enum CustomError: Error {
    case requestError
    case statusCodeError
    case parsingError
}
