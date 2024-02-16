//
//  UserPranksView.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 9/2/24.
//

import SwiftUI

struct UserPranksView: View {
    @ObservedObject private var viewModel: UserPranksViewModel
    private let createConfig: CreateConfigView
    private let createBottomCredit: CreateBottomView

    init(viewModel: UserPranksViewModel,
         createConfig: CreateConfigView,
         createBottomCredit: CreateBottomView) {
        self.viewModel = viewModel
        self.createConfig = createConfig
        self.createBottomCredit = createBottomCredit
    }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.showLoadingSpinner {
                    LoadingSpinnerView()
                } else {
                    if !viewModel.showError {

                            ScrollView {
                                ForEach(viewModel.userPranks.indices, id: \.self) { index in
                                    let userPrank = viewModel.userPranks[index]
                                    let setBackground = index % 2 == 0

                                    UserPranksItemView(item: userPrank, clearBackground: setBackground)

                                }
                            }
                            .navigationTitle("JokesPhone")
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    NavigationLink {
                                        createConfig.create()
                                    } label: {
                                        Image(systemName: "person.circle")
                                            .foregroundColor(.redColorApp)
                                    }.accessibilityIdentifier("toolbarUserPranks")
                                }
                            }

                        Spacer()

                        createBottomCredit.create()
                            .accessibilityIdentifier("footerUserPranks")

                    }
                }
            }

        }
        .accessibilityIdentifier("navigationUserPranks")
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
    UserPrankFactory.create()
}
