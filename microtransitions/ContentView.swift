//
//  ContentView.swift
//  microtransitions
//
//  Created by Rajayogan on 05/06/25.
//

import SwiftUI

struct ContentView: View {
    
    //Going to be our main trigger for when the user taps on a scrollview item
    @State var isTapped: Bool = false
    @State var loadTrigger: Bool = false
    @State var detailTrigger: Bool = false
    
    //Category chips
    private var categories: [String] = ["All", "Air Max", "Presto", "Huarache", "Mercurial"]
    
    //Shoe variants in the detail view
    private var shoeVariants: [String] = ["kdnewimg", "ucpresto", "airpegasus"]
    
        //Chip Selector
    @State var counter: Int? = 0
    @State var variantCounter: Int? = 0
    @State var sizeCounter: Int? = 6
    
    @State var selectedShoe: ShoeItem = .init(name: "Alpha Savage", price: 8895, color: .alphared, nameColor: .white, image: "alphas")
    @State var selectedShoeIndex: Int = 0
    
    //Shoes
    private var allShoes: [ShoeItem] = [.init(name: "Alpha Savage", price: 8895, color: .alphared, nameColor: .white, image: "alphas"),
                                        .init(name: "Air Max 97", price: 1194, color: .airyellow, nameColor: .black, image: "yellowmax"),
                                        .init(name: "KD13 EP", price: 8895, color: .kDblue, nameColor: .white, image: "kdnewimg"),
                                        .init(name: "Air Presto", price: 8895, color: .lastteal, nameColor: .white, image: "kdnewimg")
    ]
    
    var body: some View {
        ZStack {
            Color(.bg).ignoresSafeArea()
            VStack {
                if(!isTapped) {
                    HStack {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.black)
                            .onTapGesture {
                                isTapped = false
                            }
                        Spacer()
                        Image(systemName: "magnifyingglass")
                    }.padding()
                }
                if(!isTapped) {
                    HStack {
                        Text("Shoes")
                            .font(.montserrat(fontStyle: .title3, fontWeight: .bold, fontSize: 25))
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                    CategoryChips()
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                }
                
                if(isTapped) {
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: loadTrigger ? 300 : 24)
                            .fill(selectedShoe.color)
                      
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 35))
                            .frame(width: loadTrigger ? 600 : UIScreen.main.bounds.width - 100, height: loadTrigger ? 600 :300)
                       
                            .offset(x: loadTrigger ? 70 : -32, y: loadTrigger ? -400 : 170)
                        
                        
                        Image(selectedShoe.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                            .rotationEffect(Angle(degrees: loadTrigger ? 0 : -35))
                            .offset(x: loadTrigger ? 0 : -20, y: loadTrigger ? -210 : 160)
                        
                            .offset(x:1, y: 20)
                        HStack {
                            Image(systemName: "arrow.left")
                                .foregroundStyle(.white)
                                .onTapGesture {
                                    detailTrigger = false
                                    withAnimation(.easeIn(duration: 0.85)) {
                                        loadTrigger = false
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.85) {
                                            isTapped = false
                                    }
                                }
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.white)
                        }.padding()
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .offset(x:0, y: -300)
                        if(detailTrigger){
                            VStack {
                                HStack {
                                    Text(selectedShoe.name)
                                        .font(.montserrat(fontStyle: .title, fontWeight: .bold, fontSize: 25))
                                    Spacer()
                                    Text("$\(selectedShoe.price)")
                                        .font(.montserrat(fontStyle: .title, fontWeight: .medium, fontSize: 22))
                                }.frame(width: UIScreen.main.bounds.width - 50)
                                
                                Text("In the game's crucial moments, KD thrives. He takes over on both ends of the court making defenders fear his unstoppable...")
                                    .font(.montserrat(fontStyle: .caption, fontWeight: .medium))
                                    .foregroundStyle(.gray)
                                    .frame(width: UIScreen.main.bounds.width - 50, height: 75)
                                    .padding(EdgeInsets(top: 1, leading: 20, bottom: 10, trailing: 20))
                                
                                Variants()
                                    .frame(width: UIScreen.main.bounds.width - 50, height: 75)
                                Spacer()
                                    .frame(height: 50)
                                HStack {
                                    Text("Select Size")
                                        .font(.montserrat(fontStyle: .title, fontWeight: .bold, fontSize: 17))
                                    Spacer()
                                }
                                .frame(width: UIScreen.main.bounds.width - 50)
                                
                                
                                SizeChooser()
                                Spacer()
                                    .frame(height: 50)
                                Button{
                                    
                                } label: {
                                    Text("Add to Bag")
                                        .frame(maxWidth: .infinity, maxHeight: 35)
                                        .font(.montserrat(fontWeight: .bold))
                                }
                                .buttonStyle(.borderedProminent)
                                .frame(width: UIScreen.main.bounds.width - 50, height: 75)
                                .tint(.black.opacity(0.85))
                                .foregroundStyle(.white)
                            }
                            .offset(x: 0, y: 200)
                            
                        }
                    }
                    
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            withAnimation(.easeIn(duration: 0.85)) {
                                loadTrigger = true
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.easeIn(duration: 0.85)) {
                                detailTrigger = true
                            }
                        }
                        
                    }
                }
                if(!isTapped){
                    ScrollViewReader { val in
                        ScrollView(.horizontal){
                            
                            HStack(spacing : 24){
                                ForEach(0..<allShoes.count, id: \.self){ index in
                                    
                                    ZStack {
                                        
                                        RoundedRectangle(cornerRadius: 24)
                                            .fill(allShoes[index].color)
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 35))
                                            .frame(width: UIScreen.main.bounds.width - 100 ,height: 300)
                                            .offset(x: 0, y: 0)
                                        if(!isTapped) {
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    Text(allShoes[index].name)
                                                        .font(.montserrat(fontStyle: .title, fontWeight: .bold, fontSize: 25))
                                                        .foregroundStyle(allShoes[index].nameColor)
                                                    Text("$\(allShoes[index].price.formatted())")
                                                        .font(.montserrat(fontStyle: .title2, fontWeight: .regular, fontSize: 20))
                                                        .foregroundStyle(allShoes[index].nameColor)
                                                    Rectangle()
                                                        .foregroundStyle(.white)
                                                        .frame(width: 0.75, height: 175)
                                                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                                                }
                                                .padding()
                                                Spacer()
                                            }
                                        }
                                        
                                        Image(allShoes[index].image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 275, height: 275)
                                            .offset(x: 1, y: 20)
                                            .scrollTransition(.animated) { content, phase in
                                                    content.rotationEffect(Angle(degrees: phase.isIdentity ? -35: -65))
  
                                            }
  
                                    }
                                    .onTapGesture {
                                        withAnimation(.easeIn(duration: 0.85)) {
                                            selectedShoe = allShoes[index]
                                            selectedShoeIndex = index
                                            isTapped = true
                                        }
                                    }
                                    
                                }
                                
                                .scrollTargetLayout()
                            }
                        }
                        .contentMargins(20, for: .scrollContent)
                        .scrollTargetBehavior(.viewAligned)
                        .scrollIndicators(.hidden)
                        .onAppear {
                            
                            val.scrollTo(selectedShoeIndex, anchor: .leading)
                        }
                    }
                }
                if(!isTapped) {
                    HStack {
                        Text("243 OPTIONS")
                            .font(.montserrat(fontWeight: .bold, fontSize: 14))
                            .foregroundStyle(.gray)
                        Spacer()
                    }.padding()
                    ScrollView(.vertical) {
                        HStack(spacing: 40) {
                            Image("ucpresto")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                                .frame(width: 125, height: 100)
                                .clipped()
                            
                            
                            VStack(alignment: .leading) {
                                Text("Undercover React")
                                    .font(.montserrat(fontWeight: .bold, fontSize: 17))
                                Text("Presto")
                                    .font(.montserrat(fontWeight: .bold, fontSize: 17))
                                Spacer().frame(width:4, height: 4)
                                Text("$112.99")
                                    .font(.montserrat(fontWeight: .medium, fontSize: 17))
                                    .foregroundStyle(.gray.opacity(0.9))
                                
                            }
                            
                        }.frame(width: UIScreen.main.bounds.width - 30)
                        HStack(spacing: 40)  {
                            Image("airpegasus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 125, height: 100)
                                .clipped()
                            VStack(alignment: .leading) {
                                Text("Air Zoom Pegasus")
                                    .font(.montserrat(fontWeight: .bold, fontSize: 17))
                                Spacer().frame(width:4, height: 4)
                                Text("$98.99")
                                    .font(.montserrat(fontWeight: .medium, fontSize: 17))
                                    .foregroundStyle(.gray.opacity(0.9))
                            }
                            
                        }.frame(width: UIScreen.main.bounds.width - 30)
                    }
                }
                
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    func Variants() -> some View {
        HStack(spacing: 15) {
            ForEach(0..<3, id: \.self) { shoeVariant in
                Button(action: {
                    withAnimation(.easeIn) {
                        variantCounter = shoeVariant
                    }
                }) {
                    Image(shoeVariants[shoeVariant])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 75, height: 75)
                }.buttonStyle(.borderedProminent)
                    .tint(.white)
                    .buttonBorderShape(.roundedRectangle(radius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(variantCounter == shoeVariant ? Color.black: Color.white, lineWidth: 2))
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    func SizeChooser() -> some View {
        VStack(spacing: 20) {
            HStack(spacing: 15) {
                ForEach(6..<10, id: \.self) {chip in
                    Button {
                        withAnimation(.easeIn) {
                            sizeCounter = chip
                        }
                    } label: {
                        Text("UK \(chip)")
                            .frame(width: 50, height: 25)
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundStyle(.black)
                    .tint(.white)
                    .frame(width: 75, height: 40)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(sizeCounter == chip ? Color.black : Color.white, lineWidth: 2))
                }
            }
            HStack(spacing: 15) {
                ForEach(10..<14, id: \.self) {chip in
                    Button {
                        withAnimation(.easeIn) {
                            sizeCounter = chip
                        }
                    } label: {
                        Text("UK \(chip)")
                            .frame(width: 50, height: 25)
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundStyle(.black)
                    .tint(.white)
                    .frame(width: 75, height: 40)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(sizeCounter == chip ? Color.black : Color.white, lineWidth: 2))
                }
            }
        }
    }
    
    @ViewBuilder
    func CategoryChips() -> some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<categories.count, id: \.self) { chip in
                    Button(categories[chip]) {
                        withAnimation(.easeIn) {
                            counter = chip
                        }
                    }.buttonStyle(.borderedProminent)
                        .foregroundStyle(chip == counter ? .white : .black)
                        .tint(chip == counter ? .black : .gray.opacity(0.2))
                        .buttonBorderShape(.roundedRectangle(radius: 20))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
