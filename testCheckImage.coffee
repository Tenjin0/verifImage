checkImage = require './checkImage'

checkImage.checkImage './test.gif'
checkImage.checkImage 'test.gif'
temp = __dirname + '/test.gif'
console.log temp