# return sum 1 to number
somme = (number) ->
	if number <= 1
		 number
	else
		parseInt(number, 10) + recurse(number-1)

# console.log process.argv
# for key,value of process.argv
# 	console.log key,value

console.log 'result',somme process.argv[2]