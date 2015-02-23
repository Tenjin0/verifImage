

	# https://gist.github.com/faisalman/4213592s
	# Buffer = require('buffer').Buffer not neccesary

	fs = require 'fs'
	path = require 'path'

	buff  = (fd, int, callback) ->
		buffer = new Buffer int
		# console.log 'je suis dans le cas : png'
		fs.read fd, buffer, 0,int,0, (err, bytesRead, buffer2) ->
			console.log 'buffer2', buffer2[0]
			callback buffer2.toString('hex').toUpperCase()
			return



	hashmap =
		'.png' : '89504E470D0A1A0A'
		'.jpg' : 'FFD8FF'
		'.jpeg' : 'FFD8FF'
		'.gif' : '47494638'
		'.bmp' : '41564920'
		'.avi' : '41564920'
		'.mkv' : '424D'
		'.mp4' : '41564920'
		'.mp3' : '494433'

	module.exports =
	checkImage : (filePath)  ->
		# console.log 'filePath', filePath
		fs.exists filePath, (exists) ->
			if (exists)
				fs.open filePath, 'r', (err, fd) ->
					if err
									throw err

					extension =path.extname filePath
					# console.log 'extension', extension
					num = switch extension.toLowerCase()

						when '.png'
							buff fd, 8, (toTest) ->
								if toTest is '89504E470D0A1A0A'
									console.log extension, ': todo bien !!'
								else
									console.log extension, 'ca marche pas !!!!'

						when '.jpg', '.jpeg'
								buff fd, 3, (toTest) ->
									if toTest is 'FFD8FF'
										console.log 'jpg : todo bien !!'
									else
										console.log 'jpg : ca marche pas !!!!'

						when '.gif'
								buff fd, 4, (toTest) ->
										if toTest is '47494638'
												console.log 'gif : todo bien !!'
										else
												console.log 'gif : ca marche pas !!!!'

						when '.bmp'
								buff fd, 2, (toTest) ->
										if toTest is '424D'
												console.log 'bmp : todo bien !!'
										else
												console.log 'bmp : ca marche pas !!!!'

						when '.avi'
								buff fd, 4, (toTest) ->
										if toTest is '41564920' or toTest is'52494646'
												console.log 'avi : todo bien !!'
										else
												console.log 'avi : ca marche pas !!!!'

						when '.mkv'
								buff fd, 4, (toTest) ->
										if toTest is '1A45DFA3'
												console.log 'mkv : todo bien !!'
										else
												console.log 'mkv : ca marche pas !!!!'

						when '.mp4'
								buff fd, 8, (toTest) ->
										if toTest is '0000001866747970'
												console.log 'mp4 : todo bien !!'
										else
												console.log 'mp4 : ca marche pas !!!!'

						when '.mp3'
								buff fd, 3, (toTest) ->
										if toTest is '494433'
												console.log 'mp3 : todo bien !!'
										else
												console.log 'mp3 : ca marche pas !!!!'

