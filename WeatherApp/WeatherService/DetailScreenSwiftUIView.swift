//
//  DetailScreenSwiftUIView.swift
//  WeatherApp
//
//  Created by Mindaugas Balakauskas on 02/10/2022.
//

import SwiftUI
import Combine

struct DetailScreenSwiftUIView: View {
    
    @ObservedObject var viewModel:  WeatherViewModel
    
    var body: some View {
        
        VStack {
          
            Text(viewModel.locationName)
                .font(.system(size: 30))
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Text(viewModel.curentTemperature)
                .font(.system(size: 80))
                .bold()
            Text(viewModel.weatherIcon)
                .font(.system(size: 110))
                .padding()
            Text(viewModel.weatherDescription)
                .font(.system(size: 20))
            Text(" ")
            Text(viewModel.feelsLike)
                .font(.system(size: 20))
            Text("\(viewModel.tempMax)\(viewModel.tempMin)")
                .font(.system(size: 20))
            Text(viewModel.pressure)
                .font(.system(size: 20))
                
        }.onAppear(perform: viewModel.refresh)
    }
}
struct DetailScreenSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreenSwiftUIView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}

