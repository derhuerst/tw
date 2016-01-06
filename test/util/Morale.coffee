assert =			require 'assert'
sinon =				require 'sinon'
{EventEmitter} =	require 'events'

Morale =			require '../../src/util/Morale'
NumericValue =		require '../../src/util/NumericValue'





describe 'Morale', ->

	m = null
	onChange = sinon.spy()
	hour = null

	beforeEach ->
		m = new Morale 90
		m.on 'change', onChange
		hour = 1000 * 60 * 60

	afterEach -> onChange.reset()


	it '`isMorale`', ->
		assert.strictEqual m.isMorale, true

	it 'should inherit from `EventEmitter`', ->
		assert m instanceof EventEmitter



	describe 'Morale::constructor', ->

		it 'should use `100` as default value', ->
			m = new Morale()
			assert.strictEqual 0 + m, 100



	describe 'Morale::reset', ->

		it 'should return the instance', ->
			assert.strictEqual m.reset(), m
			assert.strictEqual m.reset(10), m

		it 'should set itself correctly to a `Number`', ->
			m.reset 10
			assert.strictEqual 0 + m, 10

		it 'should set itself correctly to a `NumericValue`', ->
			m.reset new NumericValue 10
			assert.strictEqual 0 + m, 10

		it 'should set itself to a maximum of `100`', ->
			m.reset 120
			assert.strictEqual 0 + m, 100
			m.reset new NumericValue 120
			assert.strictEqual 0 + m, 100

		it 'should do nothing when called without a summand', ->
			m.reset()
			assert.strictEqual 0 + m, 90
			assert onChange.callCount is 0

		it 'should emit a correct `change` event', ->
			m.reset 10
			assert onChange.calledOnce
			assert onChange.calledWithExactly 90, 10



	describe 'Morale::subtract', ->

		it 'should return the instance', ->
			assert.strictEqual m.subtract(), m
			assert.strictEqual m.subtract(2), m

		it 'should correctly subtract a `Number` from itself', ->
			m.subtract 10
			assert.strictEqual 0 + m, 80

		it 'should correctly subtract a `NumericValue` from itself', ->
			m.subtract new NumericValue 10
			assert.strictEqual 0 + m, 80

		it 'should do nothing when called without a summand', ->
			m.subtract()
			assert.strictEqual 0 + m, 90
			assert onChange.callCount is 0

		it 'should emit a correct `change` event', ->
			m.subtract 10
			assert onChange.calledOnce
			assert onChange.calledWithExactly 90, 80



	it 'should increment its value by `1` once an hour', ->
		clock = sinon.useFakeTimers()
		m = new Morale 90
		m.on 'change', onChange

		clock.tick hour - 1
		assert.strictEqual onChange.callCount, 0
		clock.tick 2

		assert onChange.calledOnce
		assert onChange.calledWithExactly 90, 91
		onChange.reset()

		clock.tick hour - 2
		assert.strictEqual onChange.callCount, 0
		clock.tick 2

		assert onChange.calledOnce
		assert onChange.calledWithExactly 91, 92
		clock.restore()

	it 'should increment its value not further than `100`', ->
		clock = sinon.useFakeTimers()
		m = new Morale 99
		m.on 'change', onChange

		clock.tick 1 + 2 * hour
		assert.strictEqual 0 + m, 100
		assert.strictEqual onChange.callCount, 1



	describe 'Morale::valueOf', ->

		it 'should return its value', ->
			assert.strictEqual m.valueOf(), 90
			assert.strictEqual 0 + m, 90



	describe 'Morale::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof m.toString(), 'string'
			assert.strictEqual typeof ('' + m), 'string'
