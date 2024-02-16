//
//  SplashView.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject private var viewModel: SplashViewModel
    private let createMainView: CreateMainView

    init(viewModel: SplashViewModel, createMainView: CreateMainView) {
        self.viewModel = viewModel
        self.createMainView = createMainView
    }

    var body: some View {
        VStack {
            if viewModel.showLoadingSpinner {
                ZStack {
                    Image(.splash)
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        LoadingSpinnerView()
                        .accessibilityIdentifier("loadingSplash")
                }
            } else {
                if !viewModel.showError {
                    createMainView.create()
                }
            }
        }
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text("Advertencia"),
                  message: Text(viewModel.errorMessage!),
                  dismissButton: .default(Text("OK"), action: {
                exit(0)
            }))
        })
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    SplashFactory.create()
}
