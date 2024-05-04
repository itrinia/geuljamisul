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
    @State private var isInfoViewPresented = false
    
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
        
        "ㅇㅏ": ("아", "a"), "ㅇㅐ": ("애", "ae"), "ㅇㅑ": ("야", "ya"), "ㅇㅒ": ("얘", "yae"), "ㅇㅓ": ("어", "eo"),
        "ㅇㅔ": ("에", "e"), "ㅇㅕ": ("여", "yeo"), "ㅇㅖ": ("예", "ye"), "ㅇㅗ": ("오", "o"), "ㅇㅗㅏ": ("와", "wa"),
        "ㅇㅗㅐ": ("왜", "wae"), "ㅇㅗㅣ": ("외", "oi"), "ㅇㅛ": ("요", "yo"), "ㅇㅜ": ("우", "u"), "ㅇㅜㅓ": ("워", "wo"),
        "ㅇㅜㅔ": ("웨", "we"), "ㅇㅜㅣ": ("위", "wi"), "ㅇㅠ": ("유", "yu"), "ㅇㅡ": ("으", "eu"), "ㅇㅡㅣ": ("의", "ui"),
        "ㅇㅣ": ("이", "i"),

        "ㅈㅏ": ("자", "ja"), "ㅈㅐ": ("재", "jae"), "ㅈㅑ": ("쟈", "jya"), "ㅈㅒ": ("쟤", "jyae"), "ㅈㅓ": ("저", "jeo"),
        "ㅈㅔ": ("제", "je"), "ㅈㅕ": ("져", "jyeo"), "ㅈㅖ": ("졔", "jye"), "ㅈㅗ": ("조", "jo"), "ㅈㅗㅏ": ("좌", "jwa"),
        "ㅈㅗㅐ": ("좨", "jwae"), "ㅈㅗㅣ": ("죄", "joi"), "ㅈㅛ": ("죠", "jyo"), "ㅈㅜ": ("주", "ju"), "ㅈㅜㅓ": ("쥐", "jwi"),
        "ㅈㅜㅔ": ("줴", "jwe"), "ㅈㅠ": ("쥬", "jyu"), "ㅈㅜㅣ": ("쥐", "jwi"), "ㅈㅡ": ("즈", "jeu"), "ㅈㅡㅣ": ("즤", "jui"),
        "ㅈㅣ": ("지", "ji"),

        "ㅊㅏ": ("차", "cha"), "ㅊㅐ": ("채", "chae"), "ㅊㅑ": ("챠", "chya"), "ㅊㅒ": ("챼", "chyae"), "ㅊㅓ": ("처", "cheo"),
        "ㅊㅔ": ("체", "che"), "ㅊㅕ": ("쳐", "chyeo"), "ㅊㅖ": ("쳬", "chye"), "ㅊㅗ": ("초", "cho"), "ㅊㅗㅏ": ("촤", "chwa"),
        "ㅊㅗㅐ": ("쵀", "chwae"), "ㅊㅗㅣ": ("최", "choi"), "ㅊㅛ": ("쵸", "chyo"), "ㅊㅜ": ("추", "chu"), "ㅊㅜㅓ": ("춰", "chwo"),
        "ㅊㅜㅔ": ("췌", "chwe"), "ㅊㅜㅣ": ("취", "chwi"), "ㅊㅠ": ("츄", "chyu"), "ㅊㅡ": ("츠", "cheu"), "ㅊㅡㅣ": ("츼", "cheui"),
        "ㅊㅣ": ("치", "chi"),

        "ㅋㅏ": ("카", "kha"), "ㅋㅐ": ("캐", "khae"), "ㅋㅑ": ("캬", "khya"), "ㅋㅒ": ("케", "khyae"), "ㅋㅓ": ("커", "kheo"),
        "ㅋㅔ": ("켜", "khe"), "ㅋㅕ": ("켜", "khyeo"), "ㅋㅖ": ("켸", "khye"), "ㅋㅗ": ("코", "kho"), "ㅋㅗㅏ": ("콰", "khwa"),
        "ㅋㅗㅐ": ("쾌", "khwae"), "ㅋㅗㅣ": ("쾨", "khoe"), "ㅋㅛ": ("쿄", "khyo"), "ㅋㅜ": ("쿠", "khu"), "ㅋㅜㅓ": ("쿼", "khwo"),
        "ㅋㅜㅔ": ("퀘", "khwoe"), "ㅋㅜㅣ": ("퀴", "khwi"), "ㅋㅠ": ("큐", "khyu"), "ㅋㅡ": ("크", "kheu"), "ㅋㅡㅣ": ("킈", "kheui"),
        "ㅋㅣ": ("키", "khi"),

        "ㅌㅏ": ("타", "tha"), "ㅌㅐ": ("태", "thae"), "ㅌㅑ": ("탸", "thya"), "ㅌㅒ": ("턔", "thyae"), "ㅌㅓ": ("터", "theo"),
        "ㅌㅔ": ("테", "the"), "ㅌㅕ": ("텨", "thyeo"), "ㅌㅖ": ("톄", "thye"), "ㅌㅗ": ("토", "tho"), "ㅌㅗㅏ": ("톼", "thwa"),
        "ㅌㅗㅐ": ("퇘", "thwae"), "ㅌㅗㅣ": ("퇴", "thoe"), "ㅌㅛ": ("툐", "thyo"), "ㅌㅜ": ("투", "thu"), "ㅌㅜㅓ": ("퉈", "thwo"),
        "ㅌㅜㅔ": ("퉤", "thwoe"), "ㅌㅜㅣ": ("튀", "thwi"), "ㅌㅠ": ("튜", "thyu"), "ㅌㅡ": ("트", "theu"), "ㅌㅡㅣ": ("틔", "theui"),
        "ㅌㅣ": ("티", "thi"),

        "ㅍㅏ": ("파", "pha"), "ㅍㅐ": ("패", "phae"), "ㅍㅑ": ("퍄", "phya"), "ㅍㅒ": ("퍠", "phyae"), "ㅍㅓ": ("퍼", "pheo"),
        "ㅍㅔ": ("페", "phe"), "ㅍㅕ": ("펴", "phyeo"), "ㅍㅖ": ("폐", "phye"), "ㅍㅗ": ("포", "pho"), "ㅍㅗㅏ": ("퐈", "phwa"),
        "ㅍㅗㅐ": ("퐤", "phwae"), "ㅍㅗㅣ": ("푀", "phoe"), "ㅍㅛ": ("표", "phyo"), "ㅍㅜ": ("푸", "phu"), "ㅍㅜㅓ": ("풔", "phwoe"),
        "ㅍㅜㅔ": ("풰", "phwe"), "ㅍㅜㅣ": ("퓌", "phwi"), "ㅍㅠ": ("퓨", "phyu"), "ㅍㅡ": ("프", "pheu"), "ㅍㅡㅣ": ("픠", "phyui"),
        "ㅍㅣ": ("피", "pi"),

        "ㅎㅏ": ("하", "ha"), "ㅎㅐ": ("해", "hae"), "ㅎㅑ": ("햐", "hya"), "ㅎㅒ": ("햬", "hyae"), "ㅎㅓ": ("허", "heo"),
        "ㅎㅔ": ("헤", "he"), "ㅎㅕ": ("혀", "hyeo"), "ㅎㅖ": ("혜", "hye"), "ㅎㅗ": ("호", "ho"), "ㅎㅗㅏ": ("화", "hwa"),
        "ㅎㅗㅐ": ("홰", "hwae"), "ㅎㅗㅣ": ("회", "hoe"), "ㅎㅛ": ("효", "hyo"), "ㅎㅜ": ("후", "hu"), "ㅎㅜㅓ": ("훠", "hwo"),
        "ㅎㅜㅔ": ("훼", "hwe"), "ㅎㅜㅣ": ("휘", "hwi"), "ㅎㅠ": ("휴", "hyu"), "ㅎㅡ": ("흐", "heu"), "ㅎㅡㅣ": ("희", "hui"),
        "ㅎㅣ": ("히", "hi"),
        
        "ㅃㅏ": ("빠", "bba"), "ㅃㅐ": ("빼", "bbae"), "ㅃㅑ": ("뺘", "bbya"), "ㅃㅒ": ("뺴", "bbyae"), "ㅃㅓ": ("뻐", "bbeo"),
        "ㅃㅔ": ("뻬", "bbe"), "ㅃㅕ": ("뼈", "bbye"), "ㅃㅖ": ("뼤", "bbye"), "ㅃㅗ": ("뽀", "bbo"), "ㅃㅗㅏ": ("뽜", "bbwa"),
        "ㅃㅗㅐ": ("뿨", "bbwae"), "ㅃㅗㅣ": ("뾰", "bboe"), "ㅃㅛ": ("뿌", "bbyo"), "ㅃㅜ": ("뿨", "bbu"), "ㅃㅜㅓ": ("뿌", "bbwoe"),
        "ㅃㅜㅔ": ("쀼", "bbwe"), "ㅃㅜㅣ": ("뿌", "bbwi"), "ㅃㅠ": ("뿌", "bbyu"), "ㅃㅡ": ("쁘", "bbeu"), "ㅃㅡㅣ": ("쁘", "bbeu"),
        "ㅃㅣ": ("삐", "bbi"),

        "ㅉㅏ": ("짜", "jja"), "ㅉㅐ": ("쟤", "jjae"), "ㅉㅑ": ("쨔", "jjya"), "ㅉㅒ": ("쟤", "jjae"), "ㅉㅓ": ("쩌", "jjeo"),
        "ㅉㅔ": ("쩨", "jje"), "ㅉㅕ": ("쨰", "jjye"), "ㅉㅖ": ("쩨", "jjye"), "ㅉㅗ": ("쪼", "jjo"), "ㅉㅗㅏ": ("쪼", "jjwa"),
        "ㅉㅗㅐ": ("쮸", "jjwae"), "ㅉㅗㅣ": ("쮸", "jjoe"), "ㅉㅛ": ("쮸", "jjyo"), "ㅉㅜ": ("쭈", "jju"), "ㅉㅜㅓ": ("쮜", "jjwoe"),
        "ㅉㅜㅔ": ("쮸", "jjwe"), "ㅉㅜㅣ": ("쭤", "jjwi"), "ㅉㅠ": ("쭈", "jju"), "ㅉㅡ": ("쭤", "jjeu"), "ㅉㅡㅣ": ("쭤", "jjeu"),
        "ㅉㅣ": ("찌", "jji"),

        "ㄸㅏ": ("따", "dda"), "ㄸㅐ": ("때", "ddae"), "ㄸㅑ": ("땨", "ddya"), "ㄸㅒ": ("때", "ddae"), "ㄸㅓ": ("떠", "ddeo"),
        "ㄸㅔ": ("떼", "dde"), "ㄸㅕ": ("뗘", "ddye"), "ㄸㅖ": ("떴", "ddye"), "ㄸㅗ": ("또", "ddo"), "ㄸㅗㅏ": ("똬", "ddwa"),
        "ㄸㅗㅐ": ("뙈", "ddwae"), "ㄸㅗㅣ": ("뙤", "ddoe"), "ㄸㅛ": ("뚀", "ddyo"), "ㄸㅜ": ("뚜", "ddu"), "ㄸㅜㅓ": ("뚸", "ddwoe"),
        "ㄸㅜㅔ": ("뚸", "ddwe"), "ㄸㅜㅣ": ("뜌", "ddwi"), "ㄸㅠ": ("뚸", "ddyu"), "ㄸㅡ": ("뜨", "ddeu"), "ㄸㅡㅣ": ("뜌", "ddwi"),
        "ㄸㅣ": ("띠", "ddi"),

        "ㄲㅏ": ("까", "kka"), "ㄲㅐ": ("개", "kkae"), "ㄲㅑ": ("꺄", "kkya"), "ㄲㅒ": ("개", "kkae"), "ㄲㅓ": ("꺼", "kkeo"),
        "ㄲㅔ": ("께", "kke"), "ㄲㅕ": ("꼐", "kkye"), "ㄲㅖ": ("께", "kkye"), "ㄲㅗ": ("꼬", "kko"), "ㄲㅗㅏ": ("꽈", "kkwa"),
        "ㄲㅗㅐ": ("꽤", "kkwae"), "ㄲㅗㅣ": ("꾀", "kkoe"), "ㄲㅛ": ("꾜", "kkyo"), "ㄲㅜ": ("꾸", "kku"), "ㄲㅜㅓ": ("꾀", "kkwoe"),
        "ㄲㅜㅔ": ("꾸", "kkwe"), "ㄲㅜㅣ": ("뀨", "kkwi"), "ㄲㅠ": ("꾸", "kkyu"), "ㄲㅡ": ("뀌", "kkeu"), "ㄲㅡㅣ": ("뀨", "kkwi"),
        "ㄲㅣ": ("끼", "kki"),

        "ㅆㅏ": ("싸", "ssa"), "ㅆㅐ": ("새", "ssae"), "ㅆㅑ": ("쌰", "ssya"), "ㅆㅒ": ("새", "ssae"), "ㅆㅓ": ("서", "sseo"),
        "ㅆㅔ": ("새", "sse"), "ㅆㅕ": ("셰", "ssye"), "ㅆㅖ": ("셰", "ssye"), "ㅆㅗ": ("소", "sso"), "ㅆㅗㅏ": ("쏘", "sswa"),
        "ㅆㅗㅐ": ("쏴", "sswae"), "ㅆㅗㅣ": ("쏴", "ssoe"), "ㅆㅛ": ("쇼", "ssyo"), "ㅆㅜ": ("수", "ssu"), "ㅆㅜㅓ": ("쏴", "sswoe"),
        "ㅆㅜㅔ": ("쑈", "sswe"), "ㅆㅜㅣ": ("쑤", "sswi"), "ㅆㅠ": ("쑤", "ssyu"), "ㅆㅡ": ("쓰", "sseu"), "ㅆㅡㅣ": ("쑤", "ssyu"),
        "ㅆㅣ": ("씨", "ssi"),
        
        "ㅋㅋ": ("ㅋㅋ", "🤣🤣"), "ㅠㅠ": ("ㅠㅠ", "😭😭😭")
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
        .navigationBarTitle("") // Empty title to remove back button title
        .navigationBarBackButtonHidden(true) // Hide the back button
        .navigationBarItems(trailing:
        Button(action: {
            isInfoViewPresented.toggle()
        }) {
            Image(systemName: "info.circle")
            }
        )
        .sheet(isPresented: $isInfoViewPresented) {
            infoView() // Present InfoView modally
        }
    }
    
    func updatePronunciation() {
        var combinedSyllables = [String]()
        for index in stride(from: 0, to: selectedCards.count, by: 2) {
            let firstAlphabet = selectedCards[index]
            let secondAlphabet = index + 1 < selectedCards.count ? selectedCards[index + 1] : ""
            let combination = firstAlphabet + secondAlphabet
            if let syllableInfo = syllableDictionary[combination] {
                combinedSyllables.append(syllableInfo.pronunciation)
            } else {
                pronunciation = "Incorrect Combination"
                return
            }
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

