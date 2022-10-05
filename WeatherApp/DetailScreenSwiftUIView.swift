//
//  DetailScreenSwiftUIView.swift
//  WeatherApp
//
//  Created by Mindaugas Balakauskas on 02/10/2022.
//

import SwiftUI
import Combine

struct DetailScreenSwiftUIView: View {
    
   
    @ObservableObject private var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.cityName)
                .font(.largeTitle)
                .padding()
            Text(viewModel.temperature)
                .font(.system(size: 75))
                .bold()
            Text(viewModel.weatherIcon)
                .font(.largeTitle)
                .padding()
            Text(viewModel.weatherDescription)
                
        }.onAppear(perform: viewModel.refresh)
    }
}

struct DetailScreenSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreenSwiftUIView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}

