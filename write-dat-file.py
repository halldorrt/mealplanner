import os, json

datfile = open("recipes.dat","w")
recipes = json.loads(open('data.json').read())

datfile.write('set recipe :=')
list(map(lambda x: datfile.write(' ' + str(x['id'])), recipes))
datfile.write('\n;\n\n')

ingredients = set()
[list(map(lambda x: ingredients.add(x.replace(' ', '_')), recipe['ingredients'])) for recipe in recipes]
datfile.write('set ingredient :=')
list(map(lambda x: datfile.write(' ' + x), ingredients))
datfile.write('\n;\n\n')

nutrients = set()
list(map(lambda x: nutrients.add(x['name'].replace(' ', '_')), recipes[0]['nutrients']))
datfile.write('set nutrient :=')
list(map(lambda x: datfile.write(' ' + x), nutrients))
datfile.write('\n;\n\n')

datfile.write('param name ready_time servings score :=')
list(map(lambda x: datfile.write('\n' + str(x['id']) + ' '
                                      + x['name'].replace(' ', '_') + ' '
                                      + str(x['ready-time']) + ' '
                                      + str(x['servings']) + ' '
                                      + str(x['score']) ), recipes))
datfile.write('\n;\n\n')

def printIngredients(id, ingredients):
    list(map(lambda x: datfile.write('\n' + str(id) + ' ' + x.replace(' ', '_')), ingredients))

datfile.write('param recipeingredient :=')
list(map(lambda x: printIngredients(x['id'], x['ingredients']), recipes))
datfile.write('\n;\n\n')

def printNutrients(id, nutrients):
    list(map(lambda x: datfile.write('\n' + str(id) + ' ' + x['name'].replace(' ', '_') + ' ' + str(x['percentDaily'])), nutrients))

datfile.write('param recipenutrient :=')
list(map(lambda x: printNutrients(x['id'], x['nutrients']), recipes))
datfile.write('\n;')

datfile.close()
