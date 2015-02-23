(function() {
  var extension, fs, path, sig, signatureMap, signatures, validate;

  fs = require('fs');

  path = require('path');

  signatureMap = {
    '.png': ['89504E470D0A1A0A'],
    '.jpg': ['FFD8FF'],
    '.jpeg': ['FFD8FF'],
    '.gif': ['47494638'],
    '.bmp': ['41564920'],
    '.avi': ['41564920', '52494646'],
    '.mkv': ['1A45DFA3'],
    '.mp4': ['00000018667479706D703432', '000000186674797069736F6D', '000000186674797033677035'],
    '.mp3': ['494433', 'FFFB', 'FFF3', 'FFE3']
  };

  for (extension in signatureMap) {
    signatures = signatureMap[extension];
    signatureMap[extension] = (function() {
      var i, len, results;
      results = [];
      for (i = 0, len = signatures.length; i < len; i++) {
        sig = signatures[i];
        results.push(new Buffer(sig, 'hex'));
      }
      return results;
    })();
  }

  validate = function(fd, tabSignatureValue) {
    var expectedSignature, fileHeader, i, len;
    for (i = 0, len = tabSignatureValue.length; i < len; i++) {
      expectedSignature = tabSignatureValue[i];
      fileHeader = new Buffer(expectedSignature.length);
      fs.readSync(fd, fileHeader, 0, expectedSignature.length, 0);
      if (fileHeader.equals(expectedSignature)) {
        return true;
      }
    }
    return false;
  };

  module.exports = {
    checkImage: function(filePath) {
      return fs.exists(filePath, function(exists) {
        if (exists) {
          return fs.open(filePath, 'r', function(err, fd) {
            var fileExtension, toTest;
            if (err) {
              throw err;
            }
            fileExtension = path.extname(filePath);
            fileExtension = fileExtension.toLowerCase();
            if (fileExtension in signatureMap) {
              toTest = validate(fd, signatureMap[fileExtension]);
              if (toTest) {
                return console.log(fileExtension, ' : todo bien !!');
              } else {
                return console.log(fileExtension, ' : ca marche pas !!!!');
              }
            } else {
              return console.log(fileExtension, ': ce format n\'est pas supporté');
            }
          });
        }
      });
    }
  };

}).call(this);
