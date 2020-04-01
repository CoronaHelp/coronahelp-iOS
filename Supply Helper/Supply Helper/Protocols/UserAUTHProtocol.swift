//
//  UserAUTHProtocol.swift
//  Supply Helper
//
//  Created by Lambda_School_Loaner_214 on 3/31/20.
//  Copyright © 2020 Empty Bliss. All rights reserved.
//

import Foundation

protocol UserAUTHProtocol {
    func register(with user: User, completion: @escaping (Error?) -> Void)
    func signIn(with signInInfo: SignInInfo, completion: @escaping (Int?, Error?) -> Void)
    func logout(completion: @escaping () -> Void)
}
