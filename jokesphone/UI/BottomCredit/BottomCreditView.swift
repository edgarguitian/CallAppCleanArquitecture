//
//  BottomCreditView.swift
//  jokesphone
//
//  Created by Edgar Guitian Rey on 8/2/24.
//

import SwiftUI

struct BottomCreditView: View {
    private let createShop: CreateShopView
    @ObservedObject private var viewModel: BottomCreditViewModel

    init(viewModel: BottomCreditViewModel,
         createShop: CreateShopView) {
        self.viewModel = viewModel
        self.createShop = createShop
    }

    var body: some View {
        HStack {
            VStack {
                Text("Tienes \(viewModel.userCredit) llamadas!")
                    .foregroundColor(.white)
                Text("Términos y condiciones")
                    .foregroundColor(.white)

            }

            Spacer()

            NavigationLink {
                createShop.create()
            } label: {
                HStack {
                    Image(systemName: "cart.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .padding()

                    Text("Adquirir Llamadas")
                        .foregroundColor(.black)
                        .padding(5)

                }
                .padding(.horizontal, 2)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.yellow)
                )
            }

            Spacer()
        }
        .padding()
        .background(.redColorApp)
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    BottomCreditFactory().create()
}
