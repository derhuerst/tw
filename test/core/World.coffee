assert =			require 'assert'
sinon =				require 'sinon'
{EventEmitter} =	require 'events'

config =			require '../../config'
World =				require '../../src/core/World'
Village =			require '../../src/core/Village'
Vector =			require '../../src/util/Vector'
Player =			require '../../src/core/Player'
GameError =			require '../../src/util/GameError'





describe 'World', ->

	w = null
	v = null
	p = null

	beforeEach ->
		w = new World()
		v = new Village
			id:			'village-1'
			position:	new Vector 1, 1
		p = new Player
			id:			'player-1'
			villages:	[v]

	it '`isWorld`', ->
		assert.strictEqual w.isWorld, true

	it 'should inherit from `EventEmitter`', ->
		assert w instanceof EventEmitter



	describe 'World::addVillage', ->

		it 'should return the instance', ->
			assert.strictEqual w.addVillage(), w
			assert.strictEqual w.addVillage(v), w

		it 'should emit an `add-village` event with the given `Village`', ->
			onAddVillage = sinon.spy()
			w.on 'add-village', onAddVillage
			w.addVillage v
			assert onAddVillage.calledOnce
			assert onAddVillage.calledWithExactly v

		it 'should throw a `GameError` if a village is already added', ->
			addTwice = ->
				w.addVillage v
				w.addVillage v
			assert.throws addTwice, GameError

		it 'should throw a `GameError` if the map position is occupied', ->
			v2 = Object.assign {}, v, id: 'village-2'
			addBoth = ->
				w.addVillage v
				w.addVillage v2
			assert.throws addBoth, GameError



	describe 'World::getVillage', ->

		beforeEach -> w.addVillage v

		it 'should return `null` for a non-existent `Village`', ->
			assert.strictEqual w.getVillage('non-existent'), null

		it 'should return a `Village` by id', ->
			assert.strictEqual w.getVillage(v.id), v

		it 'should return a `Village` by position', ->
			assert.strictEqual w.getVillage(v.position), v



	describe 'World::deleteVillage', ->

		beforeEach -> w.addVillage v

		it 'should return the instance', ->
			assert.strictEqual w.deleteVillage(), w
			assert.strictEqual w.deleteVillage(v), w

		it 'should emit an `delete-village` event with the given `Village`', ->
			onDeleteVillage = sinon.spy()
			w.on 'delete-village', onDeleteVillage
			w.deleteVillage v
			assert onDeleteVillage.calledOnce
			assert onDeleteVillage.calledWithExactly v

		it 'should throw a `GameError` if a village does not exist', ->
			deleteTwice = ->
				w.deleteVillage v
				w.deleteVillage v
			assert.throws deleteTwice, GameError



	it 'should consistently add, get and delete a `Village`', ->
		w.addVillage v
		assert.strictEqual w.getVillage(v.id), v
		w.deleteVillage v
		assert.strictEqual w.getVillage(v.id), null



	describe 'World::addPlayer', ->

		it 'should return the instance', ->
			assert.strictEqual w.addPlayer(), w
			assert.strictEqual w.addPlayer(p), w

		it 'should emit an `add-player` event with the given `Player`', ->
			onAddPlayer = sinon.spy()
			w.on 'add-player', onAddPlayer
			w.addPlayer p
			assert onAddPlayer.calledOnce
			assert onAddPlayer.calledWithExactly p

		it 'should throw a `GameError` if the player is already added', ->
			addTwice = ->
				w.addPlayer p
				w.addPlayer p
			assert.throws addTwice, GameError

		it 'should call `addVillage` for each of the player\'s villages', ->
			addVillage = sinon.spy w.addVillage
			w.addVillage = addVillage
			w.addPlayer p
			assert addVillage.calledOnce
			assert addVillage.calledWithExactly v



	describe 'World::getPlayer', ->

		beforeEach -> w.addPlayer p

		it 'should return `null` for a non-existent `Player`', ->
			assert.strictEqual w.getPlayer('non-existent'), null

		it 'should return a `Player` by id', ->
			assert.strictEqual w.getPlayer(p.id), p



	describe 'World::deletePlayer', ->

		beforeEach -> w.addPlayer p

		it 'should return the instance', ->
			assert.strictEqual w.deletePlayer(), w
			assert.strictEqual w.deletePlayer(p), w

		it 'should emit an `delete-player` event with the given `Player`', ->
			onDeletePlayer = sinon.spy()
			w.on 'delete-player', onDeletePlayer
			w.deletePlayer p
			assert onDeletePlayer.calledOnce
			assert onDeletePlayer.calledWithExactly p

		it 'should throw a `GameError` if a player does not exist', ->
			deleteTwice = ->
				w.deletePlayer p
				w.deletePlayer p
			assert.throws deleteTwice, GameError

		it 'should call `deleteVillage` for each of the player\'s villages', ->
			deleteVillage = sinon.spy w.deleteVillage
			w.deleteVillage = deleteVillage
			w.deletePlayer p
			assert deleteVillage.calledOnce
			assert deleteVillage.calledWithExactly v



	it 'should consistently add, get and delete a `Player`', ->
		w.addPlayer p
		assert.strictEqual w.getPlayer(p.id), p
		w.deletePlayer p
		assert.strictEqual w.getPlayer(p.id), null



	describe 'World::createVillage', ->

		v2 = null
		beforeEach -> v2 = w.createVillage()

		it 'should return a `Village`', ->
			assert v2 instanceof Village

		it 'should return a `Village` with a unique `id`', ->
			assert.strictEqual typeof v2.id, 'string'
			assert.strictEqual w.getVillage(v2.id), null

		it 'should return a `Village` with a unique `position`', ->
			assert v2.position instanceof Vector
			assert.strictEqual w.getVillage(v2.position), null

		it 'should generate a `position` within the map', ->
			assert 0 <= v2.position.x <= config.map.size
			assert 0 <= v2.position.y <= config.map.size

		it 'should generate a `position` in the given direction', ->
			size = config.map.size / 2
			for i in [0...5]

				nw = w.createVillage 'north-west'
				w.addVillage nw
				assert 0 <= nw.position.x <= size
				assert 0 <= nw.position.y <= size

				sw = w.createVillage 'south-west'
				w.addVillage sw
				assert 0 <= sw.position.x <= size
				assert size <= sw.position.y <= size * 2

				se = w.createVillage 'south-east'
				w.addVillage se
				assert size <= se.position.x <= size * 2
				assert size <= se.position.y <= size * 2

				ne = w.createVillage 'north-east'
				w.addVillage ne
				assert size <= ne.position.x <= size * 2
				assert 0 <= ne.position.y <= size



	describe 'World::createPlayer', ->

		p2 = null
		beforeEach -> p2 = w.createPlayer()

		it 'should return a `Player`', ->
			assert p2 instanceof Player

		it 'should return a `Player` with a unique `id`', ->
			assert.strictEqual typeof p2.id, 'string'
			assert.strictEqual w.getPlayer(p2.id), null
