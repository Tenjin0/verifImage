checkImage = require './checkImage'

# checkImage.checkMedia __dirname + '/media/index.jpeg'
# checkImage.checkMedia __dirname + '/media/icecream.png'
checkImage.checkMedia __dirname + '/media/test.GIF',(test)->
	console.log 'test',test
checkImage.checkMedia __dirname + '/media/test.mp4',(test)->
	console.log 'test',test
checkImage.checkMedia __dirname + '/media/small.mp4',(test)->
	console.log 'test',test
# temp = __dirname + '/test.gif'
# console.log temp

# process.argv.forEach (val, index, array) ->
# 		console.log index + ': ' + val
