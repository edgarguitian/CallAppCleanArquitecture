//
//  UserPranksViewModel.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 9/2/24.
//

import Foundation

class UserPranksViewModel: ObservableObject {
    private let getUserPranks: GetUserPranksType
    private let errorMapper: JokesPhonePresentableErrorMapper
    private let presentableMapper: UserPrankPresentableMapper
    @Published var userPranks: [UserPrankPresentableItem] = []
    @Published var showLoadingSpinner: Bool = true
    @Published var errorMessage: String?
    @Published var showError: Bool = false

    init(getUserPranks: GetUserPranksType,
         errorMapper: JokesPhonePresentableErrorMapper,
         presentableMapper: UserPrankPresentableMapper) {
        self.getUserPranks = getUserPranks
        self.errorMapper = errorMapper
        self.presentableMapper = presentableMapper
    }

    func onAppear() {
        let uiTestErrorHandling = ProcessInfo.processInfo.arguments.contains("UITestErrorHandlingUserPranks")
        if uiTestErrorHandling {
            errorMessage = "Error al cargar la vista en UITest"
            showError = true
        } else {
            Task {
                let result = await getUserPranks.execute()
                handleResult(result)
            }
        }
    }

    private func handleResult(_ result: Result<[UserPrank], JokesPhoneDomainError>) {
        guard case .success(let userPranksInfo) = result else {
            handleError(error: result.failureValue as? JokesPhoneDomainError)
            return
        }

        let userPranksPresentable = presentableMapper.map(items: userPranksInfo)

        Task { @MainActor in
            showLoadingSpinner = false
            userPranks = userPranksPresentable
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
