assert =		require 'assert'

_ =				require '../../src/util/helpers'





describe 'Array::add', ->

	a = null

	beforeEach ->
		a = [ 'one', 'two' ]

	it 'should be a function', ->
		assert.strictEqual typeof a.add, 'function'

	it 'should add an item to an array', ->
		a.add 'three'
		assert a.has 'three'

	it 'should not touch existing items', ->
		a.add 'three'
		assert.strictEqual a.indexOf('one'), 0
		assert.strictEqual a.indexOf('two'), 1





describe 'Array::remove', ->

	a = null

	beforeEach ->
		a = [ 'one', 'two', 'three' ]

	it 'should be a function', ->
		assert.strictEqual typeof a.remove, 'function'

	it 'should remove an item from an array', ->
		a.remove 'two'
		assert not a.has 'two'

	it 'should not remove other items', ->
		a.remove 'two'
		assert a.has 'one'
		assert a.has 'three'
