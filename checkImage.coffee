
fs = require 'fs'
path = require 'path'
signatureMap =
	'.png' : ['89504E470D0A1A0A']
	'.jpg' : ['FFD8FF']
	'.jpeg' : ['FFD8FF']
	'.gif' : ['47494638']
	'.bmp' : ['41564920']
	'.avi' : ['41564920', '52494646']
	'.mkv' : ['1A45DFA3']
	'.mp4' : ['00000018667479706D703432', '000000186674797069736F6D', '000000186674797033677035']
	'.mp3' : ['494433', 'FFFB', 'FFF3', 'FFE3']

for extension, signatures of signatureMap
	signatureMap[extension] = for sig in signatures
		new Buffer(sig,'hex')

# for extension, signatures of signatureMap
# 	console.log signatureMap[extension]

validate = (fd, tabSignatureValue) ->
	for expectedSignature in tabSignatureValue
		# console.log expectedSignature
		fileHeader = new Buffer(expectedSignature.length)
		fs.readSync fd, fileHeader, 0, expectedSignature.length, 0
		# console.log fileHeader , '<-------->', expectedSignature
		if fileHeader.equals(expectedSignature)
			return true
	false

module.exports =
	checkMedia : (filePath)  ->
		fs.exists filePath, (exists) ->
			console.log 'exists', exists, filePath
			if (exists)
				fs.open filePath, 'r', (err, fd) ->
					if err
						throw err
					fileExtension = path.extname filePath
					fileExtension = fileExtension.toLowerCase()
					# console.log 'open', fd
=======

for extension, signatures of signatureMap
	signatureMap[extension] = for sig in signatures
		new Buffer(sig,'hex')

validate = (fd, tabSignatureValue) ->
	for expectedSignature in tabSignatureValue
		fileHeader = new Buffer(expectedSignature.length)
		fs.readSync fd, fileHeader, 0, expectedSignature.length, 0

		if fileHeader.equals(expectedSignature)
			return true
	false

module.exports =
	checkImage : (filePath)  ->
		fs.exists filePath, (exists) ->
			if (exists)
				fs.open filePath, 'r', (err, fd) ->
					if err
						throw err

					fileExtension = path.extname filePath
					fileExtension = fileExtension.toLowerCase()


					if fileExtension of signatureMap
						toTest = validate fd, signatureMap[fileExtension]
						if toTest
							console.log fileExtension, ' : todo bien !!'
						else
							console.log fileExtension, ' : ca marche pas !!!!'
					else
						console.log fileExtension, ': ce format n\'est pas supporté'

			# else
				# console.log 'je voudrais lancer une erreur'
				# throw new Error("je voudrais lancer une erreur");
				# false
		null

