import os, json, re

datfile = open("recipes.dat","w")
recipes = json.loads(open('data.json').read())

def c(s):
	s = str(s)
	s = s.replace(' ', '_')
	s = re.sub('[^A-Za-z0-9\-\_\(\)]+', '', s)
	return s

print(c('foo bar'))#.replace(' ', '_'))