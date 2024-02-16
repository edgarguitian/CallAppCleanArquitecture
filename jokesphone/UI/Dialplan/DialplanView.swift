//
//  DialplanView.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import SwiftUI

struct DialplanView: View {
    @ObservedObject private var viewModel: DialplanViewModel
    @State private var searchDialplanText: String = ""
    private let createDialplanDetail: CreateDialplanDetailView
    private let createConfig: CreateConfigView
    private let createBottomCredit: CreateBottomView

    init(viewModel: DialplanViewModel,
         createDialplanDetail: CreateDialplanDetailView,
         createConfig: CreateConfigView,
         createBottomCredit: CreateBottomView) {
        self.viewModel = viewModel
        self.createDialplanDetail = createDialplanDetail
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
                                ForEach(viewModel.filteredJokeDialplan.indices, id: \.self) { index in
                                    let dialplan = viewModel.filteredJokeDialplan[index]
                                    let setBackground = index % 2 == 0

                                    NavigationLink {
                                        createDialplanDetail.create(jokeDialplan: dialplan)
                                    } label: {
                                        DialplanItemView(item: dialplan, clearBackground: setBackground)
                                    }
                                    .accessibilityIdentifier("navItemDialplan")
                                }

                                .accessibilityIdentifier("forEachDialplan")
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
                                    }.accessibilityIdentifier("toolbarDialplan")
                                }
                            }

                        Spacer()

                        createBottomCredit.create()
                            .accessibilityIdentifier("footerDialplan")

                    }
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
        .accessibilityIdentifier("navigationDialplan")
        .searchable(text: $searchDialplanText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: searchDialplanText) { _, newValue in
            viewModel.search(searchText: newValue)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    DialplanFactory.create()
}
