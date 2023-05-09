//
//  ContentView.swift
//  Training
//
//  Created by Egor Ivanov on 05.05.2023.
//

import SwiftUI

struct ContentView: View {
    
    enum screenConditions : String {
        case today
        case doctor
        case media
    }
    
    @State var screen : String = screenConditions.today.rawValue // Screen switcher
    
    let palette = Colors()
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                    switch screen {
                    case screenConditions.today.rawValue:
                        TopSide()
                        ScrollView(.vertical, showsIndicators: false) {
                            SliderBar()
                            EmojiBarsBuilder()
                                .padding()
                            SliderBar()
                                .opacity(0.45)
                        }
                    case screenConditions.doctor.rawValue:
                        ProgressScreen()
                    default:
                        ProgressScreen()
                    }
                HStack {
                    BottomSide(opacity: screen == screenConditions.doctor.rawValue ? 1 : 0.5,
                               image: "stetho",
                               text: "At the doctor",
                               navigate: screenConditions.doctor.rawValue,
                               screen: $screen)
                    BottomSide(opacity: screen == screenConditions.today.rawValue ? 1 : 0.5,
                               image: "calendar",
                               text: "Today",
                               navigate: screenConditions.today.rawValue,
                               screen: $screen)
                    BottomSide(opacity: screen == screenConditions.media.rawValue ? 1 : 0.5,
                               image: "tv",
                               text: "Media",
                               navigate: screenConditions.media.rawValue, screen: $screen)
                }
            }
        }
    }
}

// MARK: Builded up parts

struct ProgressScreen : View {
    var body: some View {
        ZStack {
            Rectangle()
            ProgressView()
                .tint(Color.red)
                .scaleEffect(8)
        }
    }
}


struct BottomSide : View {
    let opacity : Double
    let image : String
    let text : String
    let navigate : String
    @Binding var screen : String
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 50)
                .frame(width: 110, height: 5)
                .foregroundColor(.white)
                .opacity(opacity)
            Button {
                withAnimation(.easeInOut) {
                    screen = navigate
                }
            } label: {
                HStack {
                    Image(image)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .opacity(opacity)
                    Text(text)
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .opacity(opacity)
                }.frame(width: 110, height: 20)
            }.buttonStyle(.borderless)
        }
    }
}

struct SliderBar : View {
    @State var position : Int = 0
    let titleArray : [String] = ["Fingers", "Nothing", "Nothing", "Nothing", "Nothing"]
    let infoArray : [String] = ["The fingers and toes are becoming properly separated losing ny webbing.\nThe fingers and toes are becoming properly separated, losing any webbing.", "Nothing", "Nothing", "Nothing", "Nothing"]
    let palette = Colors()
    var body: some View {
        VStack {
            Title()
            TabView(selection: $position) {
                ForEach(titleArray.indices, id: \.self) { indexRow in
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(palette.beige)
                            .frame(width: 341, height: 216) // Frame of inner rectangle
                            .padding()
                        VStack(spacing: 0) {
                            Text(titleArray[indexRow])
                                .bold()
                                .foregroundColor(.white)
                                .font(.system(size: 32))
                            Text(infoArray[indexRow])
                                .frame(width: 300, height: 100)
                                .font(.system(size: 16))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                            
                        }
                    }
                    .tag(indexRow)
                }
            }
            .frame(width: 350, height: 216) // Frame of tabView
            .onChange(of: position, perform: { newValue in
                print(newValue)
            })
            .tabViewStyle(.page(indexDisplayMode: .never))
            HStack {
                ForEach(0...4, id: \.self) { indexCircle in
                    Circles(opacity: position == indexCircle ? 1 : 0.3)
                }
            }
            .padding(.top, 20)
        }
    }
}

struct Circles : View {
    let opacity : Double
    var body: some View {
        Circle()
            .foregroundColor(.white)
            .frame(width: 10)
            .opacity(opacity)
    }
}

struct Title : View {
    let palette = Colors()
    var body: some View {
        HStack(spacing: 280) {
            Text("Title")
                .foregroundColor(.white)
                .font(.system(size: 30))
                .bold()
            Button {
                
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(palette.grey)
                        .frame(width: 30)
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                }
            }.buttonStyle(.borderless)
        }
    }
}

struct EmojiBarsBuilder : View {
    let palette = Colors()
    let emojiArray : [String] = ["😩", "😭", "😟", "😣", "😃", "😄"]
    let heightArray : [CGFloat] = [20, 50, 70, 20, 80, 95]
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(palette.darkest)
                .frame(width: 350, height: 200)
            VStack {
                Text("Mood breakdown")
                    .foregroundColor(.white)
                    .bold()
                    .font(.system(size: 24))
                    .frame(width: 330, alignment: .leading)
                    .padding(.leading, 40)
                HStack(spacing: 30) {
                    ForEach(emojiArray.indices, id: \.self) { indexing in
                        barLine(emoji: emojiArray[indexing], height: heightArray[indexing])
                    }
                }
            }
        }
    }
}

struct barLine : View {
    let emoji : String
    let height : CGFloat
    let palette = Colors()
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 50)
                    .foregroundColor(palette.grey)
                    .frame(width: 8, height: 95)
                RoundedRectangle(cornerRadius: 50)
                    .foregroundColor(palette.orange)
                    .frame(width: 8, height: height)
                    .shadow(color: palette.orange, radius: 3)
            }
            Text(emoji)
        }
    }
}

struct TopSide : View {
    let palette = Colors()
    var body: some View {
        HStack(spacing: 90) {
            VStack(alignment: .leading) {
                Text("Today,")
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                Text(getDateFormatted()) // func for time.
                    .foregroundColor(.white)
                    .font(.system(size: 16))
            }
            ZStack {
                Circle()
                    .frame(width: 50)
                    .foregroundColor(palette.raspberry)
                Image("raspberry")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 33, height: 34)
                    .padding(.trailing, 3)
            }.padding(.trailing, 30)
            Button {
                // Here goes the action
            } label: {
                Image("settingsCircle")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25)
                    .foregroundColor(.white)
            }.buttonStyle(.borderless)
            
        }
        Divider()
            .overlay(.white)
    }
    func getDateFormatted() -> String {
        let date = Date()
        let calendar = Calendar.current
        let dayNum = calendar.component(.day, from: date)
        let monthNum = calendar.component(.month, from: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        let dayOfWeek = dateFormatter.string(from: date)
        return formatDate(day: dayNum, month: monthNum, name: dayOfWeek)
    }
    func formatDate(day : Int, month : Int, name : String) -> String {
        var Mymonth = ""
        switch month {
        case 1:
            Mymonth = "Jan"
        case 2:
            Mymonth = "Feb"
        case 3:
            Mymonth = "Mar"
        case 4:
            Mymonth = "Apr"
        case 5:
            Mymonth = "May"
        case 6:
            Mymonth = "Jun"
        case 7:
            Mymonth = "Jul"
        case 8:
            Mymonth = "Aug"
        case 9:
            Mymonth = "Sep"
        case 10:
            Mymonth = "Oct"
        case 11:
            Mymonth = "Nov"
        case 12:
            Mymonth = "Dec"
        default:
            Mymonth = "Nothing"
        }
        return String("\(name) \(day) \(Mymonth)")
    }
}

// MARK: Preview the build.

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
