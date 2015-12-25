assert =			require 'assert'

fight =				require '../../src/core/fight'
Units =				require '../../src/util/Units'
Resources =			require '../../src/util/Resources'





describe 'fight', ->

	attacking = new Units spearFighter: 10, scout: 10
	defending = new Units archer: 5, scout: 5

	describe 'return value', ->

		results = null
		beforeEach -> results = fight {attacking, defending}

		it 'should return `attackingDead` as `Units`', ->
			assert results.attackingDead instanceof Units

		it 'should return `defendingDead` as `Units`', ->
			assert results.defendingDead instanceof Units

		it 'should return `wallNewLevel` as `Number`', ->
			assert.strictEqual typeof results.wallNewLevel, 'number'

		it 'should return `catapultsTargetNewLevel` as `Number`', ->
			assert.strictEqual typeof results.catapultsTargetNewLevel, 'number'

		it 'should return `haul` as `Resources`', ->
			assert results.haul instanceof Resources

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
