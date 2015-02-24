module.exports = (grunt)->

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadTasks 'grunt/checkMedia'
	localConfig = grunt.file.readJSON "conf/local.json"

	GameConfig =
		data: localConfig.contentFolderPath

	grunt.initConfig
		config : GameConfig
		pkg:
			grunt.file.readJSON 'package.json'
		watch:
			coffee:
				files: '*.coffee',
				tasks: ['coffee:compile']
		coffee:
			compile:
				expand: true,
				flatten: true,
				src: ['*.coffee']
				ext: '.js'
		checkMedia:
			dist:
				files:[
					expand: true,
					src:  ['<%= config.data %>/**/*']
					# src:  ['<%= config.data %>/images/*.jpg']
				]

	grunt.registerTask 'default', [
		# 'coffee:compile'
		'checkMedia'

	]
