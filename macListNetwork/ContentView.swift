//
//  ContentView.swift
//  macListNetwork
//
//  Created by Angelos Staboulis on 24/6/25.
//

import SwiftUI
import CoreWLAN
import NetworkExtension
import Network
import SystemConfiguration.CaptiveNetwork
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var array: Set<Iterator.Element> = []
        return filter { array.insert($0).inserted }
    }
}
struct ContentView: View {
    let wifi = WifiManager()
    @State var listWifi:[String]
    var body: some View {
        VStack {
            Text("You are connected to Wifi").frame(width:600,height:45,alignment: .leading)
            Text(wifi.getConnectedWifi()).frame(width:600,height:5,alignment: .leading)
            HStack{
                Text("List Available Wifi").frame(width:295,height:45,alignment: .leading)
                Button {
                    if listWifi.count > 0 {
                        listWifi.removeAll()
                        listWifi = wifi.getListWifi().components(separatedBy: "\n").unique()
                    }
                } label: {
                    Text("Update List of Available Wifi")
                }.frame(width:300,height:45,alignment: .trailing)
            }.frame(width:600,height:45,alignment: .leading)
            List(listWifi,id:\.self){item in
                Text(item)
            }.onAppear {
                listWifi = wifi.getListWifi().components(separatedBy: "\n").unique()
            }
           
        }
        .padding()
        
        
        
    }
}

#Preview {
    ContentView(listWifi: .init())
}
