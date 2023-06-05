//
//  ErrorView.swift
//  testApp
//
//  Created by Shen Beibei on 05/06/2023.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper

    // access the view's dismiss structure and call it like a function to dimiss the view
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Text("An error has occurred!")
                    .font(.title).padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance).font(.caption).padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum SampleError: Error {
        case errorRequired
    }

    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.errorRequired, guidance: "You can safely ignore this error.")
    }

    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
}
