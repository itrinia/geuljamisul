//
//  GMView.swift
//  geuljamisul
//
//  Created by Ileene Trinia Santoso on 22/04/24.
//
import SwiftUI

struct GMView: View {
    let koreanAlphabets = ["ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ",
                           "ㅏ", "ㅑ", "ㅓ", "ㅕ", "ㅗ", "ㅛ", "ㅜ", "ㅠ", "ㅡ", "ㅣ"]
    
    @State private var selectedCards: [String] = []
    @State private var pronunciation: String = ""
    @State private var hangeulCombination: String = ""
    
    // Dictionary to map each combination of Korean alphabets to their corresponding syllables
    let syllableDictionary: [String: String] = [
        "ㄱㅏ": "ga", "ㄴㅏ": "na", "ㄷㅏ": "da", "ㄹㅏ": "ra", "ㅁㅏ": "ma",
        "ㅂㅏ": "ba", "ㅅㅏ": "sa", "ㅇㅏ": "a", "ㅈㅏ": "ja", "ㅊㅏ": "cha",
        "ㅋㅏ": "ka", "ㅌㅏ": "ta", "ㅍㅏ": "pa", "ㅎㅏ": "ha", "ㄱㅑ": "gya",
        "ㄴㅑ": "nya", "ㄷㅑ": "dya", "ㄹㅑ": "rya", "ㅁㅑ": "mya", "ㅂㅑ": "bya",
        "ㅅㅑ": "sya", "ㅇㅑ": "ya", "ㅈㅑ": "jya", "ㅊㅑ": "chya", "ㅋㅑ": "kya",
        "ㅌㅑ": "tya", "ㅍㅑ": "pya", "ㅎㅑ": "hya", "ㄱㅓ": "geo", "ㄴㅓ": "neo",
        "ㄷㅓ": "deo", "ㄹㅓ": "reo", "ㅁㅓ": "meo", "ㅂㅓ": "beo", "ㅅㅓ": "seo",
        "ㅇㅓ": "eo", "ㅈㅓ": "jeo", "ㅊㅓ": "cheo", "ㅋㅓ": "keo", "ㅌㅓ": "teo",
        "ㅍㅓ": "peo", "ㅎㅓ": "heo", "ㄱㅕ": "gyeo", "ㄴㅕ": "nyeo", "ㄷㅕ": "dyo",
        "ㄹㅕ": "ryeo", "ㅁㅕ": "myeo", "ㅂㅕ": "byeo", "ㅅㅕ": "syeo", "ㅇㅕ": "yeo",
        "ㅈㅕ": "jyeo", "ㅊㅕ": "chyeo", "ㅋㅕ": "kyeo", "ㅌㅕ": "tyeo", "ㅍㅕ": "pyeo",
        "ㅎㅕ": "hyeo", "ㄱㅗ": "go", "ㄴㅗ": "no", "ㄷㅗ": "do", "ㄹㅗ": "ro",
        "ㅁㅗ": "mo", "ㅂㅗ": "bo", "ㅅㅗ": "so", "ㅇㅗ": "o", "ㅈㅗ": "jo",
        "ㅊㅗ": "cho", "ㅋㅗ": "ko", "ㅌㅗ": "to", "ㅍㅗ": "po", "ㅎㅗ": "ho",
        "ㄱㅛ": "gyo", "ㄴㅛ": "nyo", "ㄷㅛ": "dyo", "ㄹㅛ": "ryo", "ㅁㅛ": "myo",
        "ㅂㅛ": "byo", "ㅅㅛ": "syo", "ㅇㅛ": "yo", "ㅈㅛ": "jyo", "ㅊㅛ": "chyo",
        "ㅋㅛ": "kyo", "ㅌㅛ": "tyo", "ㅍㅛ": "pyo", "ㅎㅛ": "hyo", "ㄱㅜ": "gu",
        "ㄴㅜ": "nu", "ㄷㅜ": "du", "ㄹㅜ": "ru", "ㅁㅜ": "mu", "ㅂㅜ": "bu",
        "ㅅㅜ": "su", "ㅇㅜ": "u", "ㅈㅜ": "ju", "ㅊㅜ": "chu", "ㅋㅜ": "ku",
        "ㅌㅜ": "tu", "ㅍㅜ": "pu", "ㅎㅜ": "hu", "ㄱㅠ": "gyu", "ㄴㅠ": "nyu",
        "ㄷㅠ": "dyu", "ㄹㅠ": "ryu", "ㅁㅠ": "myu", "ㅂㅠ": "byu", "ㅅㅠ": "syu",
        "ㅇㅠ": "yu", "ㅈㅠ": "jyu", "ㅊㅠ": "chyu", "ㅋㅠ": "kyu", "ㅌㅠ": "tyu",
        "ㅍㅠ": "pyu", "ㅎㅠ": "hyu", "ㅏㅣ": "e", "ㅑㅣ": "ye", "ㅓㅣ": "eo",
        "ㅕㅣ": "yeo", "ㅗㅣ": "o", "ㅛㅣ": "yo", "ㅜㅣ": "u", "ㅠㅣ": "yu",
        "ㅡㅣ": "eu", "ㅣㅣ": "i", "ㅂㅣ": "bi", "ㅅㅣ": "si",
        "ㅈㅣ": "ji", "ㅊㅣ": "chi", "ㅋㅣ": "ki", "ㅌㅣ": "ti", "ㅍㅣ": "pi", "ㅎㅣ": "hi"
    ]

    
    var body: some View {
        VStack {
            HangeulCombinationView(hangeulCombination: $hangeulCombination)
            PronunciationView(pronunciation: $pronunciation)
                        ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 4)) {
                    ForEach(koreanAlphabets, id: \.self) { alphabet in
                        Button(action: {
                            toggleSelection(alphabet)
                        }) {
                            Text(alphabet)
                                .padding()
                                .foregroundColor(selectedCards.contains(alphabet) ? .gray : .black)
                        }
                        .background(selectedCards.contains(alphabet) ? Color.gray.opacity(0.3) : Color.clear)
                        .cornerRadius(10)
                        .padding()
                    }
                }
            }
            Button(action: clearSelection) {
                Text("Clear")
                    .padding()
                    .foregroundColor(.red)
            }
            .padding()
        }
    }
    
    private func toggleSelection(_ alphabet: String) {
        if let index = selectedCards.firstIndex(of: alphabet) {
            selectedCards.remove(at: index)
        } else {
            selectedCards.append(alphabet)
        }
        updatePronunciation()
        updateHangeulCombination()
    }
    
    private func updatePronunciation() {
        // Generate the pronunciation by looking up the combined syllable for each pair of selected alphabets
        let combinedSyllables = stride(from: 0, to: selectedCards.count, by: 2).map { index in
            let firstAlphabet = selectedCards[index]
            let secondAlphabet = index + 1 < selectedCards.count ? selectedCards[index + 1] : ""
            return syllableDictionary[firstAlphabet + secondAlphabet] ?? ""
        }
        // Astign the pronunciation to the state variable
        pronunciation = combinedSyllables.joined()
    }
    
    private func updateHangeulCombination() {
        // Generate the combined Hangeul characters based on selected alphabets
        hangeulCombination = selectedCards.joined()
    }
    
    private func clearSelection() {
        selectedCards.removeAll()
        pronunciation = ""
        hangeulCombination = ""
    }
}

struct PronunciationView: View {
    @Binding var pronunciation: String
    
    var body: some View {
        Text(pronunciation)
            .font(.title)
            .foregroundColor(.blue)
            .padding()
    }
}

struct HangeulCombinationView: View {
    @Binding var hangeulCombination: String
    
    var body: some View {
        Text(hangeulCombination)
            .font(.title)
            .foregroundColor(.green)
            .padding()
    }
}
