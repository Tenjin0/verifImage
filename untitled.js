fs.open('file.txt', 'r', function(err, fd) {
  if (err)
    throw err;
  var buffer = new Buffer(1);
  while (true)
  {   
    var num = fs.readSync(fd, buffer, 0, 1, null);
    if (num === 0)
      break;
    console.log('byte read', buffer[0]);
  }
});