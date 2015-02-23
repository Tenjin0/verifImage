gruntFunction = (grunt) ->

	gruntConfig =
		pkg:
			grunt.file.readJSON 'package.json'

		concat:

		coffee:
			app:

		grunt.initConfig gruntConfig
		grunt.loadNpmTasks 'grunt-config-coffee'
		grunt.loadNpmTasks 'grunt-config-concat'
		grunt.registerTask
		null

module.exports = gruntFunction
