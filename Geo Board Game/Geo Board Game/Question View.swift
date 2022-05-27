//
//  Question View.swift
//  Geo Board Game
//
//  Created by Eoin Shearer on 5/15/22.
//

import SwiftUI

struct QuestionView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var questions: [Question] = [Question(title: "Political Geography", Question: "The policies at the US/Mexico Border is what type of border dispute?", AnswerChoice1: "Positional", AnswerChoice2: "Territorial", AnswerChoice3: "Resource", AnswerChoice4: "Functional", Answer: 4), Question(title: "Political Geography", Question: "What is the difference between a perforated border, and a fragmented border?", AnswerChoice1: "A perforated border is where one state completely surrounds another state, while a fragmented border is where several disconnected pieces of a state are separated by water or another state.", AnswerChoice2: "A perforated border is where several disconnected pieces of a state are separated by water or another state, while a fragmented border is where one state completely surrounds another state.", AnswerChoice3: "A perforated border has a large projecting extension, while a fragmented border is where one state completely surrounds another state.", AnswerChoice4: "They are the same.", Answer: 1), Question(title: "Political Geography", Question: "What is an advantage of a Democracy?", AnswerChoice1: "Citizens elect leaders.", AnswerChoice2: "Citizens can run for office and hold power.", AnswerChoice3: "There are checks and balances that limit a leader’s power.", AnswerChoice4: "All of the above.", Answer: 4), Question(title: "Political Geography", Question: "What is an advantage of an Autocracy?", AnswerChoice1: "Citizens elect leaders.", AnswerChoice2: "Decisions can be made very quickly.", AnswerChoice3: "There are checks and balances that limit a leader’s power.", AnswerChoice4: "All of the above.", Answer: 2), Question(title: "Political Geography", Question: "What is an advantage of a larger state in comparison to a smaller one?", AnswerChoice1: "Near shipping routes.", AnswerChoice2: "May be more unified.", AnswerChoice3: "Has more valuable resources.", AnswerChoice4: "Power is held by the national government alone.", Answer: 3), Question(title: "Political Geography", Question: "What is a Relic boundary?", AnswerChoice1: "It is a border that uses latitude or longitude to determine the location of the boundary.", AnswerChoice2: "It is a border that follows the distribution of a human/cultural trait.", AnswerChoice3: "It is a border that no longer serves as a state boundary.", AnswerChoice4: "It is a border that follows a feature of the natural landscape.", Answer: 3), Question(title: "Political Geography", Question: "Which of the following is an example of a Stateless Nation?", AnswerChoice1: "North Korea", AnswerChoice2: "Palestinians", AnswerChoice3: "Yugoslavia", AnswerChoice4: "United Kingdom", Answer: 2), Question(title: "Political Geography", Question: "Which type of Territorial Morphology resembles a dotted line?", AnswerChoice1: "Compact", AnswerChoice2: "Perforated", AnswerChoice3: "Elongated", AnswerChoice4: "Fragmented", Answer: 4), Question(title: "Political Geography", Question: "Give an example of a physical boundary:", AnswerChoice1: "50 U.S. states", AnswerChoice2: "North & South Korea separated by 38*N", AnswerChoice3: "Great Wall of China", AnswerChoice4: "Himalaya Mountains", Answer: 4), Question(title: "Political Geography", Question: "What is an example of a Monarchy?", AnswerChoice1: "Italy", AnswerChoice2: "North Korea", AnswerChoice3: "China", AnswerChoice4: "Denmark", Answer: 4), Question(title: "Economic Geography", Question: "What is a Traditional economy?", AnswerChoice1: "Land and businesses can be privately owned.", AnswerChoice2: "Customs determine what is produced and how it is produced.", AnswerChoice3: "The Government controls major industries; some businesses are privately owned.", AnswerChoice4: "The government makes all economic decisions.", Answer: 2), Question(title: "Economic Geography", Question: "What is a factor of production?", AnswerChoice1: "Land", AnswerChoice2: "Needs", AnswerChoice3: "Wants", AnswerChoice4: "Scarcity", Answer: 1), Question(title: "Economic Geography", Question: "Which of the following is an example of the tertiary sector of the economy?", AnswerChoice1: "Making a pot out of clay, turning iron ore into steel, or pasteurizing milk to be bottled.", AnswerChoice2: "Fishing, forestry, drilling, mining, or farming.", AnswerChoice3: "Research, data analysis, marketing, or product design.", AnswerChoice4: "Doctors, lawyers, teachers, store clerks, or truckers.", Answer: 4), Question(title: "Economic Geography", Question: "What was the Industrial Revolution?", AnswerChoice1: "When civilization started.", AnswerChoice2: "When Europeans started farming.", AnswerChoice3: "When the improvements in technology that transformed the process of manufacturing goods.", AnswerChoice4: "When Europeans made guns.", Answer: 3), Question(title: "Economic Geography", Question: "Give an example of a Pre-Industrial state:", AnswerChoice1: "Mexico", AnswerChoice2: "Cuba", AnswerChoice3: "Indonesia", AnswerChoice4: "None of the above", Answer: 4), Question(title: "Economic Geography", Question: "What is a Post-Industrial State?", AnswerChoice1: "When states started mass producing goods.", AnswerChoice2: "When states switched to traditional economies.", AnswerChoice3: "When states switched to mostly service sector jobs.", AnswerChoice4: "When states started urban manufacturing.", Answer: 3), Question(title: "Economic Geography", Question: "Where are most of our goods manufactured today?", AnswerChoice1: "North America", AnswerChoice2: "Latin America", AnswerChoice3: "Africa", AnswerChoice4: "Asia", Answer: 4), Question(title: "Economic Geography", Question: "Where are most products designed today?", AnswerChoice1: "China", AnswerChoice2: "United States", AnswerChoice3: "Mexico", AnswerChoice4: "South Africa", Answer: 2), Question(title: "Economic Geography", Question: "What is a requirement for a state to join the EU?", AnswerChoice1: "They must go through the Brexit process.", AnswerChoice2: "They must be a Eastern European country.", AnswerChoice3: "They must have a stable democracy.", AnswerChoice4: "They must trade with Russia.", Answer: 3), Question(title: "Economic Geography", Question: "What is a Tariff?", AnswerChoice1: "When a state starts mass producing goods.", AnswerChoice2: "When production costs are too high in developed countries.", AnswerChoice3: "When a state imposes a tax on goods imported from another country.", AnswerChoice4: "When Brintan goes through Brexit.", Answer: 3)]
    @State var question: Question = Question(title: "", Question: "", AnswerChoice1: "", AnswerChoice2: "", AnswerChoice3: "", AnswerChoice4: "", Answer: 0)
    @State var correct: Bool = false
    @State var showing: Bool = false
    @State var dismissCurrent: Bool = false
    @State private var showingRebellionAlert = false
    @State private var timeout = false
    @State private var showingLost = false
    var action: String
    var user: String
    @Binding var countrys: [Country]
    var country: Country
    @State var selected = 0
    @State var circleRemove: CGFloat = 1.00
    @State var revealedAnswer = 0
    @State var timeRemaining = 10.00
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        NavigationView(content: {
            ScrollView(content: {
                VStack {
                    HStack {
                        Text(question.Question)
                            .padding()
                            .font(.title2)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    HStack {
                        Circle()
                            .trim(from: 0, to: circleRemove)
                            .stroke(timeRemaining > 5 ? .green : .red, lineWidth: 5)
                            .frame(width: 20, height: 20)
                            .rotationEffect(.degrees(-90))
                            .padding(.horizontal)
                        Text("Time Remaining: \(Int(timeRemaining))")
                            .font(.caption)
                            .foregroundColor(timeRemaining > 5 ? .green : .red)
                        Spacer()
                    }
                    Button(action: {
                        if revealedAnswer == 0 {
                            selected = 1
                        }
                    }, label: {
                        HStack {
                            Image(systemName: selected == 1 ? "circle.circle.fill" : "circle")
                                .padding(.leading)
                                .if(revealedAnswer == 1 && revealedAnswer != 0) { $0.foregroundColor(.green) }
                                .if(revealedAnswer != 1 && revealedAnswer != 0) { $0.foregroundColor(.red) }
                            Text("A. \(question.AnswerChoice1)")
                                .padding()
                                .font(.title3)
                                .multilineTextAlignment(.leading)
                                .if(revealedAnswer == 1 && revealedAnswer != 0) { $0.foregroundColor(.green) }
                                .if(revealedAnswer != 1 && revealedAnswer != 0) { $0.foregroundColor(.red) }
                            Spacer()
                        }
                        .foregroundColor(selected == 1 ? .blue : .gray)
                    })
                    .disabled(revealedAnswer != 0)
                    Button(action: {
                        if revealedAnswer == 0 {
                            selected = 2
                        }
                    }, label: {
                        HStack {
                            Image(systemName: selected == 2 ? "circle.circle.fill" : "circle")
                                .padding(.leading)
                                .if(revealedAnswer == 2 && revealedAnswer != 0) { $0.foregroundColor(.green) }
                                .if(revealedAnswer != 2 && revealedAnswer != 0) { $0.foregroundColor(.red) }
                            Text("B. \(question.AnswerChoice2)")
                                .padding()
                                .font(.title3)
                                .multilineTextAlignment(.leading)
                                .if(revealedAnswer == 2 && revealedAnswer != 0) { $0.foregroundColor(.green) }
                                .if(revealedAnswer != 2 && revealedAnswer != 0) { $0.foregroundColor(.red) }
                            Spacer()
                        }
                        .foregroundColor(selected == 2 ? .blue : .gray)
                    })
                    .disabled(revealedAnswer != 0)
                    Button(action: {
                        if revealedAnswer == 0 {
                            selected = 3
                        }
                    }, label: {
                        HStack {
                            Image(systemName: selected == 3 ? "circle.circle.fill" : "circle")
                                .padding(.leading)
                                .if(revealedAnswer == 3 && revealedAnswer != 0) { $0.foregroundColor(.green) }
                                .if(revealedAnswer != 3 && revealedAnswer != 0) { $0.foregroundColor(.red) }
                            Text("C. \(question.AnswerChoice3)")
                                .padding()
                                .font(.title3)
                                .multilineTextAlignment(.leading)
                                .if(revealedAnswer == 3 && revealedAnswer != 0) { $0.foregroundColor(.green) }
                                .if(revealedAnswer != 3 && revealedAnswer != 0) { $0.foregroundColor(.red) }
                            Spacer()
                        }
                        .foregroundColor(selected == 3 ? .blue : .gray)
                    })
                    .disabled(revealedAnswer != 0)
                    Button(action: {
                        if revealedAnswer == 0 {
                            selected = 4
                        }
                    }, label: {
                        HStack {
                            Image(systemName: selected == 4 ? "circle.circle.fill" : "circle")
                                .padding(.leading)
                                .if(revealedAnswer == 4 && revealedAnswer != 0) { $0.foregroundColor(.green) }
                                .if(revealedAnswer != 4 && revealedAnswer != 0) { $0.foregroundColor(.red) }
                            Text("D. \(question.AnswerChoice4)")
                                .padding()
                                .font(.title3)
                                .multilineTextAlignment(.leading)
                                .if(revealedAnswer == 4 && revealedAnswer != 0) { $0.foregroundColor(.green) }
                                .if(revealedAnswer != 4 && revealedAnswer != 0) { $0.foregroundColor(.red) }
                            Spacer()
                        }
                        .foregroundColor(selected == 4 ? .blue : .gray)
                    })
                    .disabled(revealedAnswer != 0)
                    HStack {
                        Spacer()
                        Button(action: {
                            if revealedAnswer == 0 {
                                revealedAnswer = question.Answer
                                if selected == revealedAnswer {
                                    correct = true
                                }
                                else {
                                    correct = false
                                }
                            }
                            else {
                                if action == "buy" && correct == true {
                                    showing.toggle()
                                }
                                else {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }, label: {
                            HStack {
                                Text(revealedAnswer == 0 ? "Submit Answer" : "Continue")
                                Image(systemName: "chevron.right")
                            }
                        })
                        .foregroundColor(selected == 0 ? .gray : .blue)
                        .disabled(selected == 0)
                        .padding(.trailing)
                    }
                    .padding(.bottom)
                    if action == "buy" {
                        Button(action: {
                            showingRebellionAlert.toggle()
                        }, label: {
                            HStack {
                                Text("Rebellion")
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
                        })
                        Text("This will automatically charge you \(country.currency)5,000 if you have more than \(country.currency)2,500, and you have landed on the Rebellion square. Otherwise you will have lost the game.")
                            .font(.caption)
                            .padding()
                        Button(action: {
                            var money = "-500"
                            if country.name == countrys[countrys.endIndex - 1].name {
                                countrys[countrys.endIndex - 1].transactionHistory += [CountryTransaction(name: "Colonial Tariff", amount: Double(money)!, reason: "Colonial Tariff", player: country.name)]
                                countrys[countrys.endIndex - 1].amountOfMoney += Double(money)!
                                
                                money = money.replacingOccurrences(of: "-", with: "")
                                countrys[0].transactionHistory += [CountryTransaction(name: "Tariff Payment", amount: Double(money)!, reason: "Tariff Payment", player: country.name)]
                                countrys[0].amountOfMoney += Double(money)!
                                presentationMode.wrappedValue.dismiss()
                            }
                            else if country.name == countrys[0].name {
                                countrys[0].transactionHistory += [CountryTransaction(name: "Colonial Tariff", amount: Double(money)!, reason: "Colonial Tariff", player: country.name)]
                                countrys[0].amountOfMoney += Double(money)!
                                
                                money = money.replacingOccurrences(of: "-", with: "")
                                countrys[1].transactionHistory += [CountryTransaction(name: "Tariff Payment", amount: Double(money)!, reason: "Tariff Payment", player: country.name)]
                                countrys[1].amountOfMoney += Double(money)!
                                presentationMode.wrappedValue.dismiss()
                            }
                        }, label: {
                            HStack {
                                Text("Pay Colonial Tariff - Cost \(country.currency)500")
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
                        })
                        Text("Colonial Tariffs are only for locations that are not the Suez Canal, Mediterranean Sea, English Channel, the Cape of Good Hope, Singapore, Australia, Jamaica, Barbados, Egypt, Gold Coast, India, Question Squares, Start Square, Rebellion Square, and Hong Kong.")
                            .font(.caption)
                            .padding()
                        Button(action: {
                            var money = "-1000"
                            if country.name == countrys[countrys.endIndex - 1].name {
                                countrys[countrys.endIndex - 1].transactionHistory += [CountryTransaction(name: "Royal Tariff", amount: Double(money)!, reason: "Royal Tariff", player: country.name)]
                                countrys[countrys.endIndex - 1].amountOfMoney += Double(money)!
                                
                                money = money.replacingOccurrences(of: "-", with: "")
                                countrys[0].transactionHistory += [CountryTransaction(name: "Tariff Payment", amount: Double(money)!, reason: "Tariff Payment", player: country.name)]
                                countrys[0].amountOfMoney += Double(money)!
                                
                                presentationMode.wrappedValue.dismiss()
                            }
                            else if country.name == countrys[0].name {
                                countrys[0].transactionHistory += [CountryTransaction(name: "Royal Tariff", amount: Double(money)!, reason: "Royal Tariff", player: country.name)]
                                countrys[0].amountOfMoney += Double(money)!
                                
                                money = money.replacingOccurrences(of: "-", with: "")
                                countrys[1].transactionHistory += [CountryTransaction(name: "Tariff Payment", amount: Double(money)!, reason: "Tariff Payment", player: country.name)]
                                countrys[1].amountOfMoney += Double(money)!
                                presentationMode.wrappedValue.dismiss()
                            }
                        }, label: {
                            HStack {
                                Text("Pay Royal Tariff - Cost \(country.currency)1000")
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
                        })
                        Text("Royal Tariffs are only for Singapore, Australia, Jamaica, Barbados, Egypt, Gold Coast, India, and Hong Kong.")
                            .font(.caption)
                            .padding()
                        Button(action: {
                            var money = "-1500"
                            if country.name == countrys[countrys.endIndex - 1].name {
                                countrys[countrys.endIndex - 1].transactionHistory += [CountryTransaction(name: "Transfer Tariff", amount: Double(money)!, reason: "Transfer Tariff", player: country.name)]
                                countrys[countrys.endIndex - 1].amountOfMoney += Double(money)!
                                
                                money = money.replacingOccurrences(of: "-", with: "")
                                countrys[0].transactionHistory += [CountryTransaction(name: "Tariff Payment", amount: Double(money)!, reason: "Tariff Payment", player: country.name)]
                                countrys[0].amountOfMoney += Double(money)!
                                
                                presentationMode.wrappedValue.dismiss()
                            }
                            else if country.name == countrys[0].name {
                                countrys[0].transactionHistory += [CountryTransaction(name: "Transfer Tariff", amount: Double(money)!, reason: "Transfer Tariff", player: country.name)]
                                countrys[0].amountOfMoney += Double(money)!
                                
                                money = money.replacingOccurrences(of: "-", with: "")
                                countrys[1].transactionHistory += [CountryTransaction(name: "Tariff Payment", amount: Double(money)!, reason: "Tariff Payment", player: country.name)]
                                countrys[1].amountOfMoney += Double(money)!
                                presentationMode.wrappedValue.dismiss()
                            }
                        }, label: {
                            HStack {
                                Text("Pay Transfer Tariff - Cost \(country.currency)1500")
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
                        })
                        Text("Transfer Tariffs are only for the Suez Canal, Mediterranean Sea, English Channel, and the Cape of Good Hope.")
                            .font(.caption)
                            .padding()
                    }
                }
                .navigationTitle(Text(question.title))
            })
        })
        .onReceive(timer) { time in
            if selected == 0 {
                if timeRemaining > 1 {
                    timeRemaining -= 1
                    circleRemove = (timeRemaining / 1) / 10.00
                    print(circleRemove)
                }
                else {
                    if timeout != true {
                        timeout.toggle()
                    }
                }
            }
        }
        .sheet(isPresented: $showing, content: {
            NavigationView {
                listItems(countrys: $countrys, stop: $dismissCurrent, country: country)
                    .navigationBarTitle(Text("Territories"))
            }
        })
        .onAppear(perform: {
            question = questions[Int.random(in: 0 ... (questions.endIndex - 1))]
        })
        .onChange(of: dismissCurrent, perform: { val in
            presentationMode.wrappedValue.dismiss()
        })
        .alert("Are you sure you are in a Rebellion?", isPresented: $showingRebellionAlert) {
            Button("Yes", role: .destructive) {
                if country.amountOfMoney < -2500 {
                    showingLost.toggle()
                }
                else {
                    let money = "-5000"
                    if country.name == countrys[countrys.endIndex - 1].name {
                        countrys[countrys.endIndex - 1].transactionHistory += [CountryTransaction(name: "Rebellion", amount: Double(money)!, reason: "Rebellion", player: country.name)]
                        countrys[countrys.endIndex - 1].amountOfMoney += Double(money)!
                        presentationMode.wrappedValue.dismiss()
                    }
                    else if country.name == countrys[0].name {
                        countrys[0].transactionHistory += [CountryTransaction(name: "Rebellion", amount: Double(money)!, reason: "Rebellion", player: country.name)]
                        countrys[0].amountOfMoney += Double(money)!
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            Button("No", role: .cancel) {}
        }
        .alert("You Lose", isPresented: $showingLost) {
            Button("I lost", role: .cancel) {
                UserDefaults.resetStandardUserDefaults()
            }
        }
        .alert("Time's up!", isPresented: $timeout) {
            Button("End My Turn", role: .cancel) {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) }
        else { self }
    }
}

struct Question: Hashable {
    var id = UUID().uuidString
    var title: String
    var Question: String
    var AnswerChoice1: String
    var AnswerChoice2: String
    var AnswerChoice3: String
    var AnswerChoice4: String
    var Answer: Int
}
