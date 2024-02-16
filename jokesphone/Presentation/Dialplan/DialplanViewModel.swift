//
//  DialplanViewModel.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 7/2/24.
//

import Foundation

class DialplanViewModel: ObservableObject {
    private let getDialplan: GetDialplanType
    private let errorMapper: JokesPhonePresentableErrorMapper
    private let presentableMapper: JokeDialplanPresentableMapper
    @Published var filteredJokeDialplan: [JokeDialplanPresentableItem] = []
    var jokeDialplan: [JokeDialplanPresentableItem] = []
    @Published var showLoadingSpinner: Bool = true
    @Published var errorMessage: String?
    @Published var showError: Bool = false

    init(getDialplan: GetDialplanType,
         errorMapper: JokesPhonePresentableErrorMapper,
         presentableMapper: JokeDialplanPresentableMapper) {
        self.getDialplan = getDialplan
        self.errorMapper = errorMapper
        self.presentableMapper = presentableMapper
    }

    func onAppear() {
        let uiTestErrorHandling = ProcessInfo.processInfo.arguments.contains("UITestErrorHandlingDialplan")
        if uiTestErrorHandling {
            errorMessage = "Error al cargar la vista en UITest"
            showError = true
        } else {
            Task {
                let result = await getDialplan.execute()
                handleResult(result)
            }
        }
    }

    func search(searchText: String) {

        if searchText.isEmpty {
            showLoadingSpinner = false
            filteredJokeDialplan = jokeDialplan
        } else {
            if searchText.count > 2 {
                filteredJokeDialplan = jokeDialplan.filter { result in
                    let matchTitle = result.titulo.lowercased().contains(searchText.lowercased())
                    let matchDesc = result.desc.lowercased().contains(searchText.lowercased())

                    return matchTitle || matchDesc
                }
            }
        }
    }

    private func handleResult(_ result: Result<[JokeDialplan], JokesPhoneDomainError>) {
        guard case .success(let dialplanInfo) = result else {
            handleError(error: result.failureValue as? JokesPhoneDomainError)
            return
        }

        let dialplanPresentable = presentableMapper.map(items: dialplanInfo)

        Task { @MainActor in
            showLoadingSpinner = false
            showError = false
            filteredJokeDialplan = dialplanPresentable
            jokeDialplan = dialplanPresentable
        }
    }

    private func handleError(error: JokesPhoneDomainError?) {
        Task { @MainActor in
            showLoadingSpinner = false
            errorMessage = errorMapper.map(error: error)
            showError = true
        }
    }

}
