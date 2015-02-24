Buffer = require('buffer').Buffer
# buffertools = require('buffertools')
sig = 'FFD8FF'
buffer1 = new Buffer(sig,'hex')
buffer2 = new Buffer(sig, 'hex')
console.log buffer1 , ' <-----> ' , buffer2
console.log ' buffer1 ', Buffer.isBuffer(buffer1)
console.log 'instance', buffer1 instanceof Buffer
console.log buffer1.equals buffer2
console.log Buffer.compare buffer1, buffer2

throw new Error 'silly error'

# Buffer.compare buffer1, buffer2
# console.log 'Object.prototype', Object.prototype.toString(buffer1)
# arr = [Buffer(sig), Buffer(sig)];
# console.log arr.sort(Buffer.compare);

# console.log Buffer.compare(buffer1, buffer2)

