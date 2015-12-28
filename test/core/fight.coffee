assert =			require 'assert'
sinon =				require 'sinon'

fight =				require '../../src/core/fight'
Units =				require '../../src/util/Units'
Resources =			require '../../src/util/Resources'





equalResources = (a, b) ->
	assert.strictEqual a.wood, b.wood
	assert.strictEqual a.clay, b.clay
	assert.strictEqual a.iron, b.iron



describe 'fight', ->



	describe.only 'haul', ->

		stored = null
		capacity = null

		beforeEach ->
			stored = new Resources {wood: 10, clay: 8, iron: 12}
			capacity = 25 # 25/3 > wood

		it 'should return `Resources`', ->
			result = fight.haul stored, capacity
			assert result.isResources

		it 'should not change the given stored `Resources`', ->
			onChange = sinon.spy()
			stored.on 'change', onChange
			before = stored.clone()

			fight.haul stored, capacity
			assert.strictEqual onChange.callCount, 0
			equalResources stored, before

		it 'should not change the given haul capacity', ->
			before = capacity
			fight.haul stored, capacity
			assert.strictEqual capacity, before

		it 'should not haul more than stored', ->
			result = fight.haul stored, stored.count() + 10
			assert result.wood <= stored.wood
			assert result.clay <= stored.clay
			assert result.iron <= stored.iron

		it 'should haul the full capacity', ->
			result = fight.haul stored, capacity
			assert.strictEqual result.count(), capacity

		it 'should haul only integer amounts', ->
			result = fight.haul stored, capacity
			assert.strictEqual Math.round(result.wood), result.wood
			assert.strictEqual Math.round(result.clay), result.clay
			assert.strictEqual Math.round(result.iron), result.iron



	describe 'simulate', ->

		attacking = null
		defending = null

		beforeEach ->
			attacking = new Units spearFighter: 10, scout: 10
			defending = new Units archer: 5, scout: 5

		describe 'return value', ->

			results = null
			beforeEach -> results = fight.simulate {attacking, defending}

			it 'should return `attackingDead` as `Units`', ->
				assert results.attackingDead instanceof Units

			it 'should return `defendingDead` as `Units`', ->
				assert results.defendingDead instanceof Units

			it 'should return `wallNewLevel` as `Number`', ->
				assert.strictEqual typeof results.wallNewLevel, 'number'

			it 'should return `catapultsTargetNewLevel` as `Number`', ->
				assert.strictEqual typeof results.catapultsTargetNewLevel, 'number'

			it 'should return `haul` as `Number`', ->
				assert.strictEqual typeof results.haul, 'number'

		it.skip 'should compute scouts independently', ->
			# todo

		it.skip 'should compute damage by rams', ->
			# todo

		it.skip 'should compute damage by catapults', ->
			# todo

		it.skip 'should incorporate morale', ->
			# todo

		it.skip 'should incorporate the night bonus', ->
			# todo
