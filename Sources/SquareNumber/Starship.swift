//
//  Starship.swift
//  SquareNumber
//
//  Created by Isaac Halvorson on 7/9/20.
//

import Foundation

/*
Example JSON:
{
	"name": "Death Star",
	"model": "DS-1 Orbital Battle Station",
	"manufacturer": "Imperial Department of Military Research, Sienar Fleet Systems",
	"cost_in_credits": "1000000000000",
	"length": "120000",
	"max_atmosphering_speed": "n/a",
	"crew": "342,953",
	"passengers": "843,342",
	"cargo_capacity": "1000000000000",
	"consumables": "3 years",
	"hyperdrive_rating": "4.0",
	"MGLT": "10",
	"starship_class": "Deep Space Mobile Battlestation",
	"pilots": [],
	"films": [
		"http://swapi.dev/api/films/1/"
	],
	"created": "2014-12-10T16:36:50.509000Z",
	"edited": "2014-12-20T21:26:24.783000Z",
	"url": "http://swapi.dev/api/starships/9/"
}
*/

struct Starship: Codable {
	let name: String
	let model: String
	let starship_class: String
	let manufacturer: String
	let cost_in_credits: String
	let length: String
	let crew: String
	let passengers: String
	let max_atmosphering_speed: String
	let hyperdrive_rating: String
	let MGLT: String
	let cargo_capacity: String
	let consumables: String
	let films: [String]
	let pilots: [String]
	let url: String
	let created: String
	let edited: String
}
