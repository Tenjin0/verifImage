# https://gist.github.com/faisalman/4213592s

fs = require 'fs'
module.exports = checkImage : (filePath) ->
  console.log 'filePath', filePath
  fs.readFile(filePath)

	# if (fs.lstatSync(path_string).isDirectory())


process.argv.forEach (val, index, array) ->
 		console.log index + ': ' + val
