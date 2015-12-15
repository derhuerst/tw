assert =			require 'assert'
{EventEmitter} =	require 'events'
sinon =				require 'sinon'

config =			require '../../config'
Village =			require '../../src/core/Village'
Vector =			require '../../src/util/Vector'
NumericValue =		require '../../src/util/NumericValue'
GameError =			require '../../src/util/GameError'
Stash =				require '../../src/buildings/Stash'
Statue =			require '../../src/buildings/Statue'





describe 'Village', ->

	v = null
	b = null
	beforeEach ->
		v = new Village id: 'village-1', position: new Vector 1, 1
		b = new Statue()

	it '`isVillage`', ->
		assert.strictEqual v.isVillage, true

	it 'should inherit from `EventEmitter`', ->
		assert v instanceof EventEmitter



	describe 'Resources::constructor', ->

		it 'should set `id` to the given one', ->
			assert.strictEqual v.id, 'village-1'

		it 'should generate a random `id` as fallback', ->
			v = new Village()
			assert.strictEqual typeof v.id, 'string'

		it 'should set `name` to the given one', ->
			v = new Village id: 'village-1', name: 'John\'s village'
			assert.strictEqual v.name, 'John\'s village'

		it 'should set the `id` as the fallback `name`', ->
			assert.strictEqual v.name, 'village-1'

		it 'should set `position` to the given one', ->
			assert.deepEqual v.position, new Vector 1, 1

		it 'should set a fallback `position`', ->
			v = new Village id: 'village-1'
			assert.deepEqual v.position, new Vector()

		it 'should set `loyalty` to a `NumericValue` equal to the given one', ->
			l = new NumericValue 11
			v = new Village loyalty: l
			assert.notStrictEqual v.loyalty, l
			assert.strictEqual 0 + v.loyalty, 0 + l

		it 'should add each given building', ->
			stash = new Stash()
			statue = new Statue()
			v = new Village {stash, statue}
			assert.strictEqual v.stash, stash
			assert.strictEqual v.statue, statue



	describe 'Village::addBuilding', ->

		it 'should return the instance', ->
			assert.strictEqual v.addBuilding(), v
			assert.strictEqual v.addBuilding(b), v

		it 'should emit an `add-building` event with the given `Building`', ->
			onAddBuilding = sinon.spy()
			v.on 'add-building', onAddBuilding
			v.addBuilding b
			assert onAddBuilding.calledOnce
			assert onAddBuilding.calledWithExactly b

		it 'should throw a `GameError` if a building of the same type exists', ->
			b2 = new Statue()
			addTwice = ->
				v.addBuilding b
				v.addBuilding b2
			assert.throws addTwice, GameError



	describe 'Village::deleteBuilding', ->

		beforeEach -> v.addBuilding b

		it 'should return the instance', ->
			assert.strictEqual v.deleteBuilding(), v
			assert.strictEqual v.deleteBuilding(b), v

		it 'should emit an `delete-building` event with the given `Building`', ->
			onDeleteBuilding = sinon.spy()
			v.on 'delete-building', onDeleteBuilding
			v.deleteBuilding b
			assert onDeleteBuilding.calledOnce
			assert onDeleteBuilding.calledWithExactly b

		it 'should throw a `GameError` if a building does not exist', ->
			deleteTwice = ->
				v.deleteBuilding b
				v.deleteBuilding b
			assert.throws deleteTwice, GameError



	it 'should consistently add, get and delete a `Village`', ->
		v.addBuilding b
		assert.strictEqual v.statue, b
		v.deleteBuilding b
		assert.strictEqual v.statue, null



	# todo: test `points` and the watchers
	# todo: test `_buildingOnConstruction`



	describe 'Village::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof v.toString(), 'string'
			assert.strictEqual typeof ('' + v), 'string'
