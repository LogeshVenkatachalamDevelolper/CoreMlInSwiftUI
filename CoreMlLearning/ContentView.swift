//
//  ContentView.swift
//  CoreMlLearning
//
//  Created by Apple on 24/02/24.
//

import SwiftUI
import CoreML

//struct ContentView: View {
//    @State private var wakeUp = Date.now
//    @State private var sleepAmount = 8.0
//    @State private var coffeeAmount = 1
//
//    
//    func calculateBedtime(){
//        print("hi")
//    }
//    
//    
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Text("When do you want to wake up?")
//                    .font(.headline)
//
//                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
//                    .labelsHidden()
//
//                Text("Desired amount of sleep")
//                    .font(.headline)
//
//                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
//                
//                Text("Daily coffee intake")
//                    .font(.headline)
//
//                Stepper("\(coffeeAmount) cup(s)", value: $coffeeAmount, in: 1...20)
//            }.navigationTitle("BetterRest")
//                .toolbar {
//                    Button("Calculate", action: calculateBedtime)
//                }
//        }
//    }
//}

struct ContentView: View {
    @State private var cupOfCoffeeIntake = 0
    @State private var expectingSleepHrs = 4.0
    @State private var wakeUp = defaultWakeTime
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
//    @Statet private var 
    
   static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
//    func calculateBetTime(){
//        
//        do {
//            let config = MLModelConfiguration()
//            let model = try SleepCalculator(configuration: config)
//            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//            let hour = (components.hour ?? 0) * 60 * 60
//            let minute = (components.minute ?? 0) * 60
//            
//            let prediction = try model.prediction(wake: Int64(Double(hour + minute)), estimatedSleep: expectingSleepHrs, coffee: Int64(Double(cupOfCoffeeIntake)))
//            
//            let sleepTime = wakeUp - prediction.actualSleep
//
//            alertTitle = "Your ideal bedtime is…"
//            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
//        } catch {
//            alertTitle = "Error"
//            alertMessage = "Sorry, there was a problem calculating your bedtime."
//        }
//        
//        showingAlert = true
//        
//    }
    
        func calculateBetTime()->String{
    
            do {
                let config = MLModelConfiguration()
                let model = try SleepCalculator(configuration: config)
                let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
                let hour = (components.hour ?? 0) * 60 * 60
                let minute = (components.minute ?? 0) * 60
    
                let prediction = try model.prediction(wake: Int64(Double(hour + minute)), estimatedSleep: expectingSleepHrs, coffee: Int64(Double(cupOfCoffeeIntake)))
    
                let sleepTime = wakeUp - prediction.actualSleep
    
//                alertTitle = "Your ideal bedtime is…"
                return sleepTime.formatted(date: .omitted, time: .shortened)
            } catch {
//                alertTitle = "Error"
                return "Sorry, there was a problem calculating your bedtime."
            }
    
//            showingAlert = true
    
        }
    
    var result: String {
        calculateBetTime()
    }
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("when do you want to wake up") {
//                    Text("when do you want to wake up").font(.headline)
                
                
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                }
          
            
                Section("Daily coffee intake") {
//                    Text("Daily coffee intake")
//                        .font(.headline)
                    
//                    Stepper("^[\(cupOfCoffeeIntake) cup](inflect: true)", value: $cupOfCoffeeIntake, in:0...20)
                    
                    Picker("^[\(cupOfCoffeeIntake) cup](inflect: true)", selection: $cupOfCoffeeIntake){
                        ForEach(0...20, id: \.self) { i in
                                Text("\(i)").bold()
                            }
//                        ForEach(0...20, id: , content: <#T##(Binding<C.Element>) -> _#>)
                    }
                    
                }
            
                Section("Desired amount of sleep") {
//                    Text("Desired amount of sleep")
//                        .font(.headline)

                    
                        Stepper("\(expectingSleepHrs.formatted()) expecting sleep hrs", value:$expectingSleepHrs, in:4...12, step:0.25).alert(alertTitle, isPresented: $showingAlert){
                            Button("ok"){}
                        } message: {
                            Text(alertMessage)
                        }
                }
                
                Section("Time For Bed"){
                    VStack(alignment: .center, spacing: 10 ){
                        Text("\(result)").font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(10)
                    }.frame(maxWidth: .infinity)
                }
            }.navigationTitle("Better Rest")
        }
    }
    
//    func createML(){
//        do {
//            let config = MLModelConfiguration()
//            let model = try SleepCalculator(configuration: config)
//
//            // more code here
//        } catch {
//            // something went wrong!
//        }
//    }
}

#Preview {
    ContentView()
}
