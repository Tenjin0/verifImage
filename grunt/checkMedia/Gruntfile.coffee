fs = require 'fs'
path = require 'path'
grunt = require 'grunt'
_ = require 'underscore'
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
	return false


checkMedia = (filePath, retour) ->

	fs.lstat filePath, (err, stats) ->
		if err
			throw err
		if stats.isFile()
			fs.open filePath, 'r', (err, fd) ->
				if err
					throw err
				fileExtension = path.extname filePath.toLowerCase()
				if fileExtension of signatureMap
					 toTest = validate fd, signatureMap[fileExtension]
				else
					toTest = false
				retour toTest
		else
			retour null

render = (done,hasError) ->

	console.log '\n>>>>> Execution des fonctions asynchrones terminées'
	if hasError
		grunt.fatal 'certains fichiers sont erronés'
	done()


module.exports = (grunt)->
	fs = require 'fs'
	path = require 'path'
	grunt.registerMultiTask 'checkMedia', 'Check that files correspond to their extensions.', registerCallback = ()->
		hasError = false
		done = @async()
		totalpath = @files.length
		console.log '\nnombre total de chemin a traiter',totalpath
		proc =_.after totalpath, afterCallback = ()->
			render(done,hasError)
		@files.forEach (file)->
			file.src.forEach (filepath)->
				checkMedia filepath,checkMediaCallback = (test) ->
					if test is null
						console.log '>>', filepath, 'est un dossier'
					else if test is true
						grunt.log.ok filepath, 'format OK'
					else if test is false
						grunt.log.error filepath, 'wrong format'
						hasError = true
					proc()



