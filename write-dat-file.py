import os, json, re

datfile = open("recipes.dat","w")
recipes = json.loads(open('data.json').read())

def c(s):
	s = str(s)
	s = s.replace(' ', '_')
	s = re.sub('[^A-Za-z0-9\-\_\(\)]+', '', s)
	s = s.replace('__', '_')
	return s

datfile.write('set recipe :=')
list(map(lambda x: datfile.write(' ' + c(x['id'])), recipes))
datfile.write('\n;\n\n')

ingredients = set()
[list(map(lambda x: ingredients.add(c(x)), recipe['ingredients'])) for recipe in recipes]
datfile.write('set ingredient :=')
list(map(lambda x: datfile.write(' ' + x), ingredients))
datfile.write('\n;\n\n')

nutrients = set()
list(map(lambda x: nutrients.add(c(x['name'])), recipes[0]['nutrients']))
datfile.write('set nutrient :=')
list(map(lambda x: datfile.write(' ' + x), nutrients))
datfile.write('\n;\n\n')

datfile.write('set day :=')
list(map(lambda x: datfile.write(' ' + str(x)), range(30)))
datfile.write('\n;\n\n')

datfile.write('param ready_time :=')
list(map(lambda x: datfile.write('\n' + c(x['id']) + ' ' + c(x['ready-time'])), recipes))
datfile.write('\n;\n\n')

datfile.write('param servings :=')
list(map(lambda x: datfile.write('\n' + c(x['id']) + ' ' + c(x['servings'])), recipes))
datfile.write('\n;\n\n')

datfile.write('param price :=')
list(map(lambda x: datfile.write('\n' + c(x['id']) + ' ' + str(x['price'])), recipes))
datfile.write('\n;\n\n')

datfile.write('param score :=')
list(map(lambda x: datfile.write('\n' + c(x['id']) + ' ' + str(x['score'])), recipes))
datfile.write('\n;\n\n')

def printIngredients(id, ingredients):
    list(map(lambda x: datfile.write('\n' + c(id) + ' ' + c(x) + ' 1'), ingredients))

datfile.write('param recipeingredient :=')
list(map(lambda x: printIngredients(x['id'], set(x['ingredients'])), recipes))
datfile.write('\n;\n\n')

def printNutrients(id, nutrients):
    list(map(lambda x: datfile.write('\n' + c(id) + ' ' + c(x['name']) + ' ' + str(x['percentDaily'])), nutrients))

datfile.write('param recipenutrient :=')
list(map(lambda x: printNutrients(c(x['id']), x['nutrients']), recipes))
datfile.write('\n;')

datfile.close()
