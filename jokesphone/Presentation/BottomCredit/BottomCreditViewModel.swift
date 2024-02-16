//
//  BottomCreditViewModel.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 13/2/24.
//

import Foundation

class BottomCreditViewModel: ObservableObject {
    private let getCredit: GetCreditType
    @Published var userCredit: Int = 0
    @Published var showError: Bool = false

    init(getCredit: GetCreditType) {
        self.getCredit = getCredit
    }

    func onAppear() {
        Task {
            let result = await getCredit.execute()
            handleResult(result)
        }
    }

    private func handleResult(_ result: Result<UserCredit, JokesPhoneDomainError>) {
        guard case .success(let userCreditInfo) = result else {
            handleError(error: result.failureValue as? JokesPhoneDomainError)
            return
        }

        Task { @MainActor in
            userCredit = userCreditInfo.credit
        }
    }

    private func handleError(error: JokesPhoneDomainError?) {
        showError = true
    }
}
