# https://gist.github.com/faisalman/4213592s
# Buffer = require('buffer').Buffer not neccesary

fs = require 'fs'
path = require 'path'
module.exports =
checkImage : ( filePath)  ->
	console.log 'filePath', filePath
	fs.open filePath, 'r', (err, fd) ->
		if err
			throw err
		extension =path.extname filePath
		console.log 'extension', extension

		num = switch extension.toLowerCase()
			when '.png'
				buffer = new Buffer(8)
				console.log 'je suis dans le cas : png'
				fs.read fd, buffer, 0,8,0, ->
					console.log 'buffer', buffer
					console.log 'buffer.toString', buffer.toString()
			when ".jpeg", "jpg"
				console.log 'je suis dans le cas : jpeg'
				buffer = new Buffer(11)
				fs.read fd, buffer, 0,11,0, ->
					console.log 'buffer', buffer
					console.log 'buffer.toString', buffer.toString()
			when ".gif"
				console.log 'je suis dans le cas : gif'
				buffer = new Buffer(3)
				fs.read fd, buffer, 0,3,0, ->
					console.log 'buffer', buffer
					console.log 'buffer.toString', buffer.toString()
			when ".bmp"
				console.log 'je suis dans le cas : bmp'
				buffer = new Buffer(2)
				fs.read fd, buffer, 0,2,0, ->
					console.log 'buffer', buffer
					console.log 'buffer.toString', buffer.toString()
			when ".tiff"
				console.log 'je suis dans le cas : tiff'
				buffer = new Buffer(3)
				fs.read fd, buffer, 0,3,0, ->
					console.log 'buffer', buffer
					console.log 'buffer.toString', buffer.toString()
		console.log 'num', num
		# if extension == '.png'
		# 	buffer = new Buffer(8)
		# 	fs.read fd, buffer, 0,8,0, ->
		# 		console.log 'buffer', buffer
		# 		console.log 'buffer.toString', buffer.toString()
	# fs.readFile filePath,['hex'], (err, data) ->
	# 	if err
	# 		return console.log(err)
	# 	console.log 'Buffer', Buffer.isBuffer(data) false
	# 	console.log 'Buffer content[0]', Buffer[0] undefined
	# 	console.log 'data content,', data
	# 	console.log 'data content,', data[0], data[1]
