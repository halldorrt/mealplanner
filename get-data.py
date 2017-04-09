import requests, json

head = {
    'X-Mashape-Key': 'U6zUrQL4DPmshnG9x4wQLENBtLSqp1DmAMOjsnsWniONti1T8h',
    'Accept' : 'application/json'
}

# recipeUrl = 'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/search?instructionsRequired=false&limitLicense=false&number=50&offset=200&query=pizza&type=main+course'

r = requests.get(recipeUrl, headers=head)
res = r.json()

with open('recipe-data.json', 'w') as outfile:
    json.dump(res, outfile, indent=4)

json_data=open('200-250-recipe-data.json').read()
data = json.loads(json_data)

ids = []
list(map(lambda x: ids.append(x['id']), data['results']))
idString = str(ids[0])
for i in range(1,len(ids)):
    idString = idString + '%2C' + str(ids[i])

# informationUrl = 'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/informationBulk?ids='+idString+'&includeNutrition=true';

r = requests.get(informationUrl, headers=head)

with open('200-250-info-data.json', 'w') as outfile:
    json.dump(r.json(), outfile, indent=4)
