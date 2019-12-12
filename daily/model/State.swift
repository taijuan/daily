//
//  State.swift
//  daily
//
//  Created by 郑泰捐 on 2019/11/22.
//  Copyright © 2019 郑泰捐. All rights reserved.
//

import Foundation
enum State<T> {
    case none
    case error(String)
    case refreshError(String)
    case loadMoreError(String)
    case success(T)
    case refreshSuccess(T)
    case loadMoreSuccess(T)
}
