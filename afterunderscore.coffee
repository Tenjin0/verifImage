_ = require 'underscore'
listOfStuff = ['Double', 'Stouffer', 'Purple', 'The']
proc = _.after listOfStuff.length, () ->
	console.log 'everything is done'
_.each listOfStuff, (stuff) ->
	setTimeout () ->
		console.log 'stuff', stuff
		proc()
	,0
