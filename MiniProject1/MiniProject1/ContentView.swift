//
//  ContentView.swift
//  MiniProject1
//
//  Created by Ahmed Alkhuder on 1/1/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        
        
        NavigationView{
            List{
                Text("مرحباً بك ،، يمكنك اختيار الدراجة المناسبة لك من القائمة وأكمل بياناتك للحجز")
                
                BikeRow(number: 1)
                
                BikeRow(number: 2)
                
                BikeRow(number: 3)
                
                BikeRow(number: 4)
                
                
            }.navigationTitle("تأجير الدراجات")
        }
        
    }
}

struct BikeReserve: View {
    var bike : String // should be taking one element from the array of bikes (picture)
    @State var name = ""
    @State var mobile = ""
    @State var hours = 0
    @State var numOfbikes = 0
    
    var body: some View {
        VStack(alignment: .center, spacing: 10)
        {
            Image(bike)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200, alignment: .center)
            
            TextField("Enter your name", text: $name)
            
            TextField("Enter your mobile number", text: $mobile)
            
            //                number of hours stepper
            HStack{
                Stepper("عدد الساعات \(hours)", value: $hours, in:0...24)
                //                Spacer() optional, looks ok in simulation
            }
            //                number of bikes stepper
            HStack{
                Stepper("عدد الدراجات \(numOfbikes)", value: $numOfbikes, in:0...100)
                //                Spacer() optional, looks ok in simulation
            }
            Spacer()
            
            let total =  Double( 7 * hours * numOfbikes)
            
            Text("\(total, specifier: "%.2f")")
            Text("المبلغ الكلي")
            if(total != 0)
            {
                NavigationLink(
                    destination: Bill(Bname: name, Bhours: hours, bmobile: mobile, Btotal: total),
                    label: {
                        Text("اضغط للمتابعة")
                            .frame(width: 350, height: 75, alignment: .center)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    })
            }else{
                Text("enter values first :)")
                    .frame(width: 350, height: 75, alignment: .center)
                    .background(Color.gray)
            }
            
        }.padding(.horizontal)
    }
    
}

struct BikeRow: View {
    let bikes = ["Bicycle","Bmw","Motorcycle","Trek"]
    var number : Int
    
    var body: some View {
        HStack{
            Text(String(number))
                .frame(width: 50, height: 50)
                .background(Color.blue)
                .clipShape(Circle())
                .foregroundColor(.white)
            
            Image(bikes[number-1])
                .resizable()
                .scaledToFit()
                .frame(height: 100)
            
            NavigationLink(
                destination: BikeReserve(bike: bikes[number-1]),
                label: {
                    Image("bike")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                })
        }
    }
}

struct Bill: View {
    let Bname : String
    let Bhours : Int
    let bmobile : String
    let Btotal : Double
    var body: some View {
        
        VStack(spacing: 30)
        {
            HStack{
                Text("الإسم")
                Spacer()
                Text("\(Bname)")
            }
            
            HStack{
                Text("الساعات")
                Spacer()
                Text("\(Bhours)")
            }
            
            HStack{
                Text("رقم الموبايل")
                Spacer()
                Text("\(bmobile)")
            }
            
            HStack{
                Text("المبلغ")
                Spacer()
                Text("\(Btotal, specifier: "%.2f")")
            }
            Spacer()
            
            //            could be a button or could be a text with on tap gesture, tried both but
            //            it seems like i'm doing something wrong or overcomplicating it.
            
            Text("ادفع الآن")
                .frame(width: 350, height: 75, alignment: .center)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            //                        BikeReserve(bike: "Bicycle")
            //                        Bill(Bname: "test", Bhours: 3, bmobile: "test2", Btotal: 23.0)
        }
    }
}


