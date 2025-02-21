//
//  ContentView.swift
//  BetterRest
//
//  Created by Ritika Gupta on 18/02/25.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUpTime = defaultWakeUpTime
    @State private var sleepHours = 8.0
    @State private var coffeeAmount = 1
    
//    @State private var alertTitle = ""
//    @State private var alertMessage = ""
//    @State private var isShowingAlert: Bool = false
//
    
    @State private var idealBedTime: String = ""
    
    static private var defaultWakeUpTime: Date {
        get {
            var component = DateComponents()
            component.hour = 7
            component.minute = 0
            return Calendar.current.date(from: component) ?? .now
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Waking up Time ⏰") {
                    DatePicker("Morning Alarm", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.blue)
                }
                
                Section("Snooze Goals 😴") {
                    Stepper("\(sleepHours.formatted()) hours", value: $sleepHours, in: 4...12, step: 0.25)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.blue)
                    
                }
                Section("Daily Bean Count ☕️") {
                    Picker("Coffee Intake", selection: $coffeeAmount) {
                        ForEach(1...20, id: \.self) {
                            Text("^[\($0) cup](inflect: true)")
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.blue)
                            
                        }
                    }
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.blue)
                }
                
                Text("Your Ideal bedtime 🛌  should be")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
                
                Text(idealBedTime)
                    .font(.title2)
                    .bold()
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .purple, .orange],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            }
//            .toolbar {
//                Button {
//                    calculateSleep()
//                } label: {
//                    Text("Calculate Sleep")
//                }
//            }
//            .alert(alertTitle, isPresented: $isShowingAlert, actions: {
//                Button("Ok") {}
//            }, message: {
//                Text(alertMessage)
//            })
            .navigationTitle("Better Rest")
            .tint(.blue)
            .onAppear{
                calculateSleep()
            }
            .onChange(of: wakeUpTime) { calculateSleep() }
            .onChange(of: sleepHours) { calculateSleep() }
            .onChange(of: coffeeAmount) { calculateSleep() }
        }
    }
    
    func calculateSleep() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hour = (components.hour ?? 0) * 60 * 60
            let minutes = (components.minute ?? 0) * 60
            
            let wakeUpTimeInSeconds = (hour + minutes)
            
            let prediction = try model.prediction(wake: Double(wakeUpTimeInSeconds), estimatedSleep: sleepHours, coffee: Double(coffeeAmount))
            
            let bedTime = wakeUpTime - prediction.actualSleep
            idealBedTime = bedTime.formatted(date: .omitted, time: .shortened)
//            alertTitle = "You need to go to bed at.."
//            alertMessage = bedTime.formatted(date: .omitted, time: .shortened)
        } catch {
//            alertTitle = "Error"
//            alertMessage = "Sorry, Prediction failed"
        }
//        isShowingAlert = true
    }
}

#Preview {
    ContentView()
}
