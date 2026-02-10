//
//  OnboardingView.swift
//  RestartAppDemo
//
//  Created by Suraj Parshad on 05/02/26.
//

import SwiftUI

struct OnboardingView: View {
    
    //MARK: Property Wrapper
    @AppStorage ("onboarding") var isOnBoardingActive : Bool = true
    
    @State private var buttonwidth:Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset : CGFloat = 0
    @State private var isAnimating : Bool = false
    @State private var imageoffset : CGSize = CGSize(width: 0, height: 0)
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitile : String = "Share."
    
    let hapticFeedBack = UINotificationFeedbackGenerator()
    
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all,edges: .all)
            //MARK: Header
            Spacer()
            
            VStack(spacing: 20){
                
                VStack(spacing: 0){
                    Text(textTitile)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitile)
                    Text("""
                     it's not how much we give but
                    how much we put love into giving.
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,10)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y:isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1),value: isAnimating)
                //MARK: Center
                
                ZStack{
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: imageoffset.width * -1)
                        .blur(radius: abs(imageoffset.width/5))
                        .animation(.easeInOut(duration: 1), value: imageoffset)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeInOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageoffset.width * 1.2, y : 0)
                        .rotationEffect(.degrees(Double(imageoffset.width/20)))
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if abs(imageoffset.width) <= 150 {
                                        imageoffset = gesture.translation
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTitile = "Give."
                                        }
                                    }
                                }
                                .onEnded{ _ in
                                    imageoffset = .zero
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        textTitile = "Share."
                                    }
                                }
                        )//Gesture
                }//Center
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeInOut(duration: 1).delay(2),value: isAnimating)
                        .opacity(indicatorOpacity)
                    ,alignment: .bottom
                )
                Spacer()
                
                //MARK: Footer
                
                ZStack{
                    //1. Backghround (Static)
                    
                    Capsule()
                        .fill(.white.opacity(0.2))
                    
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    //2. Call-In-Action (Static)
                    
                    Text("Get Started")
                        .font(.system(.title3,design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x:20)
                    
                    //3. Capsule (Dynamic width)
                    
                    HStack{
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }
                    //4. Circle (Draggable)
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24,weight: .bold))
                        }//ZStack end
                        .foregroundColor(.white)
                        .frame(width: 80,height: 80,alignment: .center)
                        .offset(x: buttonOffset)
                        //Gesture for button
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonwidth - 80{
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded{_ in
                                    withAnimation(.easeOut(duration: 0.4)) {
                                        if buttonOffset > buttonwidth / 2 {
                                            hapticFeedBack.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            buttonOffset = buttonwidth - 80
                                            isOnBoardingActive = false
                                        }
                                        else{
                                            hapticFeedBack.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                }
                        )//Gesture
                        
                        
                        
                        Spacer()
                    }//HStack
                }//ZStack end
                .frame(width: buttonwidth,height: 80,alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1) ,value: isAnimating)
            }//VStack end
        }//ZStack end
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.light)
    }
}

#Preview {
    OnboardingView()
        .previewLayout(.sizeThatFits)
}
