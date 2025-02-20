//
//  NetworkError.swift
//  TravelAround
//
//  Created by Szczepan Abramczyk on 2/15/25.
//
enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}
