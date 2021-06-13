import Foundation
import SwiftUI

// Categories
enum Category: String,CaseIterable,Codable,Hashable
{
    case dog
    case cat
    case pig
    // case accessory
}

// Characteristics of each article
struct Article: Identifiable,Hashable
{
    var id: String
    var name: String
    var imageName: String
    var category: Category
    var description: String
    var price: Double
}

// Convert values to key-values
func articleDictionnaryFrom(article: Article) -> [String : Any] {
    return NSDictionary(objects: [article.id,
                               article.name,
                               article.imageName,
                               article.category.rawValue,
                               article.description,
                               article.price
                                ], forKeys: [kID as NSCopying,
                                             kNAME as NSCopying,
                                             kIMAGENAME as NSCopying,
                                             kCATEGORY as NSCopying,
                                             kDESCRIPTION as NSCopying,
                                             kPRICE as NSCopying
    ]) as! [String : Any]
}

//Fonction pour parcourir le tableau et transférer les données dans Firebase
func createMenu(){
    for article in articleData{
        FirebaseReference( .Menu).addDocument(data: articleDictionnaryFrom(article: article))
    }
}

// données qui permettre à placer les données dans Firebase
let articleData = [
    
    // Dogs
    Article(id: UUID().uuidString, name: "Cute Dog", imageName: "dog1", category: Category.dog, description: "We have a wide selection of very cute dogs. They range in size and breed, but they are all very cute!", price: 1200.00),
    
    Article(id: UUID().uuidString, name: "Funny Dog", imageName: "dog2", category: Category.dog, description: "We have dogs that are funny too! They do tricks, tell dog jokes and sing funny songs.", price: 1400.00),
    
    Article(id: UUID().uuidString, name: "Bestie Dog", imageName: "dog3", category: Category.dog, description: "These dogs are extremely loyal and will keep you the best company ever. They will become your best friend.", price: 2000.00),
    
    Article(id: UUID().uuidString, name: "Fancy Dog", imageName: "dog4", category: Category.dog, description: "Our fancy dogs have very high standards. They only sleep on the comfiest beds and eat the most expensive dog food. Perfect if you want a high-class dog.", price: 5000.00),
    
    Article(id: UUID().uuidString, name: "Athletic Dog", imageName: "dog5", category: Category.dog, description: "These dogs love to run, jump and play. They will encourage you to work out and keep you in shape. Perfect if you love to stay active.", price: 1500.00),
    
    
    // Cats
    Article(id: UUID().uuidString, name: "xxx Cat", imageName: "cat1", category: Category.cat, description: "Nullam ac cursus augue. Donec malesuada massa a libero feugiat, id rhoncus nunc posuere. Suspendisse nec luctus ipsum. Nullam et aliquet enim. ", price: 1200.00),
    
    Article(id: UUID().uuidString, name: "xxx Cat", imageName: "cat2", category: Category.cat, description: "Nullam ac cursus augue. Donec malesuada massa a libero feugiat, id rhoncus nunc posuere. Suspendisse nec luctus ipsum. Nullam et aliquet enim. ", price: 1200.00),
    
    Article(id: UUID().uuidString, name: "xxx Cat", imageName: "cat3", category: Category.cat, description: "Nullam ac cursus augue. Donec malesuada massa a libero feugiat, id rhoncus nunc posuere. Suspendisse nec luctus ipsum. Nullam et aliquet enim. ", price: 1200.00),
    
    Article(id: UUID().uuidString, name: "xxx Cat", imageName: "cat4", category: Category.cat, description: "Nullam ac cursus augue. Donec malesuada massa a libero feugiat, id rhoncus nunc posuere. Suspendisse nec luctus ipsum. Nullam et aliquet enim. ", price: 1200.00),
    
    Article(id: UUID().uuidString, name: "xxx Cat", imageName: "cat5", category: Category.cat, description: "Nullam ac cursus augue. Donec malesuada massa a libero feugiat, id rhoncus nunc posuere. Suspendisse nec luctus ipsum. Nullam et aliquet enim. ", price: 1200.00),
    
    // Pigs
    Article(id: UUID().uuidString, name: "xxx Pig", imageName: "pig1", category: Category.pig, description: "Nullam ac cursus augue. Donec malesuada massa a libero feugiat, id rhoncus nunc posuere. Suspendisse nec luctus ipsum. Nullam et aliquet enim. ", price: 1200.00),
    
    Article(id: UUID().uuidString, name: "xxx Pig", imageName: "pig2", category: Category.pig, description: "Nullam ac cursus augue. Donec malesuada massa a libero feugiat, id rhoncus nunc posuere. Suspendisse nec luctus ipsum. Nullam et aliquet enim. ", price: 1200.00),
    
    Article(id: UUID().uuidString, name: "xxx Pig", imageName: "pig3", category: Category.pig, description: "Nullam ac cursus augue. Donec malesuada massa a libero feugiat, id rhoncus nunc posuere. Suspendisse nec luctus ipsum. Nullam et aliquet enim. ", price: 1200.00),
    
    // Accessories
]
