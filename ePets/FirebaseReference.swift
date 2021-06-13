//
//  FirebaseReference.swift
//  ePets
//
//  Created by Oluwatomilayo Shittu on 2021-06-06.
//

import Foundation
import Foundation
import FirebaseFirestore
enum FCollectionReference: String{
   case User
   case Menu
   case Order
   case Basket
}
// access each element in firestore
func FirebaseReference(_ collectionReference: FCollectionReference) ->
CollectionReference{
    return Firestore.firestore().collection(collectionReference.rawValue)
}
