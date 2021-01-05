//
//  FirebaseLayer.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 1/3/21.
//  Copyright © 2021 Edvin Lellhame. All rights reserved.
//

import Foundation
import Firebase


struct FirebaseLayer {
    static var reference = Database.database().reference()
    static let uid = Auth.auth().currentUser?.uid
    
    static func remove(event: Event, completion: @escaping () -> ()) {
        let ref = reference.child("likedEvents").child(uid!).child("\(event.id)").child("hasLiked")
        ref.removeValue { (error, _) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                DispatchQueue.main.async {
                    completion()
                }
                
            }
        }
    }
    
    static func add(event: Event, completion: @escaping () -> ()) {
        let userPostRef = Database.database().reference().child("likedEvents").child(uid!)
        let ref = userPostRef.child("\(event.id)")
        let values = ["hasLiked": true]
        
        ref.updateChildValues(values) { (error, ref) in
            if let error = error {
                print("Failed to save post to DB", error)
                return
            }
            
            DispatchQueue.main.async {
                completion()
            }
            
        }
    }
    
    static func isEventLiked(event: Event, completion: @escaping (Bool) -> ())  {
        reference.child("likedEvents").child(uid!).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.hasChild("\(event.id)") {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
