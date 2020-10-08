//
//  NetworkDataLoader.swift
//  labs-ios-starter
//
//  Created by Tobi Kuyoro on 06/10/2020.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

protocol NetworkDataLoader {
    func loadData(using request: URLRequest, completion: @escaping(Data?, URLResponse?, Error?) -> Void)
}
