//
//  ContentView.swift
//  Calculyator
//
//  Created by Антон on 25.03.2021.
//

import SwiftUI

enum CalcButton: String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case substract = "-"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color{
        switch self{
        case .divide,.multiply,.substract,.add:
            return .orange
        case .clear,.negative,.percent:
            return Color(.lightGray)
        case .zero,.one,.two,.three,.four,.five,.six,.seven,.eight,.nine,.equal,.decimal:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation{
    case add, subctract, multiply, divide
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
   @State var currentOperation: Operation?
    
    let buttons: [[CalcButton]] = [
        [.clear,.negative,.percent,.divide],
        [.seven,.eight,.nine,.multiply],
        [.four,.five,.six,.substract],
        [.one,.two,.three,.add],
        [.zero,.decimal,.equal]
    ]
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                // text display
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()
                
                ForEach(buttons, id: \.self){ row in
                    HStack(spacing: 12){
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 40))
                                    .frame(width: self.buttonWidth(item: item),
                                           height: self.buttonHeight())
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonHeight() / 2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    //MARK: - Actions
    
    private  func didTap(button: CalcButton) {
        switch button {
        case .clear:
            return value = "0"
        case .add,.multiply,.substract,.equal,.divide:
            if button == .add{
                currentOperation = .add
                runningNumber = Int(value) ?? 0
            }
          else  if button == .multiply{
                currentOperation = .multiply
                runningNumber = Int(value) ?? 0
            }
           else if button == .substract{
                currentOperation = .subctract
                runningNumber = Int(value) ?? 0
            }
            else if button == .divide{
                currentOperation = .divide
                runningNumber = Int(value) ?? 0
            }
            else if button == .equal{
                let runningValue = runningNumber
                let currentValue = Int(value) ?? 0
                switch self.currentOperation{
                case .add: return value = "\(runningValue + currentValue)"
                case .multiply : return value = "\(runningValue * currentValue)"
                case .subctract : return value = "\(runningValue - currentValue)"
                case .divide: return value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            if button != .equal{
                value = "0"
            }
        case .negative,.percent,.decimal:
            break
        default:
            if value == "0"{
                value = button.rawValue
            }else{
                value = value + button.rawValue
            }
        }
       
        
    }
  private  func buttonWidth(item: CalcButton) -> CGFloat{
    if item == .zero{
        return self.buttonHeight() * 2 + 12
    }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    private func buttonHeight() -> CGFloat{
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
