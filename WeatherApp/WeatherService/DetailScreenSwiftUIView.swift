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
            Text(viewModel.cityName)
                .font(.system(size: 35))
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Text(viewModel.temperature)
                .font(.system(size: 75))
                .bold()
            Text(viewModel.weatherIcon)
                .font(.system(size: 70))
                .padding()
            Text(viewModel.weatherDescription)
                .font(.system(size: 20))
                
        }.onAppear(perform: viewModel.refresh)
    }
        
    
        
}

struct DetailScreenSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreenSwiftUIView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}

