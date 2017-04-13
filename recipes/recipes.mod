# The set of recipes
set recipe;
set time;

# The set of nutrients
set nutrient;

# The set of ingredience
set ingredient;

# Indicator to tell us that the recipe is chosen
var x{time, recipe} binary, >=0;

# Indicator to tell us that an ingredient is chosen
var y{ingredient} binary;

# The time taken to make the recipe
param ready_time{recipe};

#Maxlimit of the recipes
param maxlimit{recipe};

#How many servings per recipe
param servings{recipe};

#The score the recipe gets on spoonacular, 0 - 100%
param score{recipe};

# The amount if nutrients found in a dish
param recipenutrient{recipe, nutrient} >= 0, default 0;

# The ingredients per dish and the number of them 
param recipeingredient{recipe, ingredient} >= 0, default 0;
param numberofingredient{d in recipe} := sum{i in ingredient: recipeingredient[d,i] > 0} 1;

# For example: select 90 dishes for 30 days
subject to theplan: sum{a in time,d in recipe} x[a, d] = 90;

subject to MaxLimit{a in time, d in recipe}: x[a, d] <= maxlimit[d]; 	
	

#Maximize the score of the recipes 
minimize objfunction:
  - sum{a in time, d in recipe} score[d] * x[a, d]
  + sum{i in ingredient} y[i]
  + sum{c in recipe} ready_time[c];
  
  
  
  