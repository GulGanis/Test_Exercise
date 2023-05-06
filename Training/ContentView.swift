//
//  ContentView.swift
//  Training
//
//  Created by Egor Ivanov on 05.05.2023.
//

import SwiftUI

struct ContentView: View {
    let palette = Colors()
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                TopSide()
                Title()
                SliderBar()
                EmojiBarsBuilder()
                SliderBar()
                HStack {
                    BottomCollected()
                }
            }
        }
    }
}

// MARK: Builded up parts

struct BottomCollected : View {
    var body: some View {
        BottomSide(opacity: 0.5, image: "stethoscope", text: "At the doctor")
        BottomSide(opacity: 1, image: "calendar", text: "Today")
        BottomSide(opacity: 0.5, image: "tv", text: "Media")
    }
}

struct BottomSide : View {
    let opacity : Double
    let image : String
    let text : String
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 50)
                .frame(width: 110, height: 5)
                .foregroundColor(.white)
                .opacity(opacity)
            HStack {
                Image(systemName: image)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                Text(text)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }.frame(width: 110, height: 20)
        }
    }
}

struct SliderBar : View {
    let titleArray : [String] = ["Fingers", "Nothing", "Nothing", "Nothing", "Nothing"]
    let infoArray : [String] = ["The fingers and toes are becoming properly separated losing ny webbing.\nThe fingers and toes are becoming properly separated, losing any webbing.", "Nothing", "Nothing", "Nothing", "Nothing"]
    let palette = Colors()
    var body: some View {
        TabView {
            ForEach(titleArray.indices, id: \.self) { indexRow in
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(palette.beige)
                        .frame(width: 350, height: 200)
                        .padding()
                    VStack(spacing: 0) {
                        Text(titleArray[indexRow])
                            .bold()
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                        Text(infoArray[indexRow])
                            .frame(width: 300, height: 100)
                            .font(.system(size: 15))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        
                    }
                }
            }
        }
        .tabViewStyle(.page)
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
                        .frame(width: 35)
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 23))
                }
            }.buttonStyle(.borderless)
        }
    }
}

struct EmojiBarsBuilder : View {
    let palette = Colors()
    let emojiArray : [String] = ["😩", "😭", "😟", "😣", "😃", "😄"]
    let heightArray : [CGFloat] = [20, 50, 70, 20, 80, 90]
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(palette.darkest)
                .frame(width: 350, height: 200)
            VStack {
                Text("Mood breakdown")
                    .foregroundColor(.white)
                    .bold()
                    .font(.system(size: 25))
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
                    .frame(width: 8, height: 90)
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
                Text(getDateFormatted()) // func for time.
                    .foregroundColor(.white)
            }
            ZStack {
                Circle()
                    .frame(width: 50)
                    .foregroundColor(palette.raspberry)
                Image("Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 3)
            }.padding(.trailing, 30)
            Button {
                // Here goes the action
            } label: {
                Image("Settings")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
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
