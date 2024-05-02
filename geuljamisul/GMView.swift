//
//  GMView.swift
//  geuljamisul
//
//  Created by Ileene Trinia Santoso on 22/04/24.
//
import SwiftUI

struct GMView: View {
    let consonants = ["ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ", "ㅃ", "ㅉ", "ㄸ", "ㄲ", "ㅆ"]
    let vowels = ["ㅏ", "ㅑ", "ㅓ", "ㅕ", "ㅗ", "ㅛ", "ㅜ", "ㅠ", "ㅡ", "ㅣ", "ㅐ", "ㅒ", "ㅔ", "ㅖ"]
    
    @State private var selectedCards: [String] = []
    @State private var pronunciation: String = ""
    @State private var hangeulCombination: String = ""
    
//    Dictionary to map each combination of Korean alphabets to their corresponding syllables and pronunciations
    let syllableDictionary: [String: (hangeul: String, pronunciation: String)] = [
        "ㄱㅏ": ("가", "ga"), "ㄱㅐ": ("개", "gae"), "ㄱㅑ": ("갸", "gya"), "ㄱㅒ": ("걔", "gyae"), "ㄱㅓ": ("거", "geo"),
        "ㄱㅔ": ("게", "ge"), "ㄱㅕ": ("겨", "gyeo"), "ㄱㅖ": ("계", "gye"), "ㄱㅗ": ("고", "go"), "ㄱㅗㅏ": ("과", "gwa"),
        "ㄱㅗㅐ": ("괘", "gwae"), "ㄱㅗㅣ": ("괴", "goe"), "ㄱㅛ": ("교", "gyo"), "ㄱㅜ": ("구", "gu"), "ㄱㅜㅓ": ("궈", "gweo"),
        "ㄱㅜㅔ": ("궤", "gwe"), "ㄱㅜㅣ": ("귀", "gwi"), "ㄱㅠ": ("규", "gyu"), "ㄱㅡ": ("그", "geu"), "ㄱㅡㅣ": ("긔", "gyui"),
        "ㄱㅣ": ("기", "gi"),
        
        "ㄴㅏ": ("나", "na"), "ㄴㅐ": ("내", "nae"), "ㄴㅑ": ("냐", "nya"), "ㄴㅒ": ("냬", "nyae"), "ㄴㅓ": ("너", "neo"),
        "ㄴㅔ": ("네", "ne"), "ㄴㅕ": ("녀", "nyeo"), "ㄴㅖ": ("녜", "nye"), "ㄴㅗ": ("노", "no"), "ㄴㅗㅏ": ("놔", "nwa"),
        "ㄴㅗㅐ": ("놰", "nwoe"), "ㄴㅗㅣ": ("뇌", "noe"), "ㄴㅛ": ("뇨", "nyo"), "ㄴㅜ": ("누", "nu"), "ㄴㅜㅓ": ("눠", "nwo"),
        "ㄴㅜㅔ": ("눼", "noe"), "ㄴㅜㅣ": ("뉘", "nwi"), "ㄴㅠ": ("뉴", "nyu"), "ㄴㅡ": ("느", "neu"), "ㄴㅡㅣ": ("늬", "nyui"),
        "ㄴㅣ": ("니", "ni"),

        "ㄷㅏ": ("다", "da"), "ㄷㅐ": ("대", "dae"), "ㄷㅑ": ("댜", "dya"), "ㄷㅒ": ("댸", "dyae"), "ㄷㅓ": ("더", "deo"),
        "ㄷㅔ": ("데", "de"), "ㄷㅕ": ("뎌", "dyeo"), "ㄷㅖ": ("뎨", "dye"), "ㄷㅗ": ("도", "do"), "ㄷㅗㅏ": ("돠", "dwa"),
        "ㄷㅗㅐ": ("돼", "dwae"), "ㄷㅗㅣ": ("되", "doe"), "ㄷㅛ": ("됴", "dyo"), "ㄷㅜ": ("두", "du"), "ㄷㅜㅓ": ("둬", "dwo"),
        "ㄷㅜㅔ": ("뒈", "dwe"), "ㄷㅜㅣ": ("뒤", "dwi"), "ㄷㅠ": ("듀", "dyu"), "ㄷㅡ": ("드", "deu"), "ㄷㅡㅣ": ("듸", "dyui"),
        "ㄷㅣ": ("디", "di"),

        "ㄹㅏ": ("라", "ra"), "ㄹㅐ": ("래", "rae"), "ㄹㅑ": ("랴", "rya"), "ㄹㅒ": ("럐", "ryae"), "ㄹㅓ": ("러", "reo"),
        "ㄹㅔ": ("레", "re"), "ㄹㅕ": ("려", "ryeo"), "ㄹㅖ": ("례", "rye"), "ㄹㅗ": ("로", "ro"), "ㄹㅗㅏ": ("롸", "rwa"),
        "ㄹㅗㅐ": ("뢔", "rwae"), "ㄹㅗㅣ": ("뢰", "roe"), "ㄹㅛ": ("료", "ryo"), "ㄹㅜ": ("루", "ru"), "ㄹㅜㅓ": ("뤄", "rwo"),
        "ㄹㅜㅔ": ("뤠", "rwe"), "ㄹㅜㅣ": ("뤼", "rwi"), "ㄹㅠ": ("류", "ryu"), "ㄹㅡ": ("르", "reu"), "ㄹㅡㅣ": ("릐", "rui"),
        "ㄹㅣ": ("리", "ri"),

        "ㅁㅏ": ("마", "ma"), "ㅁㅐ": ("매", "mae"), "ㅁㅑ": ("먀", "mya"), "ㅁㅒ": ("먜", "myae"), "ㅁㅓ": ("머", "meo"),
        "ㅁㅔ": ("메", "me"), "ㅁㅕ": ("며", "myeo"), "ㅁㅖ": ("몌", "mye"), "ㅁㅗ": ("모", "mo"), "ㅁㅗㅏ": ("뫄", "mwa"),
        "ㅁㅗㅐ": ("뫠", "mwae"), "ㅁㅗㅣ": ("뫼", "moi"), "ㅁㅛ": ("묘", "myo"), "ㅁㅜ": ("무", "mu"), "ㅁㅜㅓ": ("뭐", "mwo"),
        "ㅁㅜㅔ": ("뭐", "moe"), "ㅁㅜㅣ": ("뮈", "mwi"), "ㅁㅠ": ("뮤", "myu"), "ㅁㅡ": ("므", "meu"), "ㅁㅡㅣ": ("믜", "mui"),
        "ㅁㅣ": ("미", "mi"),

        "ㅂㅏ": ("바", "ba"), "ㅂㅐ": ("배", "bae"), "ㅂㅑ": ("뱌", "bya"), "ㅂㅒ": ("뱨", "byae"), "ㅂㅓ": ("버", "beo"),
        "ㅂㅔ": ("베", "be"), "ㅂㅕ": ("벼", "byeo"), "ㅂㅖ": ("볘", "bye"), "ㅂㅗ": ("보", "bo"), "ㅂㅗㅏ": ("봐", "bwa"),
        "ㅂㅗㅐ": ("봬", "bwae"), "ㅂㅗㅣ": ("뵈", "boi"), "ㅂㅛ": ("뵤", "byo"), "ㅂㅜ": ("부", "bu"), "ㅂㅜㅓ": ("붜", "bwo"),
        "ㅂㅜㅔ": ("붸", "boe"), "ㅂㅜㅣ": ("뷔", "bwi"), "ㅂㅠ": ("뷰", "byu"), "ㅂㅡ": ("브", "beu"), "ㅂㅡㅣ": ("븨", "bui"),
        "ㅂㅣ": ("비", "bi"),

        "ㅅㅏ": ("사", "sa"), "ㅅㅐ": ("새", "sae"), "ㅅㅑ": ("샤", "syae"), "ㅅㅒ": ("섀", "syae"), "ㅅㅓ": ("서", "seo"),
        "ㅅㅔ": ("세", "se"), "ㅅㅕ": ("셔", "syeo"), "ㅅㅖ": ("셰", "sye"), "ㅅㅗ": ("소", "so"), "ㅅㅗㅏ": ("솨", "swa"),
        "ㅅㅗㅐ": ("쇄", "swae"), "ㅅㅗㅣ": ("쇠", "soi"), "ㅅㅛ": ("쇼", "syo"), "ㅅㅜ": ("수", "su"), "ㅅㅜㅓ": ("숴", "swo"),
        "ㅅㅜㅔ": ("쉐", "soe"), "ㅅㅜㅣ": ("쉬", "swi"), "ㅅㅠ": ("슈", "syu"), "ㅅㅡ": ("스", "seu"), "ㅅㅡㅣ": ("싀", "sui"),
        "ㅅㅣ": ("시", "si"),
//not checked
        "ㅇㅏ": ("아", "a"), "ㅇㅐ": ("애", "ae"), "ㅇㅑ": ("야", "ya"), "ㅇㅒ": ("얘", "yae"), "ㅇㅓ": ("어", "eo"),
        "ㅇㅔ": ("에", "e"), "ㅇㅕ": ("여", "yeo"), "ㅇㅖ": ("예", "ye"), "ㅇㅗ": ("오", "o"), "ㅇㅗㅏ": ("와", "wa"),
        "ㅇㅗㅐ": ("왜", "wae"), "ㅇㅗㅣ": ("외", "oe"), "ㅇㅛ": ("요", "yo"), "ㅇㅜ": ("우", "u"), "ㅇㅜㅓ": ("워", "woe"),
        "ㅇㅜㅔ": ("웨", "we"), "ㅇㅜㅣ": ("위", "wi"), "ㅇㅠ": ("유", "yu"), "ㅇㅡ": ("으", "eu"), "ㅇㅡㅣ": ("의", "ui"),
        "ㅇㅣ": ("이", "i"),

        "ㅈㅏ": ("자", "ja"), "ㅈㅐ": ("재", "jae"), "ㅈㅑ": ("쟈", "jya"), "ㅈㅒ": ("쟤", "jyae"), "ㅈㅓ": ("저", "jeo"),
        "ㅈㅔ": ("제", "je"), "ㅈㅕ": ("져", "jyeo"), "ㅈㅖ": ("졔", "jye"), "ㅈㅗ": ("조", "jo"), "ㅈㅗㅏ": ("좨", "jwa"),
        "ㅈㅗㅐ": ("좼", "jwae"), "ㅈㅗㅣ": ("죄", "joe"), "ㅈㅛ": ("죠", "jyo"), "ㅈㅜ": ("주", "ju"), "ㅈㅜㅓ": ("쥐", "jwi"),
        "ㅈㅜㅔ": ("줘", "jwe"), "ㅈㅜㅣ": ("쥬", "jyu"), "ㅈㅠ": ("쥐", "jwi"), "ㅈㅡ": ("즈", "jeu"), "ㅈㅡㅣ": ("줘", "jwe"),
        "ㅈㅣ": ("지", "ji"),

        "ㅊㅏ": ("차", "cha"), "ㅊㅐ": ("채", "chae"), "ㅊㅑ": ("챠", "chya"), "ㅊㅒ": ("채", "chae"), "ㅊㅓ": ("처", "cheo"),
        "ㅊㅔ": ("체", "che"), "ㅊㅕ": ("쳐", "chyeo"), "ㅊㅖ": ("쳬", "chye"), "ㅊㅗ": ("초", "cho"), "ㅊㅗㅏ": ("촤", "chwa"),
        "ㅊㅗㅐ": ("촼", "chwae"), "ㅊㅗㅣ": ("쵸", "choe"), "ㅊㅛ": ("쵸", "chyo"), "ㅊㅜ": ("추", "chu"), "ㅊㅜㅓ": ("춰", "chwoe"),
        "ㅊㅜㅔ": ("춰", "chwe"), "ㅊㅜㅣ": ("취", "chwi"), "ㅊㅠ": ("취", "chwi"), "ㅊㅡ": ("츄", "chyu"), "ㅊㅡㅣ": ("취", "chwi"),
        "ㅊㅣ": ("치", "chi"),

        "ㅋㅏ": ("카", "ka"), "ㅋㅐ": ("캐", "kae"), "ㅋㅑ": ("캬", "kya"), "ㅋㅒ": ("케", "kyae"), "ㅋㅓ": ("커", "keo"),
        "ㅋㅔ": ("켜", "ke"), "ㅋㅕ": ("켸", "kyeo"), "ㅋㅖ": ("켜", "kye"), "ㅋㅗ": ("코", "ko"), "ㅋㅗㅏ": ("콰", "kwa"),
        "ㅋㅗㅐ": ("콰", "kwae"), "ㅋㅗㅣ": ("쾨", "koe"), "ㅋㅛ": ("쿄", "kyo"), "ㅋㅜ": ("쿠", "ku"), "ㅋㅜㅓ": ("쾌", "kwoe"),
        "ㅋㅜㅔ": ("쾨", "kwoe"), "ㅋㅜㅣ": ("쿼", "kwie"), "ㅋㅠ": ("큐", "kyu"), "ㅋㅡ": ("크", "keu"), "ㅋㅡㅣ": ("큐", "kyu"),
        "ㅋㅣ": ("키", "ki"),

        "ㅌㅏ": ("타", "ta"), "ㅌㅐ": ("태", "tae"), "ㅌㅑ": ("탸", "tyae"), "ㅌㅒ": ("텨", "tyae"), "ㅌㅓ": ("터", "teo"),
        "ㅌㅔ": ("테", "te"), "ㅌㅕ": ("텨", "tyeo"), "ㅌㅖ": ("텨", "tye"), "ㅌㅗ": ("토", "to"), "ㅌㅗㅏ": ("퇴", "twae"),
        "ㅌㅗㅐ": ("퇘", "twae"), "ㅌㅗㅣ": ("퇴", "toe"), "ㅌㅛ": ("툐", "tyo"), "ㅌㅜ": ("투", "tu"), "ㅌㅜㅓ": ("퉤", "twoe"),
        "ㅌㅜㅔ": ("튀", "twae"), "ㅌㅜㅣ": ("튜", "tyu"), "ㅌㅠ": ("투", "tu"), "ㅌㅡ": ("트", "teu"), "ㅌㅡㅣ": ("튀", "twi"),
        "ㅌㅣ": ("티", "ti"),

        "ㅍㅏ": ("파", "pa"), "ㅍㅐ": ("패", "pae"), "ㅍㅑ": ("퍄", "pyae"), "ㅍㅒ": ("페", "pyae"), "ㅍㅓ": ("퍼", "peo"),
        "ㅍㅔ": ("페", "pe"), "ㅍㅕ": ("펴", "pyeo"), "ㅍㅖ": ("폐", "pye"), "ㅍㅗ": ("포", "po"), "ㅍㅗㅏ": ("퐈", "pwae"),
        "ㅍㅗㅐ": ("풔", "pwae"), "ㅍㅗㅣ": ("푀", "poe"), "ㅍㅛ": ("표", "pyo"), "ㅍㅜ": ("푸", "pu"), "ㅍㅜㅓ": ("풰", "pwoe"),
        "ㅍㅜㅔ": ("퓌", "pwe"), "ㅍㅜㅣ": ("퓨", "pyu"), "ㅍㅠ": ("퓨", "pyu"), "ㅍㅡ": ("프", "peu"), "ㅍㅡㅣ": ("퓌", "pyu"),
        "ㅍㅣ": ("피", "pi"),

        "ㅎㅏ": ("하", "ha"), "ㅎㅐ": ("해", "hae"), "ㅎㅑ": ("햐", "hya"), "ㅎㅒ": ("혜", "hyae"), "ㅎㅓ": ("허", "heo"),
        "ㅎㅔ": ("헤", "he"), "ㅎㅕ": ("혀", "hyeo"), "ㅎㅖ": ("혜", "hye"), "ㅎㅗ": ("호", "ho"), "ㅎㅗㅏ": ("화", "hwa"),
        "ㅎㅗㅐ": ("회", "hwae"), "ㅎㅗㅣ": ("회", "hoe"), "ㅎㅛ": ("효", "hyo"), "ㅎㅜ": ("후", "hu"), "ㅎㅜㅓ": ("훼", "hwoe"),
        "ㅎㅜㅔ": ("회", "hwe"), "ㅎㅜㅣ": ("휘", "hwi"), "ㅎㅠ": ("휴", "hyu"), "ㅎㅡ": ("흐", "heu"), "ㅎㅡㅣ": ("휴", "hyu"),
        "ㅎㅣ": ("히", "hi"),

        // Add more combinations if needed
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
                    ForEach(consonants, id: \.self) { consonant in
                        CardView(alphabet: consonant, selectedCards: $selectedCards, updateHangeulCombination: updateHangeulCombination, updatePronunciation: updatePronunciation, syllableDictionary: syllableDictionary, backgroundColor: .blue)
                    }
                    ForEach(vowels, id: \.self) { vowel in
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
        selectedCards.append(alphabet)
    }
}

