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
    
    // Dictionary to map each combination of Korean alphabets to their corresponding syllables
    let syllableDictionary: [String: String] = [
//      ===consonant-vowels
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
        "ㅈㅣ": "ji", "ㅊㅣ": "chi", "ㅋㅣ": "ki", "ㅌㅣ": "ti", "ㅍㅣ": "pi", "ㅎㅣ": "hi",
        "ㅃㅏ": "bba", "ㅃㅑ": "bbya", "ㅃㅓ": "bbeo", "ㅃㅕ": "bbyeo", "ㅃㅗ": "bbo",
        "ㅃㅛ": "bbyo", "ㅃㅜ": "bbu", "ㅃㅠ": "bbyu", "ㅃㅡ": "bbeu", "ㅃㅣ": "bbi",
        "ㅃㅐ": "bbae", "ㅃㅒ": "bbyae", "ㅃㅔ": "bbae", "ㅃㅖ": "bbyae",
        
//      ===consonant-vowels-consonant
        "ㄱㅏㄱ": "gag", "ㄴㅏㄴ": "nan", "ㄷㅏㄷ": "dad", "ㄹㅏㄹ": "ral", "ㅁㅏㅁ": "mam",
        "ㅂㅏㅂ": "bab", "ㅅㅏㅅ": "sas", "ㅇㅏㅇ": "ang", "ㅈㅏㅈ": "jaj", "ㅊㅏㅊ": "chach",
        "ㅋㅏㅋ": "kak", "ㅌㅏㅌ": "tat", "ㅍㅏㅍ": "pap", "ㅎㅏㅎ": "hah",
        "ㄱㅑㄱ": "gyag", "ㄴㅑㄴ": "nyan", "ㄷㅑㄷ": "dyad", "ㄹㅑㄹ": "ryar", "ㅁㅑㅁ": "myam",
        "ㅂㅑㅂ": "byab", "ㅅㅑㅅ": "syas", "ㅇㅑㅇ": "yang", "ㅈㅑㅈ": "jyaj", "ㅊㅑㅊ": "chaych",
        "ㅋㅑㅋ": "kyak", "ㅌㅑㅌ": "tyat", "ㅍㅑㅍ": "pyap", "ㅎㅑㅎ": "hyah",
        "ㄱㅓㄱ": "geog", "ㄴㅓㄴ": "neon", "ㄷㅓㄷ": "deod", "ㄹㅓㄹ": "reor", "ㅁㅓㅁ": "meom",
        "ㅂㅓㅂ": "beob", "ㅅㅓㅅ": "seos", "ㅇㅓㅇ": "eong", "ㅈㅓㅈ": "jeoj", "ㅊㅓㅊ": "cheoch",
        "ㅋㅓㅋ": "keok", "ㅌㅓㅌ": "teot", "ㅍㅓㅍ": "peop", "ㅎㅓㅎ": "heoh",
        "ㄱㅕㄱ": "gyeog", "ㄴㅕㄴ": "nyeon", "ㄷㅕㄷ": "dyoed", "ㄹㅕㄹ": "ryeol", "ㅁㅕㅁ": "myeom",
        "ㅂㅕㅂ": "byeob", "ㅅㅕㅅ": "syeos", "ㅇㅕㅇ": "yeong", "ㅈㅕㅈ": "jyeoj", "ㅊㅕㅊ": "chyeoch",
        "ㅋㅕㅋ": "kyeok", "ㅌㅕㅌ": "tyeot", "ㅍㅕㅍ": "pyeop", "ㅎㅕㅎ": "hyeoh",
        "ㄱㅗㄱ": "gog", "ㄴㅗㄴ": "nong", "ㄷㅗㄷ": "dod", "ㄹㅗㄹ": "rol", "ㅁㅗㅁ": "mom",
        "ㅂㅗㅂ": "bob", "ㅅㅗㅅ": "sos", "ㅇㅗㅇ": "ong", "ㅈㅗㅈ": "joj", "ㅊㅗㅊ": "choch",
        "ㅋㅗㅋ": "kok", "ㅌㅗㅌ": "tot", "ㅍㅗㅍ": "pop", "ㅎㅗㅎ": "hoh",
        "ㄱㅛㄱ": "gyog", "ㄴㅛㄴ": "nyog", "ㄷㅛㄷ": "dyod", "ㄹㅛㄹ": "ryol", "ㅁㅛㅁ": "myom",
        "ㅂㅛㅂ": "byob", "ㅅㅛㅅ": "syos", "ㅇㅛㅇ": "yong", "ㅈㅛㅈ": "jyoj", "ㅊㅛㅊ": "chyoct",
        "ㅋㅛㅋ": "kyok", "ㅌㅛㅌ": "tyoct", "ㅍㅛㅍ": "pyoct", "ㅎㅛㅎ": "hyoct",
        "ㄱㅜㄱ": "gug", "ㄴㅜㄴ": "nun", "ㄷㅜㄷ": "dud", "ㄹㅜㄹ": "rul", "ㅁㅜㅁ": "mum",
        "ㅂㅜㅂ": "bub", "ㅅㅜㅅ": "sus", "ㅇㅜㅇ": "ung", "ㅈㅜㅈ": "juj", "ㅊㅜㅊ": "chuch",
        "ㅋㅜㅋ": "kuk", "ㅌㅜㅌ": "tut", "ㅍㅜㅍ": "pup", "ㅎㅜㅎ": "huh",
        "ㄱㅠㄱ": "gyug", "ㄴㅠㄴ": "nyug", "ㄷㅠㄷ": "dyud", "ㄹㅠㄹ": "ryul", "ㅁㅠㅁ": "myum",
        "ㅂㅠㅂ": "byub", "ㅅㅠㅅ": "syus", "ㅇㅠㅇ": "yung", "ㅈㅠㅈ": "jyuj", "ㅊㅠㅊ": "chyuch",
        "ㅋㅠㅋ": "kyuk", "ㅌㅠㅌ": "tyut", "ㅍㅠㅍ": "pyup", "ㅎㅠㅎ": "hyuh",
        "ㅏㅣㄱ": "aig", "ㅑㅣㄴ": "yin", "ㅓㅣㄷ": "eod", "ㅕㅣㄹ": "yeol", "ㅗㅣㅁ": "oim",
        "ㅛㅣㅂ": "yib", "ㅜㅣㅅ": "uis", "ㅠㅣㅇ": "yung", "ㅡㅣㅈ": "uij", "ㅣㅣㅊ": "ich",
        "ㅂㅣㅋ": "bik", "ㅅㅣㅌ": "sit", "ㅈㅣㅍ": "jip", "ㅊㅣㅎ": "chih",
        "ㅃㅏㅂ": "bbap", "ㅃㅑㅂ": "bbyap", "ㅃㅓㅂ": "bbeob", "ㅃㅕㅂ": "bbyeob", "ㅃㅗㅂ": "bbob",
        "ㅃㅛㅂ": "bbyob", "ㅃㅜㅂ": "bub", "ㅃㅠㅂ": "bbyub", "ㅃㅡㅂ": "bbeub", "ㅃㅣㅂ": "bbib",
        "ㅃㅐㅂ": "bbaeb", "ㅃㅒㅂ": "bbyaeb", "ㅃㅔㅂ": "bbaeb", "ㅃㅖㅂ": "bbyaeb",
        
        // ===Consonant - Vowels - Vowels
        "ㄱㅏㅇㅡ": "gaweo", "ㄴㅏㅇㅡ": "nae", "ㄷㅏㅇㅡ": "deo", "ㄹㅏㅇㅡ": "rae", "ㅁㅏㅇㅡ": "mae",
        "ㅂㅏㅇㅡ": "bae", "ㅅㅏㅇㅡ": "seo", "ㅇㅏㅇㅡ": "aeng", "ㅈㅏㅇㅡ": "jae", "ㅊㅏㅇㅡ": "chae",
        "ㅋㅏㅇㅡ": "kae", "ㅌㅏㅇㅡ": "tae", "ㅍㅏㅇㅡ": "pae", "ㅎㅏㅇㅡ": "hae", "ㄱㅑㅇㅡ": "gyawi",
        "ㄴㅑㅇㅡ": "nyawi", "ㄷㅑㅇㅡ": "dyawi", "ㄹㅑㅇㅡ": "ryawi", "ㅁㅑㅇㅡ": "myawi", "ㅂㅑㅇㅡ": "byawi",
        "ㅅㅑㅇㅡ": "syawi", "ㅇㅑㅇㅡ": "yawi", "ㅈㅑㅇㅡ": "jyawi", "ㅊㅑㅇㅡ": "chyawi", "ㅋㅑㅇㅡ": "kyawi",
        "ㅌㅑㅇㅡ": "tyawi", "ㅍㅑㅇㅡ": "pyawi", "ㅎㅑㅇㅡ": "hyawi", "ㄱㅓㅇㅡ": "geoweo", "ㄴㅓㅇㅡ": "neoweo",
        "ㄷㅓㅇㅡ": "deoweo", "ㄹㅓㅇㅡ": "reoweo", "ㅁㅓㅇㅡ": "meoweo", "ㅂㅓㅇㅡ": "beoweo", "ㅅㅓㅇㅡ": "seoweo",
        "ㅇㅓㅇㅡ": "eoweo", "ㅈㅓㅇㅡ": "jeoweo", "ㅊㅓㅇㅡ": "cheoweo", "ㅋㅓㅇㅡ": "keoweo", "ㅌㅓㅇㅡ": "teoweo",
        "ㅍㅓㅇㅡ": "peoweo", "ㅎㅓㅇㅡ": "heoweo", "ㄱㅕㅇㅡ": "gyeoweo", "ㄴㅕㅇㅡ": "nyeoweo", "ㄷㅕㅇㅡ": "dyeoweo",
        "ㄹㅕㅇㅡ": "ryeoweo", "ㅁㅕㅇㅡ": "myeoweo", "ㅂㅕㅇㅡ": "byeoweo", "ㅅㅕㅇㅡ": "syeoweo", "ㅇㅕㅇㅡ": "yeoweo",
        "ㅈㅕㅇㅡ": "jyeoweo", "ㅊㅕㅇㅡ": "chyeoweo", "ㅋㅕㅇㅡ": "kyeoweo", "ㅌㅕㅇㅡ": "tyeoweo", "ㅍㅕㅇㅡ": "pyeoweo",
        "ㅎㅕㅇㅡ": "hyeoweo", "ㄱㅗㅇㅡ": "goi", "ㄴㅗㅇㅡ": "noi", "ㄷㅗㅇㅡ": "doi", "ㄹㅗㅇㅡ": "roi",
        "ㅁㅗㅇㅡ": "moi", "ㅂㅗㅇㅡ": "boi", "ㅅㅗㅇㅡ": "soi", "ㅇㅗㅇㅡ": "oi", "ㅈㅗㅇㅡ": "joi",
        "ㅊㅗㅇㅡ": "choi", "ㅋㅗㅇㅡ": "koi", "ㅌㅗㅇㅡ": "toi", "ㅍㅗㅇㅡ": "poi", "ㅎㅗㅇㅡ": "hoi",
        "ㄱㅛㅇㅡ": "gyoi", "ㄴㅛㅇㅡ": "nyoi", "ㄷㅛㅇㅡ": "dyoi", "ㄹㅛㅇㅡ": "ryoi", "ㅁㅛㅇㅡ": "myoi",
        "ㅂㅛㅇㅡ": "byoi", "ㅅㅛㅇㅡ": "syois", "ㅇㅛㅇㅡ": "yoi", "ㅈㅛㅇㅡ": "jyois", "ㅊㅛㅇㅡ": "chyois",
        "ㅋㅛㅇㅡ": "kyois", "ㅌㅛㅇㅡ": "tyois", "ㅍㅛㅇㅡ": "pyois", "ㅎㅛㅇㅡ": "hyois", "ㄱㅜㅇㅡ": "gui", "ㄴㅜㅇㅡ": "nui",
        "ㄷㅜㅇㅡ": "dui", "ㄹㅜㅇㅡ": "rui", "ㅁㅜㅇㅡ": "mui", "ㅂㅜㅇㅡ": "bui", "ㅅㅜㅇㅡ": "sui", "ㅇㅜㅇㅡ": "ui",
        "ㅈㅜㅇㅡ": "jui", "ㅊㅜㅇㅡ": "chui", "ㅋㅜㅇㅡ": "kui", "ㅌㅜㅇㅡ": "tui", "ㅍㅜㅇㅡ": "pui", "ㅎㅜㅇㅡ": "hui",
        "ㄱㅠㅇㅡ": "gyui", "ㄴㅠㅇㅡ": "nyui", "ㄷㅠㅇㅡ": "dyui", "ㄹㅠㅇㅡ": "ryui", "ㅁㅠㅇㅡ": "myui", "ㅂㅠㅇㅡ": "byui",
        "ㅅㅠㅇㅡ": "syui", "ㅇㅠㅇㅡ": "yui", "ㅈㅠㅇㅡ": "jyui", "ㅊㅠㅇㅡ": "chyui", "ㅋㅠㅇㅡ": "kyui",
        "ㅌㅠㅇㅡ": "tyui", "ㅍㅠㅇㅡ": "pyui", "ㅎㅠㅇㅡ": "hyui",
        "ㅃㅏㅏ": "bbaa", "ㅃㅑㅏ": "bbyaa", "ㅃㅓㅏ": "bbeoa", "ㅃㅕㅏ": "bbyeoa", "ㅃㅗㅏ": "bboaa",
        "ㅃㅛㅏ": "bbyoaa", "ㅃㅜㅏ": "bbuaa", "ㅃㅠㅏ": "bbyuaa", "ㅃㅡㅏ": "bbeuaa", "ㅃㅣㅏ": "bbiaa",
        "ㅃㅐㅏ": "bbaae", "ㅃㅒㅏ": "bbyaae", "ㅃㅔㅏ": "bbaae", "ㅃㅖㅏ": "bbyaae",
        
        // === Consonant - Vowels - Consonant - Consonant
        "ㄱㅏㄹㄱ": "galk", "ㄴㅏㄹㄴ": "naln", "ㄷㅏㄹㄷ": "dald", "ㄹㅏㄹㅁ": "ralm", "ㅁㅏㄹㅇ": "mang",
        "ㅂㅏㄹㅅ": "bals", "ㅅㅏㄹㅎ": "sahh", "ㅇㅏㄹㄴ": "anrn", "ㅈㅏㄹㅅ": "jasl", "ㅊㅏㄹㄹ": "charl",
        "ㅋㅏㄹㄱ": "kalg", "ㅌㅏㄹㄷ": "tald", "ㅍㅏㄹㄱ": "palk", "ㅎㅏㄹㅋ": "halk", "ㄱㅑㄹㅂ": "gyalb",
        "ㄴㅑㄹㅌ": "nyalt", "ㄷㅑㄹㄷ": "dyald", "ㄹㅑㄹㅂ": "ryalb", "ㅁㅑㄹㅇ": "myang", "ㅂㅑㄹㅁ": "byalm",
        "ㅅㅑㄹㅇ": "syang", "ㅇㅑㄹㄴ": "yangn", "ㅈㅑㄹㅈ": "jyalj", "ㅊㅑㄹㅋ": "chyalk", "ㅋㅑㄹㅈ": "kyalj",
        "ㅌㅑㄹㅇ": "tyang", "ㅍㅑㄹㅈ": "pyalj", "ㅎㅑㄹㅇ": "hyang", "ㄱㅓㄹㄱ": "geolg", "ㄴㅓㄹㄴ": "neoln",
        "ㄷㅓㄹㄷ": "deold", "ㄹㅓㄹㅇ": "reolm", "ㅁㅓㄹㅎ": "meolh", "ㅂㅓㄹㅅ": "beols", "ㅅㅓㄹㄹ": "seolr",
        "ㅇㅓㄹㄴ": "eoln", "ㅈㅓㄹㅎ": "jeolh", "ㅊㅓㄹㄹ": "cheolr", "ㅋㅓㄹㄱ": "keolg", "ㅌㅓㄹㄷ": "teold",
        "ㅍㅓㄹㅇ": "peolm", "ㅎㅓㄹㄷ": "heold", "ㄱㅕㄹㄱ": "gyeolg", "ㄴㅕㄹㄴ": "nyeoln", "ㄷㅕㄹㄷ": "dyeold",
        "ㄹㅕㄹㅁ": "ryeolm", "ㅁㅕㄹㅇ": "myeong", "ㅂㅕㄹㅅ": "byeols", "ㅅㅕㄹㅅ": "syeols", "ㅇㅕㄹㅁ": "yeolm",
        "ㅈㅕㄹㅈ": "jyeolj", "ㅊㅕㄹㄱ": "chyeolg", "ㅋㅕㄹㅈ": "kyeolj", "ㅌㅕㄹㅌ": "tyeolt", "ㅍㅕㄹㅍ": "pyeolp",
        "ㅎㅕㄹㄷ": "hyeold", "ㄱㅗㄹㅂ": "golb", "ㄴㅗㄹㅂ": "nolb", "ㄷㅗㄹㅂ": "dolb", "ㄹㅗㄹㅁ": "rolm",
        "ㅁㅗㄹㅅ": "mos", "ㅂㅗㄹㄷ": "bold", "ㅅㅗㄹㅎ": "sohh", "ㅇㅗㄹㄴ": "oln", "ㅈㅗㄹㅅ": "jols",
        "ㅊㅗㄹㅎ": "chohh", "ㅋㅗㄹㅂ": "kolb", "ㅌㅗㄹㅌ": "tolt", "ㅍㅗㄹㅇ": "pom", "ㅎㅗㄹㄷ": "hod",
        "ㄱㅛㄹㄱ": "gyolg", "ㄴㅛㄹㄴ": "nyoln", "ㄷㅛㄹㄷ": "dyold", "ㄹㅛㄹㅁ": "ryolm", "ㅁㅛㄹㅎ": "myoh",
        "ㅂㅛㄹㅅ": "byols", "ㅅㅛㄹㄹ": "syolr", "ㅇㅛㄹㄴ": "yoln", "ㅈㅛㄹㅎ": "jyoh", "ㅊㅛㄹㄹ": "cholr",
        "ㅋㅛㄹㄱ": "kyolg", "ㅌㅛㄹㄷ": "tyold", "ㅍㅛㄹㅇ": "pyolm", "ㅎㅛㄹㄷ": "hyold", "ㄱㅜㄹㄱ": "gulg",
        "ㄴㅜㄹㄴ": "nuln", "ㄷㅜㄹㄷ": "duld", "ㄹㅜㄹㅇ": "rulg", "ㅁㅜㄹㅁ": "mum", "ㅂㅜㄹㅂ": "bulp",
        "ㅅㅜㄹㅅ": "suls", "ㅇㅜㄹㅇ": "ulm", "ㅈㅜㄹㅅ": "juls", "ㅊㅜㄹㅌ": "chult", "ㅋㅜㄹㄱ": "kulg",
        "ㅌㅜㄹㅌ": "tult", "ㅍㅜㄹㅍ": "pulp", "ㅎㅜㄹㅎ": "hulh", "ㄱㅠㄹㄱ": "gyulg", "ㄴㅠㄹㄴ": "nyuln",
        "ㄷㅠㄹㄷ": "dyuld", "ㄹㅠㄹㅇ": "ryulg", "ㅁㅠㄹㅁ": "myulm", "ㅂㅠㄹㅂ": "byulp", "ㅅㅠㄹㅅ": "syuls",
        "ㅇㅠㄹㅇ": "yulm", "ㅈㅠㄹㅅ": "jyuls", "ㅊㅠㄹㅌ": "chyult", "ㅋㅠㄹㄱ": "kyulg", "ㅌㅠㄹㅌ": "tyult",
        "ㅍㅠㄹㅍ": "pyulp", "ㅎㅠㄹㅎ": "hyulh", "ㅏㅣㄹㄱ": "ailg", "ㅑㅣㄹㄴ": "yiln", "ㅓㅣㄹㄷ": "eold",
        "ㅕㅣㄹㅇ": "yeor", "ㅗㅣㄹㅁ": "oim", "ㅛㅣㄹㅎ": "yihh", "ㅜㅣㄹㅁ": "uim", "ㅠㅣㄹㄷ": "yuid",
        "ㅡㅣㄹㄱ": "uilg", "ㅇㅣㄹㄹ": "il", "ㅂㅣㄹㄹ": "bil", "ㅅㅣㄹㄱ": "silg", "ㅈㅣㄹㄹ": "jil",
        "ㅊㅣㄹㄹ": "chil", "ㅋㅣㄹㄱ": "kilg", "ㅌㅣㄹㄷ": "tild", "ㅍㅣㄹㄹ": "pil", "ㅎㅣㄹㄹ": "hil",
        
        //      ===consonant-vowels-vowels-consonant
        "ㅃㅏㅏㅂ": "bbaap", "ㅃㅑㅏㅂ": "bbyaap", "ㅃㅓㅏㅂ": "bbeoap", "ㅃㅕㅏㅂ": "bbyeoap", "ㅃㅗㅏㅂ": "bboap",
        "ㅃㅛㅏㅂ": "bbyoap", "ㅃㅜㅏㅂ": "bbuap", "ㅃㅠㅏㅂ": "bbyuap", "ㅃㅡㅏㅂ": "bbeuap", "ㅃㅣㅏㅂ": "bbiap",
        "ㅃㅐㅏㅂ": "bbaeap", "ㅃㅒㅏㅂ": "bbyaeap", "ㅃㅔㅏㅂ": "bbaeap", "ㅃㅖㅏㅂ": "bbyaeap",
        
        //      ===consonant-vowels-vowels-consonant-consonant
        "ㅃㅏㅇㅇㅂ": "bbangb", "ㅃㅑㅇㅇㅂ": "bbyangb", "ㅃㅓㅇㅇㅂ": "bbeongb", "ㅃㅕㅇㅇㅂ": "bbyeongb", "ㅃㅗㅇㅇㅂ": "bbongb",
        "ㅃㅛㅇㅇㅂ": "bbyongb", "ㅃㅜㅇㅇㅂ": "bbungb", "ㅃㅠㅇㅇㅂ": "bbyungb", "ㅃㅡㅇㅇㅂ": "bbeungb", "ㅃㅣㅇㅇㅂ": "bbingb",
        "ㅃㅐㅇㅇㅂ": "bbaengb", "ㅃㅒㅇㅇㅂ": "bbyaengb", "ㅃㅔㅇㅇㅂ": "bbaengb", "ㅃㅖㅇㅇㅂ": "bbyaengb",
    ]

    
    var body: some View {
        VStack {
            HangeulCombinationView(hangeulCombination: $hangeulCombination)
            PronunciationView(pronunciation: $pronunciation)
            
            ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 5), spacing: 10) {   
                        ForEach(consonantHangeul, id: \.self) { alphabet in
                            Button(action: {
                                toggleSelection(alphabet)
                                updateHangeulCombination()
                                updatePronunciation()
                            }) {
                                Text(alphabet)
                                    .padding(20)
                                    .foregroundColor(selectedCards.contains(alphabet) ? .white : .black)
                            }
                            .background(selectedCards.contains(alphabet) ? Color.blue.opacity(0.5) : Color.blue.opacity(0.2))
                            .cornerRadius(10)
                            .padding(1)
                        }
                        ForEach(vowelsHangeul, id: \.self) { alphabet in
                            Button(action: {
                                toggleSelection(alphabet)
                                updateHangeulCombination()
                                updatePronunciation()
                            }) {
                                Text(alphabet)
                                    .padding(20)
                                    .foregroundColor(selectedCards.contains(alphabet) ? .white : .black)
                            }
                            .background(selectedCards.contains(alphabet) ? Color.red.opacity(0.5) : Color.red.opacity(0.2))
                            .cornerRadius(10)
                            .padding(1)
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
    
    func toggleSelection(_ alphabet: String) {
        if let index = selectedCards.firstIndex(of: alphabet) {
            selectedCards.remove(at: index)
        } else {
            selectedCards.append(alphabet)
        }
    }
    
    
    func updatePronunciation() {
        let combinedSyllables = stride(from: 0, to: selectedCards.count, by: 2).map { index in
            let firstAlphabet = selectedCards[index]
            let secondAlphabet = index + 1 < selectedCards.count ? selectedCards[index + 1] : ""
            return syllableDictionary[firstAlphabet + secondAlphabet] ?? ""
        }
        pronunciation = combinedSyllables.joined()
    }
    
    func updateHangeulCombination() {
        hangeulCombination = selectedCards.joined()
    }
    
    func clearSelection() {
        selectedCards.removeAll()
        pronunciation = ""
        hangeulCombination = ""
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
}
