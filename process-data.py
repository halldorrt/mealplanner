import json, os

currentDir = os.getcwd()

with open(currentDir+'/raw-data/0-100-info-data.json') as r1, open(currentDir+'/raw-data/100-200-info-data.json') as r2, open(currentDir+'/raw-data/200-250-info-data.json') as r3:
    recipe1 = json.loads(r1.read())
    recipe2 = json.loads(r2.read())
    recipe3 = json.loads(r3.read())

jsn = []

def processRecipe(recipe):
    rec = {}
    ingredients = []
    nutrients = []
    list(map(lambda x: ingredients.append(x['name']), recipe['extendedIngredients']))
    list(map(lambda x: nutrients.append({ 'name': x['title'], 'percentDaily': x['percentOfDailyNeeds'] }), recipe['nutrition']['nutrients']))
    rec['id'] = recipe['id']
    rec['name'] = recipe['title']
    rec['ready-time'] = recipe['readyInMinutes']
    rec['servings'] = recipe['servings']
    rec['score'] = recipe['spoonacularScore']
    rec['price'] = recipe['pricePerServing']
    rec['ingredients'] = ingredients
    rec['nutrients'] = nutrients
    jsn.append(rec)

list(map(processRecipe, recipe1))
list(map(processRecipe, recipe2))
list(map(processRecipe, recipe3))

with open('data.json', 'w') as outfile:
    json.dump(jsn, outfile, indent=4)
