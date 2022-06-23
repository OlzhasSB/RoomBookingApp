//
//  RequestEntity.swift
//  RoomBookingApp
//
//  Created by Olzhas Seiilkhanov on 23.06.2022.
//

import Foundation

struct Request: Decodable {
    let id: Int
    let person: String
    let room_ID: Int
    let timefrom: String
    let timeto: String
    let contact: String
}

//struct RequestsEntity: Decodable {
//    let requests: [Request]
//}
