# The set of recipes
set recipe;
set time;

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
param recipeingredient{recipe, ingredient} >= 0, default 0;

# For example: select 3 dishes
subject to theplan: sum{r in recipe} x[r] = 3;

#subject to MinLimit{a in recipe} : 3 >= x[a] >= 0;
#subject to MaxLimit{a in time, d in recipe}: x[a, d] <= 3;
	
maximize nutr {n in nutrient}: 
	sum{r in recipe} recipenutrient[r, n]  * x[r]; 
	 
#Maximize the score of the recipes 
minimize objfunction:
  - nutr
  - sum{r in recipe} score[r] * x[r]
  + sum{i in ingredient} y[i];
  