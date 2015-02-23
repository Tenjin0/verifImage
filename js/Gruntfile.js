(function() {
  var gruntFunction;

  gruntFunction = function(grunt) {
    var gruntConfig;
    gruntConfig = {
      pkg: grunt.file.readJSON('package.json'),
      watch: {
        coffee: {
          files: '*.coffee',
          tasks: ['coffee:compile']
        }
      },
      coffee: {
        compile: {
          expand: true,
          flatten: true,
          src: ['*.coffee'],
          dest: 'js/',
          ext: '.js'
        }
      },
      seed: {
        files: '*.coffee'
      },
      execute: {
        simple_target: {
          src: ['example.js']
        }
      }
    };
    grunt.initConfig(gruntConfig);
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-execute');
    grunt.loadTasks('tasks');
    grunt.registerTask('default', ['coffee:compile', 'execute']);
    return null;
  };

  module.exports = gruntFunction;

}).call(this);
