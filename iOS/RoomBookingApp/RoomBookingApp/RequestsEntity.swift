//
//  RequestEntity.swift
//  RoomBookingApp
//
//  Created by Olzhas Seiilkhanov on 23.06.2022.
//

import Foundation

struct Request: Decodable {
    let id: Int
    let contact: String
    let room_ID: Int
    let person: String
    let timefrom: String
    let timeto: String
}

//struct RequestsEntity: Decodable {
//    let requests: [Request]
//}
