//
//  infoView.swift
//  geuljamisul
//
//  Created by Ileene Trinia Santoso on 04/05/24.
//

import SwiftUI

struct infoView: View {
    var body: some View {
        VStack {
            Text("Welcome to\n 글자미술\n")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.top, 35)
            
            ScrollView{
                VStack(alignment: .leading, spacing: 10) {
                    Text("1. This app only provide 1 syllable to convert it to latin alphabets (romanization).\n")
                    Text("2. Blue: consonants\n    Red: vowels\n")
                    Text("3. The romanization only works if blue and red combined.\nYou can't combine blue-blue.\n")
                    Text("4. You can combine:")
                    Image("bluered")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.vertical, 1)
                    Text("\n5. You can find this rules again on help button in top right of the page.")
                }
                .padding([.horizontal, .bottom], 35)
            }
        }
    }
}

#Preview {
    infoView()
}
