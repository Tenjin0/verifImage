(function() {
  module.exports = function(grunt) {
    var GameConfig, localConfig;
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadTasks('grunt/checkMedia');
    localConfig = grunt.file.readJSON("conf/local.json");
    GameConfig = {
      data: localConfig.contentFolderPath
    };
    grunt.initConfig({
      config: GameConfig,
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
          ext: '.js'
        }
      },
      checkMedia: {
        dist: {
          files: [
            {
              expand: true,
              flatten: true,
              src: ['<%=config.data%>/images/*.jpg']
            }
          ]
        }
      }
    });
    return grunt.registerTask('default', ['coffee:compile', 'checkMedia:dist']);
  };

}).call(this);
