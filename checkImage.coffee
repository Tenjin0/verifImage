# https://gist.github.com/faisalman/4213592s

fs = require 'fs'
module.exports = 
checkImage : ( filePath)  ->  
	console.log 'filePath', filePath
	fs.open filePath, 'r', (err, fd) ->
		if err
			throw err
		buffer = new Buffer(1)
		loop
			num = fs.readSync(fd, buffer, 0, 1, null)
			if num == 0
				break
			console.log 'byte read', buffer[0]
	
	fs.readFile filePath, 'hex', (err, data) ->
		if err
			return console.log(err)
		console.log 'data', data

process.argv.forEach (val, index, array) ->
		console.log index + ': ' + val
