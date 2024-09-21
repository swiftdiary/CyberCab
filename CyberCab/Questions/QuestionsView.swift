//
//  QuestionsView.swift
//  CyberCab
//
//  Created by Akbar Khusanbaev on 21/09/24.
//

import SwiftUI

struct QuestionsView: View {
    @AppStorage("hasAnsweredQuestions") private var hasAnsweredQuestions: Bool = false
    @State private var questionsObservable = QuestionsObservable()
    
    var body: some View {
        @Bindable var questionsObservable = questionsObservable
        ZStack {
            Color.csBackground.ignoresSafeArea()
            
            GeometryReader { proxy in
                let size = proxy.size
                ScrollViewReader { scrollProxy in
                    ScrollView(.horizontal) {
                        HStack(spacing: 0) {
                            ForEach(questionsObservable.allQuestions) { question in
                                QuestionSection(question: question, size: size)
                                    .id(question.id)
                            }
                        }
                    }
                    .scrollDisabled(true)
                    .onChange(of: questionsObservable.currentQuestionIndex, { oldValue, newValue in
                        withAnimation(.bouncy) {
                            scrollProxy.scrollTo(questionsObservable.allQuestions[newValue].id, anchor: .center)
                        }
                    })
                }
            }
        }
        .onChange(of: questionsObservable.hasAnsweredAllQuestions, { oldValue, newValue in
            if newValue {
                hasAnsweredQuestions = newValue
            }
        })
        .task {
            do {
                try await questionsObservable.getAllQuestions()
            } catch {
                print(error)
            }
        }
    }
    
    @ViewBuilder
    private func QuestionSection(question: Question, size: CGSize) -> some View {
        VStack {
            VStack {
                CC_Text(question.text.localized, size: 20)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 20.0)
                    .fill(Color.white)
            }
            
            VStack {
                switch question.type {
                case .multipleChoice:
                    MultipleChoiceQuestionOptions(question: question)
                case .text:
                    TextQuestionOption(question: question)
                case .float:
                    Text("Float")
                case .int:
                    Text("Int")
                case .multipleChoiceOrText:
                    Text("efefef")
                case .multipleChoiceWithMultipleAnswers:
                    MultipleChoiceWithMultipleAnswersOption(question: question)
                }
            }
            Spacer()
            CC_PrimaryButton("Next") {
                questionsObservable.nextQuestion()
            }
            .padding()
        }
        .frame(width: size.width)
    }
    
    @ViewBuilder
    private func MultipleChoiceQuestionOptions(question: Question) -> some View {
        
    }
    
    @ViewBuilder
    private func TextQuestionOption(question: Question) -> some View {
        
    }
    
    @ViewBuilder
    private func MultipleChoiceWithMultipleAnswersOption(question: Question) -> some View {
        VStack(spacing: 5) {
            ForEach(question.choices, id: \.hashValue) { choice in
                HStack(spacing: 15) {
                    if questionsObservable.answerChoicesList.contains(choice) {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.accentColor)
                    } else {
                        HStack{}.frame(width: 20)
                    }
                    if let text = choice.text {
                        CC_Text(text.localized, size: 18)
                            .fontWeight(.semibold)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 20.0)
                        .fill(Color.white)
                }
                .padding(10)
                .onTapGesture {
                    withAnimation(.bouncy) {
                        if questionsObservable.answerChoicesList.contains(choice) {
                            if let indexOfChoice = questionsObservable.answerChoicesList.firstIndex(of: choice) {
                                questionsObservable.answerChoicesList.remove(at: indexOfChoice)
                            } else {
                                print("URGENT: Could not find choice in multipleChoiceChoices")
                            }
                        } else {
                            questionsObservable.answerChoicesList.append(choice)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    QuestionsView()
}
