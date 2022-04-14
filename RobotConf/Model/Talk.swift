//
//  Copyright © 2020 Paris Android User Group. All rights reserved.
//

import Foundation

struct Talk {
    enum Complexity {
        case beginner
        case intermediate
        case expert
    }
    let uid: String
    let title: String
    let description: String
    let duration: TimeInterval
    let speakers: [Speaker]
    let tags: [String]
    let startTime: Date
    let room: String
    let language: Language
    let complexity: Complexity?
    let questionUrl: URL?
    let platformUrl: URL?
}
