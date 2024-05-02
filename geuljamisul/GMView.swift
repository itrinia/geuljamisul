//
//  GMView.swift
//  geuljamisul
//
//  Created by Ileene Trinia Santoso on 22/04/24.
//
import SwiftUI

struct GMView: View {
    let consonantHangeul = ["ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ", "ㅃ", "ㅉ", "ㄸ", "ㄲ", "ㅆ"]
    let vowelsHangeul = ["ㅏ", "ㅑ", "ㅓ", "ㅕ", "ㅗ", "ㅛ", "ㅜ", "ㅠ", "ㅡ", "ㅣ", "ㅐ", "ㅒ", "ㅔ", "ㅖ"]
    
    @State private var selectedCards: [String] = []
    @State private var pronunciation: String = ""
    @State private var hangeulCombination: String = ""
    
    // Dictionary to map each combination of Korean alphabets to their corresponding syllables and pronunciations
    let syllableDictionary: [String: (hangeul: String, pronunciation: String)] = [
        "ㄱㅏ": ("가", "ga"), "ㄴㅏ": ("나", "na"), "ㄷㅏ": ("다", "da"), "ㄹㅏ": ("라", "ra"), "ㅁㅏ": ("마", "ma"),
        // Add more combinations as needed...
    ]
    
    var body: some View {
        VStack {
            VStack {
                Text(hangeulCombination)
                    .font(.title)
                    .foregroundColor(.purple)
                    .padding(.bottom, 10)
                    .bold()
            
                Text(selectedCards.joined(separator: " + "))
                    .font(.subheadline)
                    .foregroundColor(.green)
                
                Text(pronunciation)
                    .font(.title)
                    .foregroundColor(.blue)
                    .bold()
            }
            .padding([.top, .bottom],25)
            
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 5), spacing: 10) {
                    ForEach(consonantHangeul, id: \.self) { consonant in
                        CardView(alphabet: consonant, selectedCards: $selectedCards, updateHangeulCombination: updateHangeulCombination, updatePronunciation: updatePronunciation, syllableDictionary: syllableDictionary, backgroundColor: .blue)
                    }
                    ForEach(vowelsHangeul, id: \.self) { vowel in
                        CardView(alphabet: vowel, selectedCards: $selectedCards, updateHangeulCombination: updateHangeulCombination, updatePronunciation: updatePronunciation, syllableDictionary: syllableDictionary, backgroundColor: .red)
                    }
                }
                .padding([.horizontal, .bottom], 25)
            }
            
            Button(action: clearSelection) {
                Text("Clear")
                    .padding()
                    .foregroundColor(.red)
            }
            .padding()
        }
    }
    
    func updatePronunciation() {
        let combinedSyllables = stride(from: 0, to: selectedCards.count, by: 2).map { index in
            let firstAlphabet = selectedCards[index]
            let secondAlphabet = index + 1 < selectedCards.count ? selectedCards[index + 1] : ""
            return syllableDictionary[firstAlphabet + secondAlphabet]?.pronunciation ?? ""
        }
        pronunciation = combinedSyllables.joined()
    }
    
    func updateHangeulCombination() {
        var combinedSyllables = ""
        for index in stride(from: 0, to: selectedCards.count, by: 2) {
            let firstAlphabet = selectedCards[index]
            let secondAlphabet = index + 1 < selectedCards.count ? selectedCards[index + 1] : ""
            if let syllable = syllableDictionary[firstAlphabet + secondAlphabet]?.hangeul {
                combinedSyllables.append(syllable)
            }
        }
        hangeulCombination = combinedSyllables
    }

    
    func clearSelection() {
        selectedCards.removeAll()
        pronunciation = ""
        hangeulCombination = ""
    }
}

struct CardView: View {
    let alphabet: String
    @Binding var selectedCards: [String]
    var updateHangeulCombination: () -> Void
    var updatePronunciation: () -> Void
    let syllableDictionary: [String: (hangeul: String, pronunciation: String)]
    let backgroundColor: Color
    
    var body: some View {
        Button(action: {
            toggleSelection()
            updateHangeulCombination()
            updatePronunciation()
        }) {
            Text(alphabet)
                .padding(20)
                .foregroundColor(selectedCards.contains(alphabet) ? .white : .black)
        }
        .background(backgroundColor.opacity(selectedCards.contains(alphabet) ? 0.5 : 0.2))
        .cornerRadius(10)
        .padding(1)
    }
    
    func toggleSelection() {
        if let index = selectedCards.firstIndex(of: alphabet) {
            selectedCards.remove(at: index)
        } else {
            selectedCards.append(alphabet)
        }
    }
}



//struct GMView: View {
//    let consonantHangeul = ["ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ", "ㅃ", "ㅉ", "ㄸ", "ㄲ", "ㅆ"]
//    let vowelsHangeul = ["ㅏ", "ㅑ", "ㅓ", "ㅕ", "ㅗ", "ㅛ", "ㅜ", "ㅠ", "ㅡ", "ㅣ", "ㅐ", "ㅒ", "ㅔ", "ㅖ"]
//    
//    @State private var selectedConsonant: String = ""
//    @State private var selectedVowel: String = ""
//    @State private var hangeulSyllable: String = ""
//    @State private var pronunciation: String = ""
//        
//        // Dictionary to map each combination of Korean alphabets to their corresponding syllables and pronunciations
//    let syllableDictionary: [String: (syllable: String, pronunciation: String)] = [
//            "ㄱㅏ": ("가", "ga"), "ㄴㅏ": ("나", "na"), "ㄷㅏ": ("다", "da"), "ㄹㅏ": ("라", "ra"), "ㅁㅏ": ("마", "ma"),
//            // Add more combinations...
//    ]
//   
//    var body: some View {
//        VStack {
//            HangeulCombinationView(hangeulCombination: $hangeulCombination)
//            PronunciationView(pronunciation: $pronunciation)
//            
//            ScrollView {
//                    LazyVGrid(columns: Array(repeating: GridItem(), count: 5), spacing: 10) {   
//                        ForEach(consonantHangeul, id: \.self) { alphabet in
//                            Button(action: {
//                                toggleSelection(alphabet)
//                                updateHangeulCombination()
//                                updatePronunciation()
//                            }) {
//                                Text(alphabet)
//                                    .padding(20)
//                                    .foregroundColor(selectedCards.contains(alphabet) ? .white : .black)
//                            }
//                            .background(selectedCards.contains(alphabet) ? Color.blue.opacity(0.5) : Color.blue.opacity(0.2))
//                            .cornerRadius(10)
//                            .padding(1)
//                        }
//                        ForEach(vowelsHangeul, id: \.self) { alphabet in
//                            Button(action: {
//                                toggleSelection(alphabet)
//                                updateHangeulCombination()
//                                updatePronunciation()
//                            }) {
//                                Text(alphabet)
//                                    .padding(20)
//                                    .foregroundColor(selectedCards.contains(alphabet) ? .white : .black)
//                            }
//                            .background(selectedCards.contains(alphabet) ? Color.red.opacity(0.5) : Color.red.opacity(0.2))
//                            .cornerRadius(10)
//                            .padding(1)
//                        }
//
//                    }
//                    .padding([.horizontal, .bottom], 25)
//            }
//            
//            Button(action: clearSelection) {
//                Text("Clear")
//                    .padding()
//                    .foregroundColor(.red)
//            }
//            .padding()
//        }
//    }
//    
//    func toggleSelection(_ alphabet: String) {
//        if let index = selectedCards.firstIndex(of: alphabet) {
//            selectedCards.remove(at: index)
//        } else {
//            selectedCards.append(alphabet)
//        }
//    }
//    
//    
//    func updatePronunciation() {
//        let combinedSyllables = stride(from: 0, to: selectedCards.count, by: 2).map { index in
//            let firstAlphabet = selectedCards[index]
//            let secondAlphabet = index + 1 < selectedCards.count ? selectedCards[index + 1] : ""
//            return syllableDictionary[firstAlphabet + secondAlphabet] ?? ""
//        }
//        pronunciation = combinedSyllables.joined()
//    }
//    
//    func updateHangeulCombination() {
//        hangeulCombination = selectedCards.joined()
//    }
//    
//    func clearSelection() {
//        selectedCards.removeAll()
//        pronunciation = ""
//        hangeulCombination = ""
//    }
//    
//    struct PronunciationView: View {
//        @Binding var pronunciation: String
//        
//        var body: some View {
//            Text(pronunciation)
//                .font(.title)
//                .foregroundColor(.blue)
//                .padding()
//        }
//    }
//    
//    struct HangeulCombinationView: View {
//        @Binding var hangeulCombination: String
//        
//        var body: some View {
//            Text(hangeulCombination)
//                .font(.title)
//                .foregroundColor(.green)
//                .padding()
//        }
//    }
//}
