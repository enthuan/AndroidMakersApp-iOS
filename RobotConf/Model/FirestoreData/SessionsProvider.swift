//
//  Copyright © 2020 Paris Android User Group. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Combine

/// Object that provides server sessions
class SessionsProvider {
    struct Session: Decodable {
        let complexity: String?
        let speakers: [String]?
        let description: String
        let language: String?
        let title: String
        let tags: [String]
        let videoUrl: String?
        let platformUrl: String?
        let slido: String?
    }

    var sessionsPublisher = PassthroughSubject<[String: Session], Error>()

    init(database: Firestore) {
        database.collection("sessions").getDocuments { [weak self] (querySnapshot, err) in
            guard let self = self else { return }
            if let err = err {
                print("Error getting documents: \(err)")
                self.sessionsPublisher.send(completion: .failure(err))
            } else {
                do {
                    var sessions = [String: Session]()
                    for document in querySnapshot!.documents {
                        sessions[document.documentID] = try document.decoded()
                    }
                    self.sessionsPublisher.send(sessions)
                } catch let error {
                    self.sessionsPublisher.send(completion: .failure(error))
                }
            }
        }
    }
}
