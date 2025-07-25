//
//  AllStyle.swift
//  Pod Alarm
//
//  Created by Simone Pistecchia on 31/10/2020.
//

import SwiftUI











struct LinearP: View {
    //@Binding var value:Float
    @State var state: Int
    @Binding var stateB: String
    
    var body: some View {
                  
        
        VStack (spacing: 3){
            
            //Text("\(value)")
            Text("\(state)")
            Text(stateB)
        }
        
        
    }
}



