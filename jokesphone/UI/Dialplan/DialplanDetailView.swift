//
//  DialplanDetailView.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 8/2/24.
//

import SwiftUI

struct DialplanDetailView: View {
    @ObservedObject private var viewModel: DialplanDetailViewModel
    @State var recordCall: Bool = true
    @Environment(\.presentationMode) var mode
    private let createBottomCredit: CreateBottomView

    init(viewModel: DialplanDetailViewModel,
         createBottomCredit: CreateBottomView) {
        self.viewModel = viewModel
        self.createBottomCredit = createBottomCredit
    }

    var body: some View {
        VStack {
            Text(viewModel.jokeDialplan.titulo)
                .font(.custom("Lato-Bold", size: 22))
                .bold()
                .foregroundColor(.redColorApp)
                .padding(.bottom, 20)
                .accessibilityIdentifier("detailTitle")
                .accessibilityValue(viewModel.idPrank)

            Text("Introduce el número o selecciona un contacto")
                .accessibilityIdentifier("detailContactInfo")

            TextEditor(text: $viewModel.contactNumber)
                .frame(height: 50)
                .multilineTextAlignment(.center)
                .overlay(
                    ZStack(alignment: .trailing) {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.redColorApp, lineWidth: 2)
                                HStack {
                                    Spacer()
                                    Image(systemName: "magnifyingglass")
                                        .padding(.trailing, 8)
                                        .foregroundColor(.redColorApp)
                                }
                            }
                )
                .padding(.horizontal, 12)
                .cornerRadius(3)
                .accessibilityIdentifier("detailContactEditor")

            Button(action: {
                viewModel.makeCall()
            }, label: {
                Label("Realizar Llamada", systemImage: "")
                    .foregroundColor(.white)
            })
            .controlSize(.large)
            .buttonStyle(.bordered)
            .background(.redColorApp)
            .clipShape(Capsule())
            .padding()
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
            .accessibilityIdentifier("btnCallDialplanDetail")

            HStack {
                Text("¿Grabar la Broma?")
                    .accessibilityIdentifier("detailRecordTitle")
                Toggle("", isOn: $recordCall)
                    .labelsHidden()
                    .tint(.redColorApp)
                    .accessibilityIdentifier("detailRecordToggle")
                Spacer()
            }
            .padding()

            Text("grabarinfo")
                .font(.custom("Lato-Regular", size: 13))
                .padding()
                .accessibilityIdentifier("detailRecordInfo")

            Spacer()

            createBottomCredit.create()
                .accessibilityIdentifier("footerDialplanDetail")
        }
        .alert(isPresented: $viewModel.showAlertResult, content: {
            Alert(title: viewModel.alertResultError ? Text("Error") : Text("Advertencia"),
                  message: Text(viewModel.resultMessage),
                  dismissButton: .default(Text("OK"), action: {
                self.mode.wrappedValue.dismiss()
            }))
        })
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "arrow.left")
        }))
    }
}

#Preview {
    DialplanDetailFactory().create(jokeDialplan: JokeDialplanPresentableItem.makePreview())
}
