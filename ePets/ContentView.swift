//
//  ContentView.swift
//  ePets
//
//  Created by Oluwatomilayo Shittu on 2021-06-06.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var articleListener = ArticleListener()
    @State private var showingBasket = false
    var categories: [String : [Article]]
    {
        .init(grouping: articleListener.articles,
              by: {$0.category.rawValue})
    }
    var body: some View {
        NavigationView {
            List(categories.keys.sorted(),id: \String.self){
                key in
                ArticleRow(categoryName: "\(key)", articles: self.categories[key]!)
                    .frame(height:320)
                
            }
                .navigationBarTitle(Text("ePets"))
                .navigationBarItems(leading:
                            Button(action: {
                                FUser.logOutCurrentUser{(error) in
                                    print("error logging out user = ",error?.localizedDescription) }
                    
                }, label: {
                    Text("Log out")
                        .foregroundColor(Color.red)
                }), trailing: Button(action: {
                    //code
                    self.showingBasket.toggle()
                   // print("basket")
                }, label: {
                    Image("basket")
                })
                .sheet(isPresented: $showingBasket)
                {
                    if FUser.currentUser() != nil &&
                        FUser.currentUser()!.onBoarding
                    {
                    OrderBasketView()
                    }else if FUser.currentUser() != nil
                    {
                        FinishRegistrationView()
                    }else
                    {
                        LoginView()
                    }
                    
                }
            )
        }//Fin de navigationView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

