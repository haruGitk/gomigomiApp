//
//  SettingView.swift
//  gomiCalendar
//
//  Created by 天野優也 on 2022/03/04.
//

import SwiftUI

struct SettingView: View {
    @State private var showingModal = false
    
    var body: some View {
        Button(action: {
            self.showingModal.toggle()
        }) {
            Text("地域を\n設定する")
                .font(.callout)
                .foregroundColor(Color.white)
                .fontWeight(.bold)
                .frame(width: 100, height: 100)
                .background(Color.green)
                .clipShape(Circle())
        }.sheet(isPresented: $showingModal) {
            ModalView(showingModal: showingModal)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

struct ModalView: View {
    @State var prefecture: String = ""
    @State var city: String = ""
    @State var region: String = ""
    @State var block: String = ""
    @State var showingModal: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                VStack(alignment: .center, spacing: 25) {
                            Picker(selection: $prefecture, label: Text("都道府県")) {
                                ForEach(prefecturesData) {
                                    prefecture in
                                    Text(prefecture.name).tag(prefecture.name)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(height: 65)
                            .clipped()
                    TextField("市区町村", text: $city)
                    TextField("地区", text: $region)
                    TextField("丁目", text: $block)
                }
                .padding(20)
                .textFieldStyle(.roundedBorder)
                Button(action: {print("都道府県: \(prefecture), 市町村: \(city), 地域: \(region)" )})
                    {
                    Text("設定する")
                        .font(.footnote)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .frame(width: 70, height: 70)
                        .background(Color.green)
                        .clipShape(Circle())
                }

            }
                .navigationTitle("地域設定").navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(showingModal: true)
    }
}
