import json, os

currentDir = os.getcwd()

recipe1 = json.loads(open(currentDir+'/raw-data/0-100-info-data.json').read())
recipe2 = json.loads(open(currentDir+'/raw-data/100-200-info-data.json').read())
recipe3 = json.loads(open(currentDir+'/raw-data/200-250-info-data.json').read())

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
    rec['ingredients'] = ingredients
    rec['nutrients'] = nutrients
    jsn.append(rec)

list(map(processRecipe, recipe1))
list(map(processRecipe, recipe2))
list(map(processRecipe, recipe3))

with open('data.json', 'w') as outfile:
    json.dump(jsn, outfile, indent=4)

recipe1.close()
recipe2.close()
recipe3.close()
