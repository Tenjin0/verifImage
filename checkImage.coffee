
fs = require 'fs'
path = require 'path'
signatureMap =
	'.png' :
		tab : ['89504E470D0A1A0A']

	'.jpg' :
		tab : ['FFD8FF']

	'.jpeg' :
		tab : ['FFD8FF']

	'.gif' :
		tab : ['47494638']

	'.bmp' :
		tab : ['41564920']

	'.avi' :
		tab : ['41564920', '52494646']

	'.mkv' :
		tab :['1A45DFA3']

	'.mp4' :
		position : 4,
		tab : ['667479706D703432', '6674797069736F6D', '6674797033677035']

	'.mp3' :
		tab : ['494433', 'FFFB', 'FFF3', 'FFE3']


for extension, values of signatureMap
	values['tab'] = for sig in values['tab']
		new Buffer(sig,'hex')

validate = (fd,fileExtension) ->

	for expectedSignature in signatureMap[fileExtension]['tab']
		fileHeader = new Buffer(expectedSignature.length)
		position = if signatureMap[fileExtension]['position'] is undefined then 0 else signatureMap[fileExtension]['position']
		fs.readSync fd, fileHeader, 0, expectedSignature.length, position
		if fileHeader.equals(expectedSignature)
			return true
	false

module.exports =
	checkMedia : (filePath, callback)  ->
		fs.lstat filePath, (err, stats)->
			if err
				throw err
			fileExtension = path.extname filePath.toLowerCase()

			if stats.isFile()
				fs.open filePath, 'r', (err, fd)->
					if err
						throw err
					if fileExtension of signatureMap
						isValid = validate fd,fileExtension
					else
						isValid = null
					callback isValid if callback
			else
				callback null if callback
