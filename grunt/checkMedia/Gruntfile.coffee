fs = require 'fs'
path = require 'path'
grunt = require 'grunt'
# checkMedia = require '../../checkImage'
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

bonjour = ( string ) ->
	console.log 'Bonjour', string
	null

validate = (fd, tabSignatureValue) ->
	for expectedSignature in tabSignatureValue
		# console.log expectedSignature
		fileHeader = new Buffer(expectedSignature.length)
		fs.readSync fd, fileHeader, 0, expectedSignature.length, 0
		# console.log fileHeader , '<-------->', expectedSignature
		if fileHeader.equals(expectedSignature)
			return true
	false


checkMedia = (filePath, done, retour)  ->

	fs.open filePath, 'r', (err, fd) ->
		if err
			throw err
		fileExtension = path.extname filePath
		fileExtension = fileExtension.toLowerCase()
		if fileExtension of signatureMap
			 toTest = validate fd, signatureMap[fileExtension]
		else
			toTest = false
		retour done , toTest

		null


module.exports = (grunt)->
	fs = require 'fs'
	path = require 'path'
	grunt.registerMultiTask 'checkMedia', 'Check that files correspond to their extensions.', ()->
		done = @async()
		@files.forEach (file)->
			file.src.forEach (filepath)->
				# console.log 'Loading file:',filepath
				if fs.lstatSync(filepath).isFile()
					promise = checkMedia filepath , done, (done, test) ->
						# grunt.util.warn
						# console.log test
						if test
							grunt.log.ok filepath, 'format OK'
						else
							grunt.log.error filepath, 'wrong format'
							# console.log grunt.log.error
							# grunt.fatal filepath, 'wrong format'

						done()



