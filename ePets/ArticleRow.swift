import SwiftUI

struct ArticleRow: View {
    var categoryName: String
    var articles: [Article]
    var body: some View {
        VStack(alignment: .leading)
        {
            Text(self.categoryName)
                .autocapitalization(.words)
                .font(.title)
                .foregroundColor(.red)
               
            ScrollView(.horizontal, showsIndicators: false)
            {
                HStack
                {
                    ForEach(self.articles) {article in
                        NavigationLink(destination: ArticleDetail(article: article))
                        {
                        ArticleItem(article: article)
                            .frame(width: 300)
                            .padding(.trailing,30)
                        } // End of navigation link
                    }
                    
                }//Fin Hstack
                
            }//Fin scrollView
            
        }//Fin Vstack
        
    }
}

struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow(categoryName: "dog", articles: articleData)
    }
}


