import SwiftUI

struct CheckoutView: View {
    @ObservedObject var basketListener = BasketListener()
    static let paymentTypes = ["Cash","Credit Card"]
    static let tipAmounts = [0,10,15,20]
    @State private var paymentType = 0
    @State private var tipAmount = 0
    @State private var showingPaymentAlert = false
  
    var totalPrice: Double
    {
        let total = basketListener.orderBasket.total
        let tipValue = total / 100 * Double(Self.tipAmounts[tipAmount])
        return total + tipValue
    }
    
    var body: some View {
        Form {
            Section {
                Picker(selection: $paymentType, label: Text("Payment mode ?").foregroundColor(.orange)){
                    
                    ForEach(0 ..< Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }
            }//Fin de la Section 1
        
            Section{
                Picker(selection: $tipAmount, label: Text("Percentage: ")){
                   
                    ForEach(0 ..< Self.tipAmounts.count) {
                        Text("\(Self.tipAmounts[$0]) %")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            } // end of section 2
            
            Section(header: Text("Total: $\(totalPrice, specifier: "%.2f")").font(.largeTitle).foregroundColor(.orange)) {
                
                Button(action: {
                    self.showingPaymentAlert.toggle()
                    //print("check out")
                    self.createOrder()
                    self.emptyBasket()
                    
                }) {
                    
                    Text("Confirm order")
                        .foregroundColor(.orange)
                }
            }.disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
            
            // end of section three
            
        } //end of the form
        .navigationBarTitle(Text("Payment"), displayMode: .inline)
        .alert(isPresented: $showingPaymentAlert)
        {
            Alert(title: Text("Order Confirmed "), message: Text("Thank you for your purchase!"), dismissButton: .default(Text("OK")))
        }
    }
        
    private func emptyBasket()
    {
     self.basketListener.orderBasket.emptyBasket()
    }
     private func createOrder()
     {
         let order=Order()
         order.amount = totalPrice
         order.id = UUID().uuidString
        order.customerId = FUser.currentId()
         order.orderItems = self.basketListener.orderBasket.items
         order.saveOrderToFirestore()
         
     }
    
}
struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }

}
