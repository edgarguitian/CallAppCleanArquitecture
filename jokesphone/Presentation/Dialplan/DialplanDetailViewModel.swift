//
//  DialplanDetailViewModel.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 8/2/24.
//

import Foundation

class DialplanDetailViewModel: ObservableObject {
    let jokeDialplan: JokeDialplanPresentableItem
    private let makeCallUseCase: MakeCallType
    @Published var contactNumber: String = ""
    @Published var showLoadingSpinner: Bool = true
    @Published var resultMessage: String = ""
    @Published var showAlertResult: Bool = false
    @Published var alertResultError: Bool = false
    @Published var idPrank: String = ""

    init(jokeDialplan: JokeDialplanPresentableItem,
         makeCallUseCase: MakeCallType) {
        self.jokeDialplan = jokeDialplan
        self.makeCallUseCase = makeCallUseCase
    }

    func makeCall() {
        Task {
            let result = await makeCallUseCase.execute(title: jokeDialplan.titulo,
                                                       dial: jokeDialplan.id,
                                                       dstCall: contactNumber,
                                                       name: contactNumber)
            handleResult(result)
        }

    }

    private func handleResult(_ result: Result<MakeCallResult, JokesPhoneDomainError>) {
        guard case .success(let makeCallResult) = result else {
            handleError(error: result.failureValue as? JokesPhoneDomainError)
            return
        }

        Task { @MainActor in
            showLoadingSpinner = false
            if makeCallResult.res {
                resultMessage = "Broma ejecutada satisfactoriamente."
                if let idCall = makeCallResult.idCall {
                    idPrank = idCall
                }
                alertResultError = false
            } else {
                alertResultError = true
                if let messageCall = makeCallResult.content {
                    resultMessage = messageCall
                } else {
                    resultMessage = "Hubo un error al hacer la llamada. Pruebe más tarde."
                }
            }
            showAlertResult = true
        }
    }

    private func handleError(error: JokesPhoneDomainError?) {
        Task { @MainActor in
            showLoadingSpinner = false
            showAlertResult = true
            alertResultError = true
            guard let error = error else {
                return
            }
            resultMessage = error.localizedDescription
        }
    }

}
