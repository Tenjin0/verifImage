signatureMap =
	'.png' : ['89504E470D0A1A0A']
	'.jpg' : ['FFD8FF']
	'.jpeg' : ['FFD8FF']
	'.gif' : ['47494638']
	'.bmp' : ['41564920']
	'.avi' : ['41564920', '52494646']
	'.mkv' : ['1A45DFA3']
	'.mp4' : ['00000018667479706D703432', '000000186674797069736F6D', '000000186674797033677035']
	'.mp3' : ['494433', 'FFFB', 'FFF3', 'FFE3']


heroes = ['leto', 'duncan', 'goku']

heroes2 = for hero,index in heroes
	console.log hero,index
	heroes[index] = hero + index
console.log heroes2

# Or, including the index
# for hero, index in heroes
# 	console.log('The hero at index %d is %s', index, hero)

# for extension, signatures of signatureMap
# 	console.log extension, signatures
# 	for signature, index in signatures
# 		console.log '\t', signature