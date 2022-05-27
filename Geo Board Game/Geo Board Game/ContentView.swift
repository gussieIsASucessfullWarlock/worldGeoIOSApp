//
//  ContentView.swift
//  Geo Board Game
//
//  Created by Eoin Shearer on 5/10/22.
//

import SwiftUI

var territories: [Territory] = [Territory(name: "India", cost: -3000.00), Territory(name: "Hong Kong", cost: -3000.00), Territory(name: "Burma", cost: -1500.00), Territory(name: "Suez Cannel", cost: -5000.00), Territory(name: "Vietnam", cost: -1500.00), Territory(name: "Laos", cost: -1500.00), Territory(name: "Cambodia", cost: -1500.00), Territory(name: "Gold Coast", cost: -3000.00), Territory(name: "Egypt", cost: -3000.00), Territory(name: "Morocco", cost: -1500.00),  Territory(name: "Mediterranean Sea", cost: -5000.00), Territory(name: "Cape Colony", cost: -1500.00), Territory(name: "Madagascar", cost: -1500.00), Territory(name: "Sudan", cost: -1500.00), Territory(name: "Barbados", cost: -3000.00), Territory(name: "Jamaica", cost: -3000.00), Territory(name: "Bahamas", cost: -1500.00), Territory(name: "English Channel", cost: -5000.00), Territory(name: "Haiti", cost: -1500.00), Territory(name: "Quebec", cost: -1500.00), Territory(name: "British Columbia", cost: -1500.00), Territory(name: "Australia", cost: -3000.00), Territory(name: "Singapore", cost: -3000.00), Territory(name: "New Zealand", cost: -1500.00), Territory(name: "Cape of Good Hope", cost: -5000.00), Territory(name: "Borneo", cost: -1500.00), Territory(name: "Fiji", cost: -1500.00), Territory(name: "New Guinea", cost: -1500.00), Territory(name: "Get Money", cost: 500.00), Territory(name: "Raid Another Player", cost: Double.random(in: 0.00 ... 2000.00))]

struct ContentView: View {
    @State var countryShowing = true
    @State var addUserShowing = false
    @State var questionUserShowing = false
    @State var name: String = ""
    @State var country: String = ""
    @State var countrys: [Country] = []
    @State var players: [Player] = []
    var country_list: [String] = ["France", "Britain"]
    @Namespace var animation
    var body: some View {
        NavigationView(content: {
            ScrollView(content: {
                VStack {
                    ForEach(countrys, id: \.self) { state in
                        CountryView(country: state, countrys: $countrys)
                    }
                    Button(action: {
                        questionUserShowing.toggle()
                    }, label: {
                        HStack {
                            Text(String("?"))
                                .padding()
                                .font(.title)
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                                .clipShape(Circle())
                            Text("Question")
                                .font(.title2)
                            Spacer()
                            Image(systemName: "chevron.up")
                        }
                        .padding(.horizontal)
                        .padding(.vertical,10)
                        .background(Color("BG").opacity(1))
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
                        .padding(.horizontal)
                        .padding(.top)
                    })
                }
                .sheet(isPresented: $questionUserShowing, content: {
                    QuestionView(action: "question", user: "", countrys: $countrys, country: countrys[0])
                        .interactiveDismissDisabled()
                })
            })
            .navigationViewStyle(.stack)
            .navigationTitle(Text("Dashboard"))
            .sheet(isPresented: $addUserShowing, content: {
                VStack {
                    Text("Available Soon")
                }
                .interactiveDismissDisabled()
            })
            .sheet(isPresented: $countryShowing, content: {
                countryCreation(name: $name, country: $country, countrys: $countrys, players: $players, animation: animation, country_list: country_list)
                    .interactiveDismissDisabled()
            })
            .onChange(of: countrys, perform: { newVal in
                if countrys[0] != nil {
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(countrys[0]) {
                        let defaults = UserDefaults.standard
                        defaults.set(encoded, forKey: "Britain")
                    }
                    if let encoded = try? encoder.encode(countrys[1]) {
                        let defaults = UserDefaults.standard
                        defaults.set(encoded, forKey: "France")
                    }
                    if let encoded = try? encoder.encode(territories) {
                        let defaults = UserDefaults.standard
                        defaults.set(encoded, forKey: "territories")
                    }
                }
            })
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct countryCreation: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var name: String
    @Binding var country: String
    @Binding var countrys: [Country]
    @Binding var players: [Player]
    var animation: Namespace.ID
    var country_list: [String]
    var body: some View {
        NavigationView(content: {
            VStack {
                Spacer()
                ScrollView(content: {
                    VStack {
                        ForEach(players, id: \.self) { user in
                            PlayerView(player: user, players: $players)
                        }
                    }
                    Spacer()
                    CustomPicker(image: "flag", title: "Country Name", value: $name, data: country_list, animation: animation)
                        .padding(.bottom,5)
                        .onAppear(perform: {
                            print(countrys)
                        })
                    CustomTextField(image: "cart", title: "Player Name", value: $country, animation: animation)
                        .padding(.bottom,5)
                    HStack {
                        Spacer()
                        Button(action: {
                            if name == "France" {
                                players.append(Player(name: country, countryID: 1, diceHistory: [], ownes: []))
                            }
                            else {
                                players.append(Player(name: country, countryID: 2, diceHistory: [], ownes: []))
                            }
                            name = ""
                            country = ""
                        }, label: {
                            HStack {
                                Text("Add")
                                Image(systemName: "chevron.right")
                            }
                        })
                        .foregroundColor(Color.blue)
                        .opacity(name == "" || country == "" ? 0.5 : 1)
                        .disabled(name == "" || country == "")
                    }
                    .padding(.horizontal)
                    .padding(.horizontal)
                    .padding(.vertical,10)
                    Spacer()
                })
                if UserDefaults.standard.value(forKey: "Britain") != nil {
                    Button(action: {
                        let defaults = UserDefaults.standard
                        if let savedBritian = defaults.object(forKey: "Britain") as? Data {
                            if let savedFrance = defaults.object(forKey: "France") as? Data {
                                if let UnCodedterritories = defaults.object(forKey: "territories") as? Data {
                                    let decoder = JSONDecoder()
                                    if let Britian = try? decoder.decode(Country.self, from: savedBritian) {
                                        if let France = try? decoder.decode(Country.self, from: savedFrance) {
                                            if let oldTerritories = try? decoder.decode([Territory].self, from: UnCodedterritories) {
                                                territories = oldTerritories
                                                countrys.append(Britian)
                                                countrys.append(France)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack {
                            Text("Continue Saved Game")
                                .font(.title3)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.blue)
                        }
                        .padding(.horizontal)
                        .padding(.vertical,10)
                        .background(Color("BG").opacity(1))
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
                        .padding(.horizontal)
                        .padding(.top)
                    })
                    .padding()
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        var France: [Player] = []
                        var Britain: [Player] = []
                        let pounds = Double(round(100 * Double.random(in: 10000 ... 20000)) / 100)
                        let franks = Double(round(100 * Double.random(in: 10000 ... 20000)) / 100)
                        for i in players {
                            if i.countryID == 1 {
                                France += [i]
                            }
                            else {
                                Britain += [i]
                            }
                        }
                        countrys.append(Country(name: "Britain", countryID: 2, currency: "£", amountOfMoney: pounds, transactionHistory: [CountryTransaction(name: "Starting Amount", amount: pounds, reason: "Start", player: "Computer")], players: Britain))
                        countrys.append(Country(name: "France", countryID: 1, currency: "₣", amountOfMoney: franks, transactionHistory: [CountryTransaction(name: "Starting Amount", amount: franks, reason: "Start", player: "Computer")], players: France))
                        close()
                    }, label: {
                        HStack {
                            Text("Done")
                            Image(systemName: "chevron.right")
                        }
                    })
                    .opacity(countrys.count >= 2 ? 0.5 : 1)
                    .disabled(countrys.count > 1)
                    .foregroundColor(Color.blue)
                }
                .padding(.horizontal)
                .padding(.horizontal)
                .padding(.vertical,10)
            }
            .navigationTitle("Add Players")
        })
    }
    func close() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct PlayerView: View {
    var player: Player
    @Binding var players: [Player]
    var body: some View {
        HStack {
            Image(player.countryID == 1 ? "France" : "Britain")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            Text(player.name)
                .font(.title2)
                .padding(.leading, 15)
            Spacer()
            Button(action: {
                var count = 0
                for i in players {
                    if i.id == player.id {
                        players.remove(at: count)
                    }
                    count += 1
                }
            }, label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            })
        }
        .padding(.horizontal)
        .padding(.vertical,10)
        .background(Color("BG").opacity(1))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
        .padding(.horizontal)
        .padding(.top)
        .animation(.linear)
    }
}

struct StateDetail: View {
    @Environment(\.presentationMode) var presentationMode
    @State var country: Country
    @Binding var countrys: [Country]
    @State var user: String = ""
    @State var showing = false
    var body: some View {
        ScrollView(content: {
            Text("\(country.currency)\(String(format: "%.2f", round(100 * country.amountOfMoney) / 100))")
                .font(.title)
                .frame(height: UIScreen.main.bounds.height / 5)
            HStack {
                Text("Players:")
                    .padding()
                Spacer()
            }
            ForEach(country.players, id: \.self) { player in
                HStack {
                    Text(String(player.name.first!))
                        .padding()
                        .font(.title)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                    Text(player.name)
                        .font(.title2)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical,10)
                .background(Color("BG").opacity(1))
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
                .padding(.horizontal)
                .padding(.top)
                .animation(.linear)
            }
            HStack {
                Text("Transactions:")
                    .padding()
                Spacer()
            }
            .onAppear(perform: {
                country.transactionHistory.sort {
                    $0.time > $1.time
                }
            })
            ForEach(country.transactionHistory, id: \.self) { transaction in
                
                HStack {
                    Text(String(transaction.name.first!))
                        .padding()
                        .font(.title)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                    Text("\(country.currency)\(String(format: "%.2f", Double(round(100 * transaction.amount) / 100))) - \(transaction.name)")
                        .font(.title2)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical,10)
                .background(Color("BG").opacity(1))
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
                .padding(.horizontal)
                .padding(.top)
                .animation(.linear)
                
            }
        })
        .navigationViewStyle(.stack)
        .navigationBarItems(trailing: Button(action: {
            showing.toggle()
        }, label: {
            Image(systemName: "plus")
        }))
        .sheet(isPresented: $showing, content: {
                QuestionView(action: "buy", user: user, countrys: $countrys, country: country)
        })
    }
}

struct CountryView: View {
    var country: Country
    @Binding var countrys: [Country]
    @State var active = false
    var body: some View {
        NavigationLink(isActive: $active, destination: {
            StateDetail(country: country, countrys: $countrys)
            .navigationTitle(Text(country.name))
        }, label: {
            HStack {
                Image(country.countryID == 1 ? "France" : "Britain")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                Text(country.name)
                    .font(.title2)
                    .padding(.leading, 15)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.blue)
            }
        })
        .padding(.horizontal)
        .padding(.vertical,10)
        .background(Color("BG").opacity(1))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
        .padding(.horizontal)
        .padding(.top)
        .animation(.linear)
    }
}

struct CustomTextField: View {
  
  // Fields...
  var image: String
  var title: String
  @Binding var value: String
  
  var animation: Namespace.ID
  
  var body: some View {
      
      VStack(spacing: 6){
          
          HStack(alignment: .bottom){
              
              Image(systemName: image)
                  .font(.system(size: 22))
                  .foregroundColor(value == "" ? Color.blue.opacity(0.5) : .blue)
                  .frame(width: 35)
              
              VStack(alignment: .leading, spacing: 6) {
                  
                  if value != ""{
                      
                      Text(title)
                          .font(.caption)
                          .fontWeight(.heavy)
                          .foregroundColor(value == "" ? Color.blue.opacity(0.5) : .blue)
                          .matchedGeometryEffect(id: title, in: animation)
                  }
                  
                  ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                      
                      if value == ""{
                          
                          Text(title)
                              .font(.caption)
                              .fontWeight(.heavy)
                              .foregroundColor(Color.blue.opacity(0.5))
                              .matchedGeometryEffect(id: title, in: animation)
                      }
                      
                      if title == "PASSWORD"{
                          
                          SecureField("", text: $value)
                      }
                      else{
                          TextField("", text: $value)
                          // For Phone Number...
                              .keyboardType(title == "Amount" ? .numberPad : .default)
                              .foregroundColor(value == "" ? Color.blue.opacity(0.5) : .blue)
                      }
                  }
              }
          }
          
          if value == ""{
              
              Rectangle()
                  .fill(.blue)
                  .frame(height: 0.5)
          }
      }
      .padding(.horizontal)
      .padding(.vertical,10)
      .background(Color("BG").opacity(value != "" ? 1 : 0))
      .cornerRadius(8)
      .shadow(color: Color.black.opacity(value == "" ? 0 : 0.1), radius: 5, x: 5, y: 5)
      .shadow(color: Color.black.opacity(value == "" ? 0 : 0.05), radius: 5, x: -5, y: -5)
      .padding(.horizontal)
      .padding(.top)
      .animation(.linear)
  }
}

struct CustomPicker: View {
  
  // Fields...
  var image: String
  var title: String
  @Binding var value: String
    var data: [String]

  var animation: Namespace.ID
  
  var body: some View {
      
      VStack(spacing: 6){
          
          HStack(alignment: .bottom){
              
              Image(systemName: image)
                  .font(.system(size: 22))
                  .foregroundColor(value == "" ? Color.blue.opacity(0.5) : .blue)
                  .frame(width: 35)
              
              VStack(alignment: .leading, spacing: 6) {
                  
                  if value != ""{
                      
                      Text(title)
                          .font(.caption)
                          .fontWeight(.heavy)
                          .foregroundColor(value == "" ? Color.blue.opacity(0.5) : .blue)
                          .matchedGeometryEffect(id: title, in: animation)
                  }
                  
                  ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                      Menu(content: {
                          ForEach(data, id: \.self) { State in
                              Button(action: {
                                  value = State
                              }, label: {
                                  Text(State)
                              })
                          }
                      }, label: {
                          Text(value == "" ? title : value)
                              .font(value == "" ? .caption : .body)
                              .fontWeight(.heavy)
                              .foregroundColor(value == "" ? Color.blue.opacity(0.5) : .blue)
                      })
                  }
              }
              
              Spacer()
          }
          
          if value == ""{
              
              Rectangle()
                  .fill(.blue)
                  .frame(height: 0.5)
          }
      }
      .padding(.horizontal)
      .padding(.vertical,10)
      .background(Color("BG").opacity(value != "" ? 1 : 0))
      .cornerRadius(8)
      .shadow(color: Color.black.opacity(value == "" ? 0 : 0.1), radius: 5, x: 5, y: 5)
      .shadow(color: Color.black.opacity(value == "" ? 0 : 0.05), radius: 5, x: -5, y: -5)
      .padding(.horizontal)
      .padding(.top)
      .animation(.linear)
  }
}

struct moneyPad: View {
    @Environment(\.presentationMode) var presentationMode
    @State var money: String = ""
    @State var specks: String = ""
    @State var user: String = ""
    @State var showing = false
    @Binding var countrys: [Country]
    var country: Country
    @Namespace var animation
    var body: some View {
        VStack {
            Spacer()
            CustomPicker(image: "notes", title: "Specification", value: $specks, data: ["Rebellion"], animation: animation)
            CustomTextField(image: "person", title: "User", value: $user, animation: animation)
            CustomTextField(image: "banknote", title: "Amount", value: $money, animation: animation)
            HStack {
                Button(action: {
                    if country == countrys[countrys.endIndex - 1] {
                        countrys[countrys.endIndex - 1].transactionHistory += [CountryTransaction(name: specks, amount: Double(money)!, reason: specks, player: user)]
                        countrys[countrys.endIndex - 1].amountOfMoney += Double(money)!
                        presentationMode.wrappedValue.dismiss()
                    }
                    else if country == countrys[countrys.startIndex] {
                        countrys[countrys.startIndex - 1].transactionHistory += [CountryTransaction(name: specks, amount: Double(money)!, reason: specks, player: user)]
                        countrys[countrys.startIndex - 1].amountOfMoney += Double(money)!
                        presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    Text("Add")
                        .frame(width: UIScreen.main.bounds.width / 3.5, height: UIScreen.main.bounds.width / 12)
                        .padding()
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                        )
                })
                Button(action: {
                    money = "-\(money)"
                    if country == countrys[countrys.endIndex - 1] {
                        countrys[countrys.endIndex - 1].transactionHistory += [CountryTransaction(name: specks, amount: Double(money)!, reason: specks, player: user)]
                        countrys[countrys.endIndex - 1].amountOfMoney += Double(money)!
                        presentationMode.wrappedValue.dismiss()
                    }
                    else if country == countrys[0] {
                        countrys[countrys.startIndex - 1].transactionHistory += [CountryTransaction(name: specks, amount: Double(money)!, reason: specks, player: user)]
                        countrys[0].amountOfMoney += Double(money)!
                        presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    Text("Subtract")
                        .frame(width: UIScreen.main.bounds.width / 3.5, height: UIScreen.main.bounds.width / 12)
                        .padding()
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                        )
                })
            }
            .padding(.top)
            Spacer()
            Spacer()
        }
        .navigationBarItems(trailing: Button(action: {
            showing.toggle()
        }, label: {
            Image(systemName: "plus")
        }))
        .sheet(isPresented: $showing, content: {
        })
    }
}

struct listItems: View {
    @Binding var countrys: [Country]
    @Binding var stop: Bool
    @Environment(\.presentationMode) var presentationMode
    var country: Country
    
    var body: some View {
        ScrollView(content: {
            ForEach(territories, id: \.self) { territory in
                Button(action: {
                    var money = "\(territory.cost)"
                    if territory.name == "Raid Another Player" {
                        money = "\(Double.random(in: 0.00 ... 2000.00))"
                    }
                    print(countrys)
                    print(country)
                    if country.name == countrys[1].name {
                        countrys[1].transactionHistory += [CountryTransaction(name: territory.name, amount: Double(money)!, reason: territory.name, player: country.name)]
                        countrys[1].amountOfMoney += Double(money)!
                        
                        
                        if territory.name == "Raid Another Player" {
                            money = "-\(money)"
                            countrys[0].transactionHistory += [CountryTransaction(name: "Raid", amount: Double(money)!, reason: "Raid", player: country.name)]
                            countrys[0].amountOfMoney += Double(money)!
                        }
                        
                        if territory.name != "Raid Another Player" && territory.name != "Get Money" {
                            let name = territory.name
                            let list = territories
                            territories = []
                            for i in list {
                                if name != i.name {
                                    territories.append(i)
                                }
                            }
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                        stop.toggle()
                    }
                    else if country.name == countrys[0].name {
                        countrys[0].transactionHistory += [CountryTransaction(name: territory.name, amount: Double(money)!, reason: territory.name, player: country.name)]
                        countrys[0].amountOfMoney += Double(money)!
                        
                        
                        if territory.name == "Raid Another Player" {
                            money = "-\(money)"
                            countrys[1].transactionHistory += [CountryTransaction(name: "Raid", amount: Double(money)!, reason: "Raid", player: country.name)]
                            countrys[1].amountOfMoney += Double(money)!
                        }
                        
                        if territory.name != "Raid Another Player" && territory.name != "Get Money" {
                            let name = territory.name
                            let list = territories
                            territories = []
                            for i in list {
                                if name != i.name {
                                    territories.append(i)
                                }
                            }
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                        stop.toggle()
                    }
                }, label: {
                    HStack {
                        Text(String(territory.cost).contains("-") ? "\(territory.name) - Cost: \(country.currency)\(territory.name == "Raid Another Player" ? "Cost Varies" : String(territory.cost).replacingOccurrences(of: "-", with: ""))" : "\(territory.name) - Get: \(country.currency)\(territory.name == "Raid Another Player" ? "Varies" : String(territory.cost).replacingOccurrences(of: "-", with: ""))")
                                .font(.title3)
                        Spacer()
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal)
                    .padding(.vertical,10)
                    .background(Color("BG").opacity(1))
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
                    .padding(.horizontal)
                    .padding(.top)
                    .animation(.linear)
                })
                .disabled(country.amountOfMoney + territory.cost < -5000 && territory.name != "Raid Another Player" && territory.name != "Get Money")
            }
        })
    }
}

