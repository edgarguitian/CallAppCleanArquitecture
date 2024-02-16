//
//  SplashViewModel.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

class SplashViewModel: ObservableObject {
    private let getUserStatus: GetStatusType
    private let errorMapper: JokesPhonePresentableErrorMapper
    @Published var showLoadingSpinner: Bool = true
    @Published var errorMessage: String?
    @Published var showError: Bool = false
    @Published var currentStatus: UserStatus?

    init(getUserStatus: GetStatusType,
         errorMapper: JokesPhonePresentableErrorMapper) {
        self.getUserStatus = getUserStatus
        self.errorMapper = errorMapper
    }

    func onAppear() {
        let uiTestErrorHandling = ProcessInfo.processInfo.arguments.contains("UITestErrorHandling")
        if uiTestErrorHandling {
            errorMessage = "Error al cargar la vista en UITest"
            showError = true
        } else {
            Task {
                let result = await getUserStatus.execute()
                handleResult(result)
            }
        }
    }

    private func handleResult(_ result: Result<UserStatus, JokesPhoneDomainError>) {
        guard case .success(let userStatusInfo) = result else {
            handleError(error: result.failureValue as? JokesPhoneDomainError)
            return
        }

        Task { @MainActor in
            let uiTestLoadingHandling = ProcessInfo.processInfo.arguments.contains("UITestLoadingHandling")
            if uiTestLoadingHandling {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.showLoadingSpinner = false
                }
            } else {
                showLoadingSpinner = false
            }
            currentStatus = userStatusInfo
            UserDefaultsManager.shared.recLocalIos = userStatusInfo.recLocalIos
            UserDefaultsManager.shared.shareURL = userStatusInfo.shareURL

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
