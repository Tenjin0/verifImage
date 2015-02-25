fs = require 'fs'
path = require 'path'
grunt = require 'grunt'
_ = require 'underscore'

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

validate = (fd, tabSignatureValue) ->
	for expectedSignature in tabSignatureValue
		fileHeader = new Buffer(expectedSignature.length)
		fs.readSync fd, fileHeader, 0, expectedSignature.length, 0
		if fileHeader.equals(expectedSignature)
			return true
	return false

checkMedia = (filePath, callback) ->
	fs.lstat filePath, (err, stats)->
		if err
			throw err
		fileExtension = path.extname filePath.toLowerCase()

		if stats.isFile()
			fs.open filePath, 'r', (err, fd)->
				if err
					throw err
				fileExtension = path.extname filePath.toLowerCase()
				if fileExtension of signatureMap
					isValid = validate fd, signatureMap[fileExtension]
				else
					isValid = null
				callback isValid if callback
		else
			callback null if callback

render = (hasError, callback)->
	if hasError
		grunt.fatal 'Some files have formats not matching their extensions.'
	callback() if callback

module.exports = (grunt)->
	grunt.registerMultiTask 'checkMedia', 'Checks that files have matching format and extension.', registerCallback = ->
		hasError = false
		done = @async()
		totalPathCount = @files.length
		completeProcess =_.after totalPathCount, afterCallback = ->
			render hasError,done

		@files.forEach (file)->
			file.src.forEach (filepath)->
				checkMedia filepath, checkMediaCallback = (test)->
					if test is null
						grunt.verbose.ok filepath, '[IGNORED]'
					else if test is true
						grunt.verbose.ok filepath, '[OK]'
					else if test is false
						grunt.log.error filepath, '[ERROR]'
						hasError = true
					completeProcess()
