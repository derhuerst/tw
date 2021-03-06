assert =			require 'assert'
sinon =				require 'sinon'
{EventEmitter} =	require 'events'

container = require '../../src/container'
require '../../src/util/TimeoutQueue'
TimeoutQueue = container 'util.TimeoutQueue'
require '../../src/util/Timeout'
Timeout = container 'util.Timeout'





describe 'TimeoutQueue', ->

	a = null
	t1 = null
	t2 = null
	spy = sinon.spy()
	clock = null

	before -> clock = sinon.useFakeTimers()
	after -> clock.restore()

	beforeEach ->
		a = new TimeoutQueue()
		t1 = new Timeout 50
		t2 = new Timeout 100

	afterEach -> spy.reset()


	it '`isTimeoutQueue`', ->
		assert.strictEqual a.isTimeoutQueue, true

	it 'should inherit from `EventEmitter`', ->
		assert a instanceof EventEmitter



	describe 'TimeoutQueue::timeouts', ->

		it 'should return an empty `Array` in the beginning', ->
			assert.deepEqual a.timeouts(), []

		it 'should return the timeouts added', ->
			a.add t1
			a.add t2
			assert.deepEqual a.timeouts(), [t1, t2]



	describe 'TimeoutQueue::add', ->

		it 'should return the instance', ->
			assert.strictEqual a.add(), a
			assert.strictEqual a.add(t1), a

		it 'should emit `add` with the given `Timeout`', ->
			a.on 'add', spy
			a.add t1
			assert spy.calledOnce
			assert spy.calledWithExactly t1

		it 'should not emit `add` with an invalid timeout', ->
			a.on 'add', spy
			a.add {}
			a.add()
			assert.strictEqual spy.callCount, 0



	describe 'TimeoutQueue::remove', ->

		it 'should return the instance', ->
			assert.strictEqual a.remove(), a
			assert.strictEqual a.remove(t1), a

		it 'should emit `remove` with the given `Timeout`', ->
			a.on 'remove', spy
			a.add t1

			a.remove t1
			assert spy.calledOnce
			assert spy.calledWithExactly t1

		it 'should not emit `add` if the given `Timeout` is not in the list', ->
			a.on 'remove', spy
			a.remove t1
			a.remove t2
			assert.strictEqual spy.callCount, 0



	it 'should start each `Timeout` extactly once', ->
		sinon.spy t1, 'start'
		sinon.spy t2, 'start'

		a.add t1
		a.add t2
		assert t1.start.calledOnce
		clock.tick 60
		assert t2.start.calledOnce



	it 'should emit `start` if the list was empty', ->
		a.on 'start', spy

		a.add t1
		a.add t2
		assert spy.calledOnce
		clock.tick 60
		assert spy.calledOnce



	it 'should emit `finish` if the list will be empty', ->
		a.on 'finish', spy

		a.add t1
		a.add t2
		clock.tick 90
		assert.strictEqual spy.callCount, 0
		clock.tick 60
		assert spy.calledOnce



	it 'should emit `progress` for each `Timeout` extactly once', ->
		a.on 'progress', spy

		a.add t1
		a.add t2
		clock.tick 60
		assert spy.calledOnce
		assert spy.calledWithExactly t1
		spy.reset()
		clock.tick 110
		assert spy.calledOnce
		assert spy.calledWithExactly t2
