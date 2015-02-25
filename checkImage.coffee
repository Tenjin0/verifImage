
fs = require 'fs'
path = require 'path'
indexFormatMp4 = 4
signatureMap =
	'.png' : ['89504E470D0A1A0A']
	'.jpg' : ['FFD8FF']
	'.jpeg' : ['FFD8FF']
	'.gif' : ['47494638']
	'.bmp' : ['41564920']
	'.avi' : ['41564920', '52494646']
	'.mkv' : ['1A45DFA3']
	'.mp4' : ['667479706D703432', '6674797069736F6D', '6674797033677035']
	'.mp3' : ['494433', 'FFFB', 'FFF3', 'FFE3']

for extension, signatures of signatureMap
	console.log 'extension', extension, 'signatures',signatures[tab]
	signatureMap[extension] = for sig in signatures
		new Buffer(sig,'hex')

# for extension, signatures of signatureMap
# 	console.log signatureMap[extension]

validate = (fd,fileExtension, tabSignatureValue) ->

	for expectedSignature in tabSignatureValue
		position = 0
		console.log 'fileExtension',fileExtension
		fileHeader = new Buffer(expectedSignature.length)
		if fileExtension is '.mp4' # && position <= fd.length
			position = indexFormatMp4
		console.log 'position',position
		fs.readSync fd, fileHeader, 0, expectedSignature.length, position
		console.log 'compare',fileHeader , '<-------->', expectedSignature
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
						isValid = validate fd,fileExtension, signatureMap[fileExtension]
					else
						isValid = null
					callback isValid if callback
			else
				callback null if callback
