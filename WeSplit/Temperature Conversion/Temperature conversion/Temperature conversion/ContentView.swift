//
//  ContentView.swift
//  Temperature conversion
//
//  Created by Bohdan Plastun on 29.01.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var inputTemperature = 0.0
    @State private var typeOfTemperaturesInput = "Celsius"
    @State private var typeOfTemperaturesOutput = "Fahrenheit"
    @FocusState private var amountIsFocused: Bool
    let typesOfTemperatures = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var convertedFromCelsiusToOther: Double {
        var celsiusTemperature: Double
        var result: Double
        
        switch typeOfTemperaturesInput {
        case "Celsius":
            celsiusTemperature = inputTemperature
        case "Fahrenheit":
            celsiusTemperature = (inputTemperature - 32) * 5 / 9
        case "Kelvin":
            celsiusTemperature = inputTemperature - 273.15
        default:
            celsiusTemperature = inputTemperature
        }
        
        switch typeOfTemperaturesOutput {
        case "Celsius":
            result = celsiusTemperature
        case "Fahrenheit":
            result = (celsiusTemperature * 9 / 5) + 32
        case "Kelvin":
            result = celsiusTemperature + 273.15
        default:
            result = celsiusTemperature
        }
        return result
    }
        
        
   
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Input type of temperature", selection: $typeOfTemperaturesInput) {
                        ForEach(typesOfTemperatures, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select input temperature type")
                }
                
                Section {
                    Picker("Output type of temperature", selection: $typeOfTemperaturesOutput) {
                        ForEach(typesOfTemperatures, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select output temperature type")
                }
                
                Section {
                    TextField("Temperature", value: $inputTemperature, format: .number)
                        .keyboardType(.numbersAndPunctuation)
                        .focused($amountIsFocused)
                } header: {
                    Text("Enter temperature")
                }
                
                Section {
                    Text(convertedFromCelsiusToOther, format: .number)
                } header: {
                    Text("Converted temperature")
                }
            }
            .navigationTitle("Temperature Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
