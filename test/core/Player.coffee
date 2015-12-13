assert =			require 'assert'
sinon =				require 'sinon'
{EventEmitter} =	require 'events'

config =			require '../../config'
Player =			require '../../src/core/Player'
Village =			require '../../src/core/Village'
Vector =			require '../../src/util/Vector'
GameError =			require '../../src/util/GameError'





describe 'Player', ->

	p = null
	v = null

	beforeEach ->
		p = new Player id: 'player-1'
		v = new Village
			id:			'village-1'
			position:	new Vector 1, 1

	it '`isPlayer`', ->
		assert.strictEqual p.isPlayer, true

	it 'should inherit from `EventEmitter`', ->
		assert p instanceof EventEmitter



	describe 'Resources::constructor', ->

		it 'should set `id` to the given one', ->
			assert.strictEqual p.id, 'player-1'

		it 'should generate a random `id` as fallback', ->
			p = new Player()
			assert.strictEqual typeof p.id, 'string'

		it 'should set `name` to the given one', ->
			p = new Player id: 'player-1', name: 'Jane Doe'
			assert.strictEqual p.name, 'Jane Doe'

		it 'should set the `id` as the fallback `name`', ->
			assert.strictEqual p.name, 'player-1'



	describe 'Player::addVillage', ->

		it 'should return the instance', ->
			assert.strictEqual p.addVillage(), p
			assert.strictEqual p.addVillage(v), p

		it 'should emit an `add-village` event with the given `Village`', ->
			onAddVillage = sinon.spy()
			p.on 'add-village', onAddVillage
			p.addVillage v
			assert onAddVillage.calledOnce
			assert onAddVillage.calledWithExactly v

		it 'should throw a `GameError` if a village is already added', ->
			addTwice = ->
				p.addVillage v
				p.addVillage v
			assert.throws addTwice, GameError



	describe 'Player::getVillage', ->

		beforeEach -> p.addVillage v

		it 'should return `null` for a non-existent `Village`', ->
			assert.strictEqual p.getVillage('non-existent'), null

		it 'should return a `Village` by id', ->
			assert.strictEqual p.getVillage(v.id), v



	describe 'Player::deleteVillage', ->

		beforeEach -> p.addVillage v

		it 'should return the instance', ->
			assert.strictEqual p.deleteVillage(), p
			assert.strictEqual p.deleteVillage(v), p

		it 'should emit an `delete-village` event with the given `Village`', ->
			onDeleteVillage = sinon.spy()
			p.on 'delete-village', onDeleteVillage
			p.deleteVillage v
			assert onDeleteVillage.calledOnce
			assert onDeleteVillage.calledWithExactly v

		it 'should throw a `GameError` if a village does not exist', ->
			deleteTwice = ->
				p.deleteVillage v
				p.deleteVillage v
			assert.throws deleteTwice, GameError



	it 'should consistently add, get and delete a `Village`', ->
		p.addVillage v
		assert.strictEqual p.getVillage(v.id), v
		p.deleteVillage v
		assert.strictEqual p.getVillage(v.id), null



	# todo: test `points` and the watchers



	describe 'Player::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof p.toString(), 'string'
			assert.strictEqual typeof ('' + p), 'string'
