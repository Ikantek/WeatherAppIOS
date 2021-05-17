//
//  ContentView.swift
//  WeatherAppMZ
//
//  Created by Użytkownik Gość on 05/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        ScrollView(){
            VStack {
                ForEach(viewModel.records) {
                    record in WeatherView(record: record, viewModel: viewModel)
                }
            }.padding()
        }
    }
}

/*Więc jeśli chodzi ulozenie layouytu, no to mamy kolejno:
 - scrollview do przewijania w dol
 - pod nim vstack pozwalajacy nam na ulozenie komorek
 - nastepnie mamy zstack aby rzeczy nakladaly sie na siebie
 - Nastepnie tworzymy "komorke" o zadanych parametrach i wlasciwosiach
 - Nakladamy na to geometry readera aby moc ustawiac kompinenty w wybranych przez siebnie miejscach
 - Nastepnie ukladamy hstack aby elementy byly na tym samym poziomie
 - wrzucamy ikone pogody
 - ustawiamy sobie vstacka abt temperatura znajdowala sie pod miastem
 - wrzucamy ikone odswiezania*/
struct WeatherView: View {
    var record: WeatherModel.WeatherRecord
    var viewModel: WeatherViewModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).stroke().frame(height:100,alignment:.center)
            GeometryReader { geometry in            HStack {
                Text(verbatim: viewModel.getIcon(record: record)).font(.system(size: geometry.size.height * 0.3)).frame(width:         geometry.size.width * 0.15)
                VStack(alignment: .leading) {
                    Text(record.cityName)
                    Text("Temperature: \(record.temperature, specifier: "%.2f")'C")
                        .font(.caption)
                }.frame(width: geometry.size.width * 0.65)
                Text("🔁")
                    .font(.largeTitle)
                    .frame(height: geometry.size.height)
                    .onTapGesture {
                        viewModel.refresh(record: record)
                    }
            }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: WeatherViewModel())
    }
}
