assert =			require 'assert'
sinon =				require 'sinon'

Resources =			require '../../src/util/Resources'





correctChangeEvent = (spy, before, after) ->
	assert spy.calledOnce
	args = spy.firstCall.args
	equalResources args[0], before
	equalResources args[1], after

equalResources = (a, b) ->
	assert.strictEqual a.wood, b.wood
	assert.strictEqual a.clay, b.clay
	assert.strictEqual a.iron, b.iron



describe 'Resources', ->

	a = null
	old = null
	spy = null

	b = null
	c = null

	beforeEach ->
		a = new Resources { wood: 100, clay: 200, iron: 300 }
		old = new Resources { wood: a.wood, clay: a.clay, iron: a.iron }
		spy = sinon.spy()
		a.on 'change', spy

		b = new Resources { wood: 300, clay: 200, iron: 100 }
		c = 10

	afterEach -> spy.reset()

	it '`isResources`', ->
		assert.strictEqual a.isResources, true



	describe 'Resources::constructor', ->

		it 'should set `wood`, `clay` and `iron` to the given values', ->
			assert.strictEqual a.wood, 100
			assert.strictEqual a.clay, 200
			assert.strictEqual a.iron, 300

		it 'should set `0` as default for `wood`, `clay` and `iron`', ->
			a = new Resources()
			assert.strictEqual a.wood, 0
			assert.strictEqual a.clay, 0
			assert.strictEqual a.iron, 0



	describe 'Resources::reset', ->

		it 'should return the instance', ->
			assert.strictEqual a.reset(b), a
			assert.strictEqual a.reset(c), a

		it 'should set `wood`, `clay` and `iron` to the given value', ->
			a.reset c
			assert.strictEqual a.wood, c
			assert.strictEqual a.clay, c
			assert.strictEqual a.iron, c
			a.reset b
			equalResources a, b

		it 'should use `0` as the default value', ->
			a.reset()
			assert.strictEqual a.wood, 0
			assert.strictEqual a.clay, 0
			assert.strictEqual a.iron, 0

		it 'should emit a correct `change` event when given a `Number`', ->
			a.reset c
			correctChangeEvent spy, old, a

		it 'should emit a correct `change` event when given `Resources`', ->
			a.reset b
			correctChangeEvent spy, old, a



	describe 'Resources::add', ->

		it 'should return the instance', ->
			assert.strictEqual a.add(b), a
			assert.strictEqual a.add(c), a

		it 'should do nothing when called without a summand', ->
			a.add()
			equalResources a, old

		it 'should correctly add a `Number` to `wood`, `clay` and `iron`', ->
			a.add c
			assert.strictEqual a.wood, old.wood + c
			assert.strictEqual a.clay, old.clay + c
			assert.strictEqual a.iron, old.iron + c

		it 'should correctly emit a `change` event when given a `Number`', ->
			a.add c
			correctChangeEvent spy, old, a

		it 'should correctly add `Resources` to `wood`, `clay` and `iron`', ->
			a.add b
			assert.strictEqual a.wood, old.wood + b.wood
			assert.strictEqual a.clay, old.clay + b.clay
			assert.strictEqual a.iron, old.iron + b.iron

		it 'should correctly emit a `change` event when given `Resources`', ->
			a.add b
			correctChangeEvent spy, old, a



	describe 'Resources::subtract', ->

		beforeEach -> spy = sinon.spy a, 'add'

		it 'should return the instance', ->
			assert.strictEqual a.subtract(b), a
			assert.strictEqual a.subtract(c), a

		it 'should call `add` correctly when given a `Number`', ->
			a.subtract c
			assert a.add.calledOnce
			assert a.add.calledWithExactly -c

		it 'should call `add` correctly when given `Resources`', ->
			a.subtract b
			assert a.add.calledOnce
			equalResources a.add.firstCall.args[0],
				wood: -b.wood
				clay: -b.clay
				iron: -b.iron



	describe 'Resources::multiply', ->

		it 'should return the instance', ->
			assert.strictEqual a.multiply(b), a
			assert.strictEqual a.multiply(c), a

		it 'should do nothing when called without a summand', ->
			a.multiply()
			equalResources a, old

		it 'should correctly multiply a `Number` with `wood`, `clay` and `iron`', ->
			a.multiply c
			assert.strictEqual a.wood, old.wood * c
			assert.strictEqual a.clay, old.clay * c
			assert.strictEqual a.iron, old.iron * c

		it 'should correctly emit a `change` event when given a `Number`', ->
			a.multiply c
			correctChangeEvent spy, old, a

		it 'should correctly multiply `Resources` with `wood`, `clay` and `iron`', ->
			a.multiply b
			assert.strictEqual a.wood, old.wood * b.wood
			assert.strictEqual a.clay, old.clay * b.clay
			assert.strictEqual a.iron, old.iron * b.iron

		it 'should correctly emit a `change` event when given `Resources`', ->
			a.multiply b
			correctChangeEvent spy, old, a



	describe 'Resources::round', ->

		it 'should return the instance', ->
			assert.strictEqual a.round(), a

		it 'should round `wood`, `clay` and `iron` correctly', ->
			a.round()
			assert.strictEqual a.wood, Math.round a.wood
			assert.strictEqual a.clay, Math.round a.clay
			assert.strictEqual a.iron, Math.round a.iron

		it 'should emit a correct `change` event', ->
			a.round b
			correctChangeEvent spy, old, a



	describe 'Resources::highest', ->

		it 'should return the property of the highest value', ->
			assert.strictEqual a.highest(), 'iron'
			assert.strictEqual b.highest(), 'wood'

	describe 'Resources::lowest', ->

		it 'should return the property of the lowest value', ->
			assert.strictEqual a.lowest(), 'wood'
			assert.strictEqual b.lowest(), 'iron'



	describe 'Resources::count', ->

		it 'should return the sum of its values', ->
			assert.strictEqual a.count(), 600



	describe 'Resources::moreThan', ->

		it 'should return `true` for `Resources` with every property being greater or equal', ->
			b = new Resources { wood: a.wood, clay: a.clay - 1, iron: a.iron }
			assert.strictEqual a.moreThan(b), true

		it 'should return `false` for `Resources` with any property being lower', ->
			b = new Resources { wood: a.wood + 1, clay: a.clay, iron: a.iron + 1 }
			assert.strictEqual a.moreThan(b), false

	describe 'Resources::equalTo', ->

		it 'should return `true` for `Resources` with every property being equal', ->
			b = new Resources
				wood: a.wood
				clay: a.clay
				iron: a.iron
			assert.strictEqual a.equalTo(b), true

		it 'should return `true` for `Resources` with every property being equal', ->
			b = new Resources { wood: a.wood, clay: a.clay, iron: a.iron }
			assert.strictEqual a.equalTo(b), true

		it 'should return `false` for `Resources` with any property being unequal', ->
			b = new Resources { wood: a.wood, clay: a.clay - 1, iron: a.iron }
			assert.strictEqual a.equalTo(b), false



	describe 'Resources::clone', ->

		b = null
		beforeEach -> b = a.clone()

		it 'should properly instanciate the clone', ->
			assert.strictEqual b.isResources, true

		it 'should return a `Resources` with equal `wood`, `clay` and `iron`', ->
			assert.strictEqual b.wood, a.wood
			assert.strictEqual b.clay, a.clay
			assert.strictEqual b.iron, a.iron



	describe 'Vector::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof a.toString(), 'string'
			assert.strictEqual typeof ('' + a), 'string'
