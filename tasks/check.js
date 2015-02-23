var fs = require('fs');
var childProcess = require('child_process');

module.exports = function(grunt) {
	grunt.registerTask('seed', function() {
		var done = this.async();

		var child = childProcess.spawn('coffee', ['thedb'], {
				stdio: [seed, process.stdout, process.stderr]
			});

		child.on('error', function() {


			child.on('exit', done);
		});

	});
};

