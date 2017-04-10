# The set of recipes
set recipe;

# The set of nutrients
set nutrient;

# The set of ingredience
set ingredient;

# Indicator to tell us that the recipe is chosen
var x{recipe} binary;

# Indicator to tell us that an ingredient is chosen
var y{ingredient} binary;

# The time taken to make the recipe
param ready_time{recipe};

#How many servings per recipe
param servings{recipe};

#The score the recipe gets on spoonacular, 0 - 100%
param score{recipe};

# The amount if nutrients found in a dish
param recipenutrient{recipe, nutrient} >= 0, default 0;

# The ingredients per dish and the number of them 
param recipeingredient{recipe, ingredient} >= 0, default 0;
param numberofingredient{d in recipe} := sum{i in ingredient: recipeingredient[d,i] > 0} 1;


subject to theplan: sum{d in recipe} x[d] = 3;

#Maximize the score of the recipes 
maximize theScore: sum{d in recipe} score[d] * x[d]

#Minimize number of ingredients 
#minimize nrofingredients: sum{i in ingredient} y[i];