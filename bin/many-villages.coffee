#!/usr/bin/env coffee





tw = require '../src/'    # load game



world = new tw.core.World
	mapSize: 1000



for i in [0 ... 1]
	player = new tw.core.Player
		id: world.playerId()

	village = new tw.core.Village
		id: world.villageId()
		position: world.villagePosition()

	player.add village
	world.add player

	do (village) ->
		console.log '-----'
		console.log village.warehouse.stocks.toString()
		console.log village.farm.workers.toString()
		console.log village.points.toString()
		village.headquarter.upgrade village.headquarter
		village.headquarter.upgrade village.warehouse
		village.headquarter.upgrade village.headquarter
		village.headquarter.upgrade village.farm
		village.headquarter.upgrade village.headquarter
		# todo: recruit, research
		village.headquarter.constructions.on 'progress', () ->
			console.log '-----'
			console.log village.warehouse.stocks.toString()
			console.log village.farm.workers.toString()
			console.log village.points.toString()
